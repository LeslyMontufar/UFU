% OBS: Esse script está todo corrigido
%% Exercício 1
close all; clc;
% syms t
Ts = 1e-6;
t = -3e-4:Ts:3e-4;

f1 = figure('Name','Sinal modulante e portadora');
mt = 8*cos(5e3*2*pi*t);
ct = 10*cos(100e3*2*pi*t);

subplot(311); 
% fplot(mt, [-3e-4,3e-4],'linewidth',1.5,'color',[0 0 0]);
plot(t,mt,'linewidth',1.5,'color',[0 0 0]);
title('Sinal modulante \it{m(t)}');
ylim([-15 15]);
grid on;

subplot(312); 
% fplot(ct, [-3e-4,3e-4],'linewidth',1.5,'color',[0 0 0]);
plot(t, ct,'linewidth',1.5,'color',[0 0 0]);
title('Portadora de alta frequência \it{c(t)}');
ylim([-15 15]);
grid on;

subplot(313); 
% fplot(mt, [-3e-4,3e-4],'linewidth',1.5,'color',[1 0 0]);
plot(t,mt,'linewidth',1.5,'color',[1 0 0]);
hold on
% fplot(ct, [-3e-4,3e-4],'linewidth',1,'color',[0 0 0]);
plot(t,ct,'linewidth',1,'color',[0 0 0]);
title('Portadora e sinal modulante');
ylim([-15 15]);
grid on;

f2 = figure('Name','Sinal modulante e portadora');
R1=220; R2=220; R3=10e3;

% Pelo teorema da superporsição
v1 = ct*(R2*R3/(R2+R3))/(R1+(R2*R3/(R2+R3))) + mt*(R1*R3/(R1+R3))/(R2+(R1*R3/(R1+R3)));
% Usando a aproximação do comportamento do diodo
v2 = (v1>=0.3) .* (0.24*v1+0.015*v1.^2);

subplot(211);
plot(t,v1,'linewidth',1,'color',[0 0 0]);
title('Sinal na saída do somador \it{v_1(t)}');
ylim([-15 15]);
grid on;

subplot(212); 
plot(t,v2,'linewidth',1,'color',[0 0 0]);
title('Sinal da saída do diodo \it{v_2(t)}');
ylim([-1 4]);
grid on;


% Transformada de Fourier 
% n = 2^nextpow2(length(v1)); % a fft trabalha melhor com potencias de 2
n = length(t);
v1_fft = fftshift(fftn(v1)/n);
freqs = ((-n/2:1:n/2-1)/(n*Ts)); % o n*Ts divide o 1 tambem

v2_fft = fftshift(fftn(v2)/n);

% Filtro passa-faixa LC
R5 = 47; C = 130e-9; L = 20e-6;
ZL = 1j*2*pi*freqs*L; 
ZC = 1./(1j*2*pi*C*freqs);
ZL_ZC_paralelo = ZL.*ZC./(ZL+ZC);
Hjw = ZL_ZC_paralelo./(ZL_ZC_paralelo+R5);
Hjw(1,ceil(n/2)+1) = 0; % fica aterrado

f3 = figure('Name','Espectro em frequência de v1(t)');
plot(freqs(ceil(n/2)+1:end)/1e3,abs(v1_fft(ceil(n/2)+1:end)),'linewidth',1.5,'color',[0 0 0]);
title('Espectro de \it{v_1(t)}');
xlim([0 150]);
ylim([-0.1 5]);
xlabel('Frequência (kHz)')
ylabel('Amplitudes')
grid on;

f4 = figure('Name','Espectro em frequência de v2(t)');
plot(freqs(ceil(n/2)+1:end)/1e3,abs(v2_fft(ceil(n/2)+1:end)),'linewidth',1,'color',[0 0 0]);
hold on;
plot(freqs(ceil(n/2)+1:end)/1e3,abs(Hjw(ceil(n/2)+1:end)),'r--','linewidth',1.5);%,'color',[0 0 0]);
title('Espectro de \it{v_2(t)} e filtro passa-faixa');
xlim([0 500]);
ylim([-0.1 1.2]);
xlabel('Frequência (kHz)')
ylabel('Amplitudes')
grid on;

% Sinal de saída
y_fft = Hjw.*v2_fft;

