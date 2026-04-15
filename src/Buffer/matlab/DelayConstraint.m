function [c, ceq] = DelayConstraint(W) % W è un vettore a due componenti rappresentante il sizing del secondo e terzo inverter che costituiscono il buffer

tau_nom = 8.28371; % Ritardo intrinseco inverter minimo senza carico [ps]
gammaD = 0.67; % Gamma_delay
Cload = 100; % Capacità di carico ottenuta utilizzando un inverter di dimensioni 50 volte l'inverter minimo
D0 = 250; % Vincolo sul ritardo [ps]

% Vincolo di uguaglianza espresso come ceq==0, per cui il ritardo potrà essere al più pari al vincolo imposto sul ritardo
ceq = tau_nom*(1 + W(1)/gammaD + 1 + W(2)/(gammaD*W(1)) + 1 + Cload/(gammaD*W(2))) - D0;
% Vincolo di disuguaglianza espresso come c<=0, per cui il secondo inverter non può essere più piccolo dell'inverter minimo
c = 1 - W(1); 

end