function result = CP_AHE(imageIn)
sizeIn = size(imageIn);
width = sizeIn(2);
height = sizeIn(1);

imageInComb = zeros(height, width*3);
imageInComb(:, 1:3:end) = imageIn(:, :, 1);
imageInComb(:, 2:3:end) = imageIn(:, :, 2);
imageInComb(:, 3:3:end) = imageIn(:, :, 3);

imageOutComb = adapthisteq(uint8(imageInComb));

imageOut = zeros(height, width, 3);
imageOut(:, :, 1) = imageOutComb(:, 1:3:end);
imageOut(:, :, 2) = imageOutComb(:, 2:3:end);
imageOut(:, :, 3) = imageOutComb(:, 3:3:end);
% figure,imshow([uint8(imageIn), uint8(imageOut)]);
%niqe(uint8(imageOut))
result = uint8(imageOut);
end