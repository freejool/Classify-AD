close all;
% clear all;
clc;

matPath = 'C:\Users\Sxing\OneDrive\2021_2\matlab\Connectivity\0.HC\'; % 图像库路径
matDir = dir([matPath '*.mat']); % 遍历所有mat格式文件
numMat = length(matDir);

for i = 1:numMat
    mat(i) = load([matPath matDir(i).name]); %读取每个mat
end

c=parcluster();
j=createJob(c);

for i = 1:numMat
%thresholded=threshold_proportional(result(i).result,0.5);
    createTask(j,@efficiency_wei,1,{mat(i).result});
end
% submit(j);
% wait(j);
% 
% taskoutput=fetchOutputs(j);
% for i = 1:numMat
%     disp(taskoutput{i});
% end
% 
% disp(mean(e))
% 
% 
% t=createTask(j,@efficiency_wei,1,{result(1).result});
% submit(j);
% wait(j);
% taskoutput=fetchOutputs(j);
% disp(taskoutput{1});