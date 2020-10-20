%clc; close all; clearvars;
% Dada a equação de diferenças
Fs = 7;
w=0:1e-3:2*pi*Fs;
s = 1j*w;
Hs = (10*s+5)./(s.^2+2*s+5);
b = [10 5]; a = [1 2 5];

figure; plot(w/(2*pi), (abs(Hs)), 'linewidth',2, 'color', [0 0 0]);
title('Resposta em frequência');
xlabel('$\omega (rad/s)$','Interpreter','LaTex','FontSize',14);
ylabel('$|H(jw)|$','Interpreter','LaTex','FontSize',14);
ax = gca; ax.FontSize=11; 
grid on;

% Resposta ao impulso
figure; 
[h,t] = impulse(tf(b, a), 10);
plot(t, h);
title('Resposta ao impulso');
xlabel('$t$','Interpreter','LaTex','FontSize',14);
ylabel('$h(t)$ (rad/s)','Interpreter','LaTex','FontSize',14);
ax = gca; ax.FontSize=11; 
grid minor;

% Resposta ao degrau
figure;
[u,t] = step(tf(b, a), 10);
plot(t, u);
title('Resposta ao degrau unitário');
xlabel('$t$','Interpreter','LaTex','FontSize',14);
ylabel('$s(t)$','Interpreter','LaTex','FontSize',14);
ax = gca; ax.FontSize=11; 
grid minor;

