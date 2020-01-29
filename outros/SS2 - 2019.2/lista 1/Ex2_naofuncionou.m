clc;
clearvars;
close all;

% EXERCICIO 2
% A)
% syms t
% x(t) = 5*sin(2*pi*1000*t)+2*cos(2*pi*3000*t)+0.5*cos(2*pi*5000*t);
% f1=figure(); ezplot(x); saveas(f1, 'sinal_tempo.jpg');


clc; clear all;

%% prepara para gerar sinal:
Fs = 100000;
t = 1:1/Fs:0.1;
x(t) = 5*sin(2*pi*1000*t)+2*cos(2*pi*3000*t)+0.5*cos(2*pi*5000*t);

%% projeta filtro:
[n1, fo1, ao1, w1] = firpmord([2800 2900 3100 3200], [1 0 1], [0.01, 0.1, 0.01], Fs);
coeficientes_sistema1 = firpm(n1,fo1,ao1,w1);

[n2, fo2, ao2, w2] = firpmord([4800 4900 5100 5200], [1 0 1], [0.01, 0.1, 0.01], Fs);
coeficientes_sistema2 = firpm(n2,fo2,ao2,w2);

coefs_totais = coeficientes_sistema1 + coeficientes_sistema2;
% freqz(coefs_totais,1, Fs);

x_filtrado = filter(coefs_totais, 1, x);
subplot(2,1,1);
plot(x_filtrado);
title('Sinal filtrado x(t)'); xlabel('tempo (s)'); ylabel('Amplitude(linear)');

x_filtrado_espectro = fft(x_filtrado, Fs);
subplot(2,1,2);
plot(abs(x_filtrado_espectro)); title('Espectro filtrado x(t)'); xlabel('tempo (s)'); ylabel('Amplitude(linear)');