close all; clc;

figure('Name','Sinais básicos importantes');
t = -2:0.0000001:2;

subplot(311); 
plot(t, u(t),'linewidth',1.5,'color',[0 0 0]);
title('Sinal \it{u(t)}');
ylim([-0.5 1.5]);
grid on;

subplot(312); 
plot(t, rect(t),'linewidth',1.5,'color',[0 0 0]);
title('Sinal \it{\Pi(t)}');
ylim([-0.5 1.5]);
grid on;

subplot(313); 
plot(t, Delta(t),'linewidth',1.5,'color',[0 0 0]);
title('Sinal \it{\Delta(t)}');
ylim([-0.5 1.5]);
grid on;

% cd ..
% print('img/ex1-fig','-dpng');