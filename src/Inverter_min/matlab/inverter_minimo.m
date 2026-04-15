% Dimensionamento inverter minimo
% Confronto dei ritardi di salita e discesa al variare di Wp (larghezza PMOS)
% Si desidera determinare Wp affinché i ritardi siano pressocché uguali

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


%import delay rise
[name1,path1]=uigetfile('*txt','Seleziona il file delay_rise');
file1=[path1,name1];
delay_rise= readmatrix(file1, opts);


%import delay fall
[name2,path2]=uigetfile('*txt','Seleziona il file delay_fall');
file2=[path2,name2];
delay_fall= readmatrix(file2, opts);

Wp = 0.12e-6:0.01e-6:0.36e-6; % Variazione larghezza PMOS
Wp = Wp*10^6;

figure(1)
plot(Wp,delay_rise(:,2)*10^12,'.-',MarkerSize=15);
hold on
plot(Wp,delay_fall(:,2)*10^12,'.-',MarkerSize=15);
set(xlabel('W_p [\mum]'),'Interpreter','tex');
set (ylabel('Delay [ps]'), 'Interpreter','tex');
set(legend('rise delay', 'fall delay',Location='northwest'));

% Caloclo parametri modelli energia e delay utilizzando come carico dell'inverter minimo un altro inverter di dimensioni variabili

% Calcolo parametri per modello energia
Vdd = 1; % Tensione di alimentazione [V]
E_min = 0.512651e-15; % Energia consumata inverter minimo [W]
C_out_min = E_min/Vdd^2; % Capacitá intrinseca nodo d'uscita inverter minimo [F]
S2 = [1 2 3 4 5 6 7];
E_min_load = [1.04784e-15 1.60469e-15 2.16292e-15 2.71915e-15 3.27723e-15 3.83536e-15 4.39388e-15]; % Energia consumata dall'inverter minimo utilizzando come carico un altro inverter con S2 variabile [W]
C_in_min = E_min_load./(S2.*Vdd^2)-C_out_min./S2; % Capacitá d'ingresso inverter minimo al variare di S2 [F]
C_in_min_avg = mean(C_in_min); % Valore medio
gammaE_avg = C_out_min./C_in_min_avg;

% Calcolo parametri per modello ritardo
tau_nom = delay_rise(6,2); % Ritardo intrinseco inverter minimo senza carico (dovuto alla sola capacitá intrinseca d'uscita) [sec]
C_in2 = C_in_min.*S2; % Capacitá d'ingresso secondo inverter [F]
tau_min_load = [20.2273e-12 32.4884e-12 44.9175e-12 57.5002e-12 70.6071e-12 83.6309e-12 96.5804e-12]; % Ritardo inverter minimo utilizzando come carico un altro inverter con S2 variabile [sec]
tau_min_load_avg = mean(tau_min_load);
gammaD = (tau_nom.*S2)./(tau_min_load_avg-tau_nom);
gammaD_avg = mean(gammaD); % Valore medio

