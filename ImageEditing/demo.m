clc;clear all;close all;
InputPath = '.\input\';
FileName = dir(strcat(InputPath, '*.jpg'));
for k=1:length(FileName)
    tempFileName = FileName(k).name;
    ImPath = strcat(InputPath, tempFileName);
    img = imread(ImPath);
    %%
%     tic
    result = CP_AHE(img);
%     toc
    %%
    imwrite(result, [tempFileName(1:end-4), '_Proposed.png',]);
end