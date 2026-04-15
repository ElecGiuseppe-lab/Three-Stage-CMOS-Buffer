% Ottimizzazione curva energy-delay, in funzione del sizing degli inverter (simulazioni effettuate in LTspice)

clc
close all
clear all

% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [3, Inf];
opts.Delimiter = "\t";

% Specify column names and types
opts.VariableNames = ["1", "2", "3", "4"];
opts.VariableTypes = ["double", "double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";


%import delay Monte Carlo
[name1,path1]=uigetfile('*txt','Seleziona il file "delay" ');
file1=[path1,name1];
delay_MonteCarlo= readmatrix(file1, opts);

%import energy Monte Carlo
[name2,path2]=uigetfile('*txt','Seleziona il file "energy"');
file2=[path2,name2];
energy_MonteCarlo= readmatrix(file2, opts);

%import delay curva ottima
[name3,path3]=uigetfile('*txt','Seleziona il file "delay" ');
file3=[path3,name3];
delay_CurvaOttima= readmatrix(file3, opts);

%import energy curva ottima
[name4,path4]=uigetfile('*txt','Seleziona il file "energy"');
file4=[path4,name4];
energy_CurvaOttima= readmatrix(file4, opts);

figure(1)
plot(delay_MonteCarlo(:,2)*10^12,abs(energy_MonteCarlo(:,2))*10^12,'.',MarkerSize=22);
hold on
plot(delay_CurvaOttima(:,2)*10^12,abs(energy_CurvaOttima(:,2)*10^12),'g.',MarkerSize=22)
ylim([0.03 0.15]);
set(xlabel('Delay [ps]'),'Interpreter','tex');
set (ylabel('Energy [pW]'), 'Interpreter','tex');
set(legend('dots Monte Carlo','dots sensitivity analysis',Location='northeast'));

