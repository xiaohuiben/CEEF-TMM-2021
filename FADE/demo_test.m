clc;clear all;close all;
%%1
InputPath = '..\result\';
FileName = dir(strcat(InputPath, '*.png'));
%%2
FADE_Proposed = zeros(length(FileName), 1);
for k = 1:length(FileName)
    tempFileName = FileName(k).name;
    ImPath = strcat(InputPath, tempFileName);
    image = imread(ImPath);
    FADE_Proposed(k) = FADE(image);
end
save FADE_Proposed.mat