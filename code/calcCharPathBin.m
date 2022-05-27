close all;
clear all;
tic;
ConnPath = detectPath(); % replace detectPath() with your path to Connectivity folder

matClasses = ["0.HC" "1.EMCI" "3.LMCI" "4.AD"];

for c = 1:length(matClasses)
    matClass = char(matClasses(c));
    matPath = [ConnPath matClass 'out/'];

    matDir = dir([matPath 'dpswed*.mat']); % 遍历所有mat格式文件
    numMat = length(matDir);
    mat = zeros(360, 360, 'single');

    for i = 1:numMat
        mat = load([matPath matDir(i).name]).dpswed_mat; %读取每个mat
        mat = binarize(mat);
        dis = distance_bin(mat);
        charPath = charpath(dis, 0, 0);
        [startIdx, endIdx] = regexp(matDir(i).name, 'ADNI[^.]+');
        matIdx = matDir(i).name(startIdx:endIdx);
        out(i).index = matIdx;
        out(i).value = charPath;
    end

    if c == 1
        allout = struct(out);
    else
        allout(length(allout) + 1:length(allout) + length(out)) = out;
    end

end

f = fopen(['~/Desktop/' 'charpath' '.json'], 'w');
fprintf(f, '%s', jsonencode(allout));
toc;
