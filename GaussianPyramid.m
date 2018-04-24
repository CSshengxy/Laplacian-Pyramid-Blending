function pyramid=GaussianPyramid(image, iternum)
    gaussian_filter = [1, 4, 6, 4, 1]*(1/16);
    gaussian_filter = gaussian_filter' * gaussian_filter;
    
    pyramid = cell(iternum, 1);
    pyramid{1} = image;
    
    for i = 2 : iternum
        % gaussian filtering
        % imfilter ����rgbͼ���൱������ͨ���ֱ���,Ȼ�����cat����
        temp = imfilter(pyramid{i-1}, gaussian_filter, 'replicate');
        % down sampling
        rows = size(temp, 1);
        cols = size(temp, 2);
        temp = temp(1:2:rows, 1:2:cols, :);
        pyramid{i} = temp;
    end
    