clear all; clc;

% Invervalo a ser analisado - beep beep beep
ti = 0;
tf = 0.0018;

% Sinal recebido
syms t real
x = 5*sin(2*pi*1000*t) + 2*cos(2*pi*3000*t) + 0.5*cos(2*pi*5000*t);
figure('Name', 'Receptor'); ezplot(x, [ti, tf])
title('Sinal Recebido', 'FontSize',14);
ylabel('$x(t)$','Interpreter','LaTex','FontSize',18); hold on;

% Conversor A/D: Amostragem
Fs = 15e3; % Fs > 2*Fmax_sinal (Teorema de Nyquist para evitar a amostragem)
Ts = 1/Fs; % esquece no tempo t
n = ti/Ts:1:tf/Ts; % numero de amostras depende de [ti tf]
t_sample = ti:Ts:length(n)*Ts;

x_n = 5*sin(2*pi*1000*n/Fs) + 2*cos(2*pi*3000*n/Fs) + 0.5*cos(2*pi*5000*n/Fs);
% Converteu o sinal em digital normalizando por /Fs

scatter(Ts.*n, x_n);
title('Pós Conversor A/D com Fs=15kHz');
xlabel('$n$','Interpreter','LaTex','FontSize',18);
ylabel('$x[nT_s]$','Interpreter','LaTex','FontSize',18);







