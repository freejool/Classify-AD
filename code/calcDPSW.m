close all;
clear all;

file = fileread('path.json');
% path.json is a file that contains the path to the 'Connectivity' folder
%           like   {
%                      "Connectivity":"C:/Users/Sxing/Develop/matlab/Connectivity/"
%                  }

% matClasses=['0.HC' '1.EMCI' '3.LMCI' '4.AD']
matClass='1.EMCI';
path = jsondecode(file);
matPath = [path.Connectivity matClass '/'];
matoutPath = [path.Connectivity matClass 'out/'];

%%% delete exist files
if exist([path.Connectivity matClass 'out/'],'dir')~=0
    rmdir([path.Connectivity matClass 'out/'],'s');
end
mkdir([path.Connectivity matClass 'out/']);
%%%

matDir = dir([matPath '*.mat']); % 遍历所有mat格式文件
numMat = length(matDir);
mat = zeros(360, 360, numMat, 'single');
matt = zeros(360, 360, numMat, 'single');
dpsw = zeros(1, numMat);

for i = 1:numMat
    tmp = load([matPath matDir(i).name]);
    mat(:, :, i) = tmp.result; %读取每个mat
end

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
