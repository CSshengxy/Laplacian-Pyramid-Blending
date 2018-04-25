function up_image=UpSampling(image)
    [rows, cols, channels] = size(image);
    up_image = double(zeros(rows*2, cols*2, channels));
    up_image(1:2:rows*2, 1:2:cols*2, :) = image;
%     up_image(2:2:rows*2, 2:2:cols*2, :) = image;
%     up_image(1:2:rows*2, 2:2:cols*2, :) = image;
%     up_image(2:2:rows*2, 1:2:cols*2, :) = image;