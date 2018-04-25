function image=LaplacianReconstruct(laplacian_pyramid)
    g_filter = [1, 4, 6, 4, 1]*(1/16);
    g_filter = g_filter' * g_filter * 4;

    laplacian_pyramid_copy = laplacian_pyramid;
    iternum = length(laplacian_pyramid_copy);
    for i = flip(2:iternum)
        temp = laplacian_pyramid_copy{i};
        temp = UpSampling(temp);
        rows = size(laplacian_pyramid_copy{i-1}, 1);
        cols = size(laplacian_pyramid_copy{i-1}, 2);
        temp = temp(1:rows, 1:cols, :);
        temp = imfilter(temp, g_filter, 'replicate');
        laplacian_pyramid_copy{i-1} = laplacian_pyramid_copy{i-1} + temp;
    end
    
    image = laplacian_pyramid_copy{1};
    