close all;
clear all;

tic;
% ConnPath = detectPath(); % replace detectPath() with your path to Connectivity folder
ConnPath='D:\MATLAB\bin\connectivity\'
% matClasses=["0.HC" "1.EMCI" "3.LMCI" "4.AD"]
matClass = '0.HC';
matPath = [ConnPath matClass 'out' '\'];

matDir = dir([matPath 'dpswed*.mat']); % 遍历所有mat格式文件
numMat = length(matDir);

mat = zeros(360, 360, numMat, 'single');

for i = 1:numMat
    tmp = load([matPath matDir(i).name]);
    mat(:, :, i) = tmp.dpswed_mat; %读取每个mat
%     mat(:, :, i)=1./mat(:, :, i);
    [startIdx, endIdx] = regexp(matDir(i).name, 'ADNI[^.]+');
    matIdx = matDir(i).name(startIdx:endIdx);
    out(i).index = matIdx;
end

c = parcluster();
j = createJob(c);

for i = 1:numMat
    createTask(j, @pagerank_centrality, 1, {mat(:, :, i),0.85}); %TODO
end

submit(j);
wait(j);

taskoutput = fetchOutputs(j);
e = [taskoutput{:, 1}];

for i = 1:numMat
    out(i).value = e(:, i);
end

f = fopen(['C:\Users\LENOVO\Desktop\' matClass 'pagerank''.json'], 'w');
fprintf(f, '%s', jsonencode(out));

% 变异系数
%cv = std(e) / mean(e);
%save([path.Connectivity matClass 'out' '/stats']);
toc;
