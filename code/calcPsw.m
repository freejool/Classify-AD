function [psw, thresholdedM] = calcPsw(M)
    %CALCPSW Summary of this function goes here
    %   Detailed explanation goes here
    % input: M
    %               the matrix to calc
    % output: psw
    %               the psw to maxmize gce
    %         thresholdedM
    %               the matrix after thresholding

    E = zeros(1, 20);
    gce = zeros(1, 20);

    psws = 0.01:0.05:1;

    for p = 1:length(psws)
        E(p) = efficiency_wei(threshold_proportional(M, psws(p)));
        %计算当前阈值下稀疏化矩阵的全局效率
        gce(p) = E(p) - psws(p);
    end

    maxI = 1;

    for i = 2:length(gce)

        if gce(i) > gce(maxI)
            maxI = i;
        end

    end

    figure();
    plot(gce);

    psw = psws(maxI);
    thresholdedM = threshold_proportional(M, psws(maxI));
end
