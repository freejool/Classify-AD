close all;
clear all;

matPath = '/Users/sxing/Library/CloudStorage/OneDrive-Personal/2021_2/matlab/Connectivity/0.HCout/'; % 图像库路径

matDir = dir([matPath 'dpswed*.mat']); % 遍历所有mat格式文件
numMat = length(matDir);
mat=zeros(360,360,24,'single');


for i = 1:numMat
    mat(:,:,i) = load([matPath matDir(i).name]).dpswed_mat; %读取每个mat
end


c=parcluster();
j=createJob(c);

for i = 1:numMat
    createTask(j,@efficiency_wei,1,{mat(:,:,i)});
end

submit(j);
wait(j);

taskoutput=fetchOutputs(j);
e=mean([taskoutput{:,1}]);
