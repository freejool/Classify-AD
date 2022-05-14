close all;
clear all;

c = parcluster();
j = createJob(c);

for i = 1:10
    createTask(j, @myFun, 3, {i});
end

submit(j);
wait(j);

taskoutput = fetchOutputs(j);

function [a, b, c] = myFun(input)
    a = input + 1;
    b = input + 2;
    c = ones(1,100);
end
