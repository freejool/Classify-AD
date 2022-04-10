close all;
clear all;

matPath = '/Users/sxing/Library/CloudStorage/OneDrive-Personal/2021_2/matlab/Connectivity/3.LMCI/'; % 图像库路径
matoutPath = '/Users/sxing/Library/CloudStorage/OneDrive-Personal/2021_2/matlab/Connectivity/3.LMCIout/'; % 图像库路径
matDir = dir([matPath '*.mat']); % 遍历所有mat格式文件
numMat = length(matDir);
mat = zeros(360, 360, 24, 'single');
matt = zeros(360, 360, 24, 'single');
dpsw = zeros(1, numMat);

for i = 1:numMat
    tmp = load([matPath matDir(i).name]);
    mat(:, :, i) = tmp.result; %读取每个mat
end

% i=1;
% [dpsw(i),matt(:,:,i)]=calcPsw(mat(:,:,i));

c = parcluster();
j = createJob(c);

for i = 1:numMat
    createTask(j, @calcPsw, 2, {mat(:, :, i)});
end

submit(j);
wait(j);

taskoutput = fetchOutputs(j);
dpsws = [taskoutput{:, 1}];

for i = 1:length(taskoutput)
    dpswed_mat = taskoutput{i, 2};
    save([matoutPath 'dpswed' matDir(i).name(4:end)], 'dpswed_mat');
end

save([matoutPath 'dpsws'], 'dpsws');
