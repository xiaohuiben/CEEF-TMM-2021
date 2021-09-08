clc;clear all;close all;
InputPath = '.\InputImages\';
FileName = dir(strcat(InputPath, '*.png'));
for k=1:length(FileName)
    tempFileName = FileName(k).name;
    ImPath = strcat(InputPath, tempFileName);
    img = imread(ImPath);
    %%
%     tic
    result = im2uint8(CEEF(img));
%     toc
    %%
    imwrite(result, ['.\result\', tempFileName(1:end-4), '_Proposed.png',]);
end