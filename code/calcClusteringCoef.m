close all;
clear all;

ConnPath = detectPath(); % replace detectPath() with your path to Connectivity folder

% matClasses=["0.HC" "1.EMCI" "3.LMCI" "4.AD"]
matClass = '4.AD';
matPath = [ConnPath matClass 'out/'];

matDir = dir([matPath 'dpswed*.mat']); % 遍历所有mat格式文件
numMat = length(matDir);
mat = zeros(360, 360, 'single');

for i = 1:numMat
    mat = load([matPath matDir(i).name]).dpswed_mat; %读取每个mat

    coefVec = clustering_coef_wu(mat);
    coef = mean(coefVec);

    [startIdx, endIdx] = regexp(matDir(i).name, 'ADNI[^.]+');
    matIdx = matDir(i).name(startIdx:endIdx);
    out(i).index = matIdx;
    out(i).value = coef;
end

f = fopen('~/Desktop/a.json', 'w');
fprintf(f, '%s', jsonencode(out));
