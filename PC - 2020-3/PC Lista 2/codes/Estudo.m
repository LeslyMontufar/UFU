clc;
% syms t
Ts = 1e-9;
t = -3e-4:Ts:3e-4;
R1=220; R2=220; R3=10e3;

mt = 8*cos(5e3*2*pi*t);
ct = 10*cos(100e3*2*pi*t);
v1 = ct*(R2*R3/(R2+R3))/(R1+(R2*R3/(R2+R3))) + mt*(R1*R3/(R1+R3))/(R2+(R1*R3/(R1+R3)));
v2 = (v1>=0.3) .* (0.24*v1+0.015*v1.^2);

n = 2^nextpow2(length(v1)); % a fft trabalha melhor com potencias de 2
v1_fft = fft(v1,n).*2/n;
% v1_fft = v1_fft(1:n/2);
freqs = ((-n/2:1:n/2-1)/(n*Ts)); % o n*Ts divide o 1 tambem

v2_fft = fft(v2,n).*2/n;
% v2_fft = v2_fft(1:n/2);

R5 = 47; C = 130e-9; L = 20e-6;
ZL = 1j*2*pi*freqs*L; 
ZC = 1./(1j*2*pi*C*freqs);
ZL_ZC_paralelo = ZL.*ZC./(ZL+ZC);
Hjw = ZL_ZC_paralelo./(ZL_ZC_paralelo+R5);


y_fft = Hjw.*v2_fft;

y = ifft(y_fft,length(t));

f6 = figure('Name','Sinal de saída no tempo');
plot(t,abs(y),'linewidth',1,'color',[0 0 0]);
title('Sinal de saída \it{y(t)}');
% ylim([-1.8 1.8]);
grid on;

