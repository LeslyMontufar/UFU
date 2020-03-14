clear all; close all; clc;

figure('Name','Sinais peri�dicos');
T = 6;
M = 3;
t = -M*T:0.01:M*T;

yp=[];
for i=1:2*M
    yp = [yp(1:end-1) y(0:0.01:T)];
end

plot(t,yp,'linewidth',1.5,'color',[0 0 0]);
xlim([-20 20]);
title('Sinal peri�dico');

E = energia(y, T);
fprintf('Energia: %g J\nPot�ncia: %g W\n', E, E/T);

% cd ..
% print('img/ex3-sinal','-dpng');

function out = y(t)
    out = exp(-abs(t)/2).*sin(2*pi*t).*rect((t-2)/4);
end