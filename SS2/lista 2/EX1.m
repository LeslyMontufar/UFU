clear all; clc;

% Invervalo a ser analisado - beep beep beep
ti = 0;
tf = 0.002;

% Sinal recebido
syms t real
x = 5*sin(2*pi*1000*t) + 2*cos(2*pi*3000*t) + 0.5*cos(2*pi*5000*t);
figure('Name', 'Receptor'); subplot(2,1,1); ezplot(x, [ti, tf])
title('Sinal Recebido');
set(gca,'FontSize',14);

% Conversor A/D: Amostragem
Fs = 15e3; % Fs > 2*Fmax_sinal (Teorema de Nyquist para evitar a amostragem)
Ts = 1/Fs; % esquece no tempo t
n = 0:Ts:tf/Ts; % eixo tempo amostrado

x_n = 5*sin(2*pi*1000*n/Fs) + 2*cos(2*pi*3000*n/Fs) + 0.5*cos(2*pi*5000*n/Fs);
subplot(2,1,2); plot(n, x_n);
title('Pós Conversor A/D com Fs=12kHz');
xlabel('$t$','Interpreter','LaTex','FontSize',18);
ylabel('$x[nT_s],x(t)$','Interpreter','LaTex','FontSize',18);
set(gca,'FontSize',14);




