clear all;
clc;

leftImage = imread('apple.png');
rightImage = imread('orange.png');

iternum = 10;

if (size(leftImage) ~= size(rightImage))
    error('Input images are not the same size!')
end

% 预处理，使图片height,width为偶数
[rows, cols, channels] = size(leftImage);
leftImage = leftImage(1:rows, 1:cols, :);
rightImage = rightImage(1:rows, 1:cols, :);

% mask gaussian
mask = uint8(zeros(rows, cols, channels));
mask(1:floor(rows/2), 1:floor(cols/2), :) = ones(floor(rows/2), floor(cols/2), channels);
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
imwrite(blendImage, 'blendImage.png');

figure;
imshow(leftImage);
title('leftImage');
figure;
imshow(rightImage);
title('rightImage');
figure;
imshow('blendImage.png');
title('blendImage');




