close all;
clear all;

matPath = '/Users/sxing/Library/CloudStorage/OneDrive-Personal/2021_2/matlab/Connectivity/4.AD/'; % 图像库路径
% matoutPath = '/Users/sxing/Library/CloudStorage/OneDrive-Personal/2021_2/matlab/Connectivity/4.ADout/'; % 图像库路径
matDir = dir([matPath '*.mat']); % 遍历所有mat格式文件
numMat = length(matDir);
mat = zeros(360, 360, 24, 'single');
matt = zeros(360, 360, 24, 'single');
dpsw = zeros(1, numMat);

for i = 1:numMat
    mat(:, :, i) = load([matPath matDir(i).name]).result; %读取每个mat
end

for i = 1:numMat
    r(i) = assortativity_wei(mat(:, :, i), 0);
end