f5 = figure('Name','Espectro do sinal de saída');
plot(freqs(ceil(n/2)+1:end)/1e3,abs(y_fft(ceil(n/2)+1:end)),'linewidth',1,'color',[0 0 0]);
title('Espectro do sinal de saída \it{y(t)}');
xlim([0 250]);
ylim([-0.1 1.2]);
xlabel('Frequência (kHz)');
ylabel('Amplitudes');
grid on;

% Transformada inversa
y = ifft(y_fft(ceil(n/2)+1:end),n)*n;


f6 = figure('Name','Sinal de saída no tempo');
plot(t,real(y),'linewidth',1,'color',[0 0 0]);
title('Sinal de saída \it{y(t)}');
xlim([-3e-4 3e-4]);
% ylim([-1.8 1.8]);
grid on;

% cd ..
% print(f1, 'img/ex1','-dpng');
% print(f2, 'img/ex1_v1_v2','-dpng');
% print(f3, 'img/ex1_espectro_v1','-dpng');
% print(f4, 'img/ex1_espectro_v2','-dpng');
% print(f5, 'img/ex1_espectro_saida','-dpng');
% print(f6, 'img/ex1_yt','-dpng');

%% Exercício 2
am = real(y);
clearvars -except am t Ts  
R1=1.2e3; R2=2.2e3; 

AV = -3/max(am); % amp op inversor
% AV = -(P1+R2)/R1 => P1 = abs(-AV*R1-R2)
P1 = abs(-AV*R1-R2);
fprintf('Valor do potenciômetro: %g ohms\n', P1);

v2 = AV * am;
v3 = (v2>0.3) .* v2;

f1 = figure('Name','Sinal na saída do diodo');
plot(t,v3,'linewidth',1,'color',[0 0 0]);
title('Sinal na saída do diodo \it{v_3(t)}');
% xlim([-3e-4 3e-4]);
ylim([-0.5 3.5]);
xlabel('Tempo (kHz)');
ylabel('Amplitude');
grid on;

% Transformada de Fourier 
n = length(t);
v3_fft = fftshift(fftn(v3)/n);
freqs = ((-n/2:1:n/2-1)/(n*Ts)); % o n*Ts divide o 1 tambem

R3 = 270; R4 = 2.7e3; C = 10e-9;
ZC = 1./(1j*2*pi*C*freqs);
Hjw = ZC./(R4+ZC);
Hjw(1,ceil(n/2)+1) = 1;

f2 = figure('Name','Espectro em frequência de v2(t)');
plot(freqs(ceil(n/2)+1:end)/1e3,abs(v3_fft(ceil(n/2)+1:end)),'linewidth',1,'color',[0 0 0]);
hold on;
plot(freqs(ceil(n/2)+1:end)/1e3,abs(Hjw(ceil(n/2)+1:end)),'r--','linewidth',1.5);%,'color',[0 0 0]);
title('Espectro de \it{v_2(t)} e filtro passa-baixa');
xlim([0 500]);
ylim([-0.1 1.2]);
xlabel('Frequência (kHz)');
ylabel('Amplitudes');
grid on;

% Sinal de saída
y_fft = Hjw.*v3_fft;

f3 = figure('Name','Espectro do sinal de saída');
plot(freqs(ceil(n/2)+1:end)/1e3,abs(y_fft(ceil(n/2)+1:end)),'linewidth',1,'color',[0 0 0]);
title('Espectro de saída do demodulador');
xlim([0 250]);
ylim([-0.1 0.8]);
xlabel('Frequência (kHz)');
ylabel('Amplitudes');
grid on;

% Transformada inversa
y = ifft(y_fft(ceil(n/2)+1:end),n)*n;

f4 = figure('Name','Sinal de saída no tempo');
plot(t,real(y),'linewidth',1,'color',[0 0 0]);
title('Sinal demodulado \it{y(t)}');
% ylim([-1.8 1.8]);
grid on;

% cd ..
% print(f1, 'img/ex2_diodo_3','-dpng');
% print(f2, 'img/ex2_espectro_diodo_3','-dpng');
% print(f3, 'img/ex2_espectro_saida_3','-dpng');
% print(f4, 'img/ex2_saida_3','-dpng');