clear all; close all; clc;

figure('Name','Sinais periódicos');
T = 6;
M = 3;
Dt = 0.002; % Fs = 500
Fs = 1/Dt;
t = 0:Dt:T-Dt;
y = exp(-abs(t)/2).*sin(2*pi*t).*rect((t-2)/4);

time = [];
yp = [];
for i=-M:M-1 % -M -M+1 ..(-1) 0(=-M+3) -M+4 -M+5=M-1
    time = [time i*T+t];
    yp = [yp y];
end
plot(time,yp,'linewidth',1.5,'color',[0 0 0]);
xlim([-20 20]);
title('Sinal periódico');
grid on;

e = sum(abs(y).^2)*Dt; % a integral para sinal discreto eh a soma de Riemann
fprintf('Energia: %g \nPotência: %g \n', e, e/T);
% potencia eh energia consumida por unidade de tempo

% cd ..
% print('img/ex3-sinal','-dpng');