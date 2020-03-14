clear all; close all; clc;

figure('Name','Sinais periódicos');
T = 6;
M = 3;
t = -M*T:0.01:M*T;
tT = 0:0.01:T;
y = exp(-abs(tT)/2).*sin(2*pi*tT).*rect((tT-2)/4);

yp=[];
for i=1:2*M
    yp = [yp(1:end-1) y];
end

plot(t,yp,'linewidth',1.5,'color',[0 0 0]);
xlim([-20 20]);
title('Sinal periódico');

E = energia(y, T);
fprintf('Energia: %g J\nPotência: %g W\n', E, E/T);

% cd ..
% print('img/ex3-sinal','-dpng');