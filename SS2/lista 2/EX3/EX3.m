clc; close all; clearvars;
% Dada a equação de diferenças
w=0:1e-3:pi;
s = 1j*w;
Hs = (10*s+5)./(s.^2+2*s+5);

figure; plot(w, 20*log10(abs(Hs)), 'linewidth',2, 'color', [0 0 0]);
title('Resposta em frequência');
xlabel('$\omega$','Interpreter','LaTex','FontSize',14);
ylabel('$|H(jw)|$ (dB)','Interpreter','LaTex','FontSize',14);
ax = gca; ax.FontSize=11; 
set(ax,'xtick', [0:1/4:1]); set(ax,'xlim',[0 1]);
set(ax,'xticklabel', {'0','\pi/4','\pi/2','2\pi/3','\pi'});

figure; ti=0; t_f=0.5; Fs=100;
h = ifft(Hs, t_f*Fs);
plot(0:1/Fs:t_f-1/Fs,20*log10(abs(h)));
title('Resposta ao impulso');
xlabel('$t$','Interpreter','LaTex','FontSize',14);
ylabel('$|h(t)|$','Interpreter','LaTex','FontSize',14);
ax = gca; ax.FontSize=11; 
grid minor;
