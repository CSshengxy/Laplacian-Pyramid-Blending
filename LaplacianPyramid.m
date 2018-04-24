function pyramid=LaplacianPyramid(image, iternum)
    h_filter = [1, 4, 6, 4, 1]*(1/16);
    h_filter = h_filter' * h_filter;
    g_filter = h_filter;
    
    pyramid = cell(iternum, 1);
    handle_image = image;
    
    for i = 1:iternum - 1
        % º∆À„I[i+1]
        temp = imfilter(handle_image, h_filter, 'replicate');
        [rows, cols, channels] = size(temp);
        if channels == 3
            temp = temp(1:2:rows, 1:2:cols, :);
        else
            temp = temp(1:2:rows, 1:2:cols);
        end
        origin_image = handle_image;
        handle_image = temp;
        % º∆À„EI[i+1]
        temp = uint8(zeros(rows, cols, channels));
        if channels == 3
            temp(1:2:rows, 1:2:cols, :) = handle_image;
            temp(2:2:rows, 2:2:cols, :) = handle_image;
            temp(1:2:rows, 2:2:cols, :) = handle_image;
            temp(2:2:rows, 1:2:cols, :) = handle_image;
        else
            temp(1:2:rows, 1:2:cols) = handle_image;
            temp(2:2:rows, 2:2:cols) = handle_image;
            temp(1:2:rows, 2:2:cols) = handle_image;
            temp(2:2:rows, 1:2:cols) = handle_image;
        end
        temp = imfilter(temp, g_filter, 'replicate');
        e_handle_image = temp;
        % º∆À„b[i]
        pyramid{i} = origin_image - e_handle_image;
    end
    pyramid{iternum} = handle_image;
    
    