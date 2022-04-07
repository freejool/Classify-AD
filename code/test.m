close all;

clc;

matPath = 'C:\Users\Sxing\OneDrive\2021_2\matlab\Connectivity\0.HC\'; % 图像库路径
matDir = dir([matPath '*.mat']); % 遍历所有mat格式文件
numMat = length(matDir);

for i = 1:length(