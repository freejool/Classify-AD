close all;
clear all;

tic;
ConnPath = detectPath(); % replace detectPath() with your path to Connectivity folder

% matClasses=["0.HC" "1.EMCI" "3.LMCI" "4.AD"]
matClass = '4.AD';
matPath = [ConnPath matClass 'out' '/'];

matDir = dir([matPath 'dpswed*.mat']); % 遍历所有mat格式文件
numMat = length(matDir);

mat = zeros(360, 360, numMat, 'single');

for i = 1:numMat
    tmp = load([matPath matDir(i).name]);
    mat(:, :, i) = tmp.dpswed_mat; %读取每个mat
    [startIdx, endIdx] = regexp(matDir(i).name, 'ADNI[^.]+');
    matIdx = matDir(i).name(startIdx:endIdx);
    out(i).index = matIdx;
end

c = parcluster();
j = createJob(c);

for i = 1:numMat
    createTask(j, @efficiency_wei, 1, {mat(:, :, i), 2}); %TODO
end

submit(j);
wait(j);

taskoutput = fetchOutputs(j);
e = [taskoutput{:, 1}];

for i = 1:numMat
    out(i).value = e(:, i);
end

f = fopen(['~/Desktop/' matClass '.json'], 'w');
fprintf(f, '%s', jsonencode(out));

% 变异系数
%cv = std(e) / mean(e);
%save([path.Connectivity matClass 'out' '/stats']);
toc;
