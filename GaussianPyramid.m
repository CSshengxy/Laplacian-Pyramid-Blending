function pyramid=GaussianPyramid(image, iternum)
    gaussian_filter = [1, 4, 6, 4, 1]*(1/16);
    gaussian_filter = gaussian_filter' * gaussian_filter;
    
    pyramid = cell(iternum, 1);
    pyramid{1} = image;
    
    for i = 2 : iternum
        % gaussian filtering
        temp = imfilter(pyramid{i-1}, gaussian_filter, 'replicate');
        % down sampling
        [row, col] = size(temp);
        temp = temp(1:2:row, 1:2:col);
        pyramid{i} = temp;
    end
    