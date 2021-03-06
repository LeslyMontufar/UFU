close all; clc;

figure('Name','Sinais separados');
t = -2:0.01:3;

subplot(311);
plot(t, exp(-t),'linewidth',1.5,'color',[0 0 0]);
title('Sinal \it{e^{-t}}');
ylim([-2 3]);
grid on;

subplot(312);
plot(t, sin(6*pi*t),'linewidth',1.5,'color',[0 0 0]);
title('Sinal \it{sen(6\pi t)}');
ylim([-2 3]);
grid on;

subplot(313);
plot(t, u(t+1),'linewidth',1.5,'color',[0 0 0]);
title('Sinal \it{u(t+1)}');
ylim([-0.5 1.5]);
grid on;

figure('Name','Sinais multiplicados');
plot(t, exp(-t).*sin(6*pi*t).*u(t+1),'linewidth',1.5,'color',[0 0 0]);
title('Sinal \it{e^{-t}sen(6\pi t)u(t+1)}');
ylim([-3 3]);
grid on;

% cd ..
% print('-f1','img/ex2-separado','-dpng');
% print('-f2','img/ex2-mult','-dpng');