close all;
clear all;

tic;
% ConnPath = detectPath(); % replace detectPath() with your path to Connectivity folder
ConnPath = detectPath();
matClasses = ["0.HC" "1.EMCI" "3.LMCI" "4.AD"];

for c = 1:length(matClasses)

    matClass = char(matClasses(c));
    matPath = [ConnPath matClass 'out' '/'];

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
        createTask(j, @degrees_dir, 3, {mat(:, :, i)}); %TODO
    end

    submit(j);
    wait(j);

    taskoutput = fetchOutputs(j);
    e = vertcat(taskoutput{:, 3});

    for i = 1:numMat
        out(i).value = e(i, :);
    end

    if c == 1
        allout = struct(out);
    else
        allout(length(allout) + 1:length(allout) + length(out)) = out;
    end

end

f = fopen(['~/Desktop' 'degree''.json'], 'w');
fprintf(f, '%s', jsonencode(out));
fclose(f);
toc;
