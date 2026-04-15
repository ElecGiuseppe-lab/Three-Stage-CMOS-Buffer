function [res] = Energy(W)

gammaE = 0.93;
Vdd = 1;
C_min = 0.54915; % [fF]
Cload = 100;
res = C_min*Vdd*Vdd*(gammaE + (1+gammaE)*W(1) + (1+gammaE)*W(2) + Cload);

end