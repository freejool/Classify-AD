close all;
clear all;

ConnPath = detectPath(); % replace detectPath() with your path to Connectivity folder

% matClasses=["0.HC" "1.EMCI" "3.LMCI" "4.AD"]
matClass = '3.LMCI';
matPath = [ConnPath matClass 'out' '/'];

matDir = dir([matPath 'dpswed*.mat']); % 遍历所有mat格式文件
numMat = length(matDir);

mat = zeros(360, 360, numMat, 'single');

for i = 1:numMat
    tmp = load([matPath matDir(i).name]);
    mat(:, :, i) = tmp.dpswed_mat; %读取每个mat
end

c = parcluster();
j = createJob(c);

for i = 1:numMat
    createTask(j, @efficiency_wei, 1, {mat(:, :, i)});
end

submit(j);
wait(j);

taskoutput = fetchOutputs(j);
e = [taskoutput{:, 1}];
% 变异系数
cv = std(e) / mean(e);
save([path.Connectivity matClass 'out' '/stats']);
