clear all; close all; clc;
% Do *sinal* se ve a maior freq para se determinar Fs
% Amostragem (Conversor A/D) do sinal com Fs=12e3 pelo teorema de Nyquist (para evitar Aliasing - distorcao pos amostragem)
Fs = 12e3;
Ts = 1/Fs;

tini = 0;
tf = 0.01;
t = ti:Ts:tf;

% mas sabe-se que t = n*Ts
% logo, nesse intervalo ter� n=t/Ts=tf/(1/Fs)=tf*Fs amostras
% n = 0:tf*Fs; ou:
n = t/Ts; % n = t*Fs;

% Sinal a ser discretizado
x_t = 5*sin(2*pi*1000*t) + 2*cos(2*pi*3000*t) + 0.5*cos(2*pi*5000*t);
plot(t, x_t);

% Sinal discretizado


% Espectro na freq por meio da fft
w = 0:Fs; 

set(gca,'FontSize',16);




