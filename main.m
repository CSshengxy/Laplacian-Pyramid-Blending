clear all;
clc;

leftImage = double(imread('apple.png'));
rightImage = double(imread('orange.png'));

iternum = 5;

if (size(leftImage) ~= size(rightImage))
    error('Input images are not the same size!')
end

% 预处理，使图片height,width为偶数
[rows, cols, channels] = size(leftImage);

% mask gaussian
mask = double(zeros(rows, cols, channels));
mask(:, 1:floor(cols/2), :) = ones(rows, floor(cols/2), channels);
mask_pyramid = GaussianPyramid(mask, iternum);


% leftImage pyramid and rightImage pyramid
left_pyramid = LaplacianPyramid(leftImage, iternum);
right_pyramid = LaplacianPyramid(rightImage, iternum);

% TODO: get blend laplacian pyramid
blend_pyramid = cell(iternum, 1);
for i = 1:iternum
    blend_pyramid{i} = left_pyramid{i} .* mask_pyramid{i} + right_pyramid{i} .* (1 - mask_pyramid{i});
end

% reconstruct the blend image
blendImage = LaplacianReconstruct(blend_pyramid);
imwrite(uint8(blendImage), 'blendImage.png');

figure;
imshow(uint8(leftImage));
title('leftImage');
figure;
imshow(uint8(rightImage));
title('rightImage');
figure;
imshow('blendImage.png');
title('blendImage');




