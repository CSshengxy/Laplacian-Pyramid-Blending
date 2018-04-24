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
        [rows, cols, channels] = size(temp);
        if channels == 3
            temp = temp(1:2:rows, 1:2:cols, :);
        else
            temp = temp(1:2:rows, 1:2:cols);
        end
        pyramid{i} = temp;
    end
    