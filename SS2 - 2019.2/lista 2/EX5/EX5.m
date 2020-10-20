clc; clearvars; close all;
t = [0 0.1:0.1:0.5 1:0.5:3 4 6];
y = [0 0.005 0.034 0.085 0.140 0.215 0.510 0.7 0.817 0.89 0.932 0.975 1];

% Modelo exponencial
modelo = @(x,t) x(1)*exp(x(2)*t) + x(3)*exp(x(4)*t) + x(5)*exp(x(6)*t); 

x0 = [5, -2, 5, -4, 1, -2];
x = lsqcurvefit(modelo, x0, t, y);

figure('Name', 'Dados experimentais');
scatter(t, y, 'o');
hold on;
times = linspace(t(1), t(end));
plot(t,y,'ko',times,modelo(x,times),'b-');
title('Comportamento Matemático');
xlabel('$t$','Interpreter','LaTex','FontSize',14);
ylabel('$y(t)$','Interpreter','LaTex','FontSize',14);
ax = gca; ax.FontSize=11; 
grid minor;

% Comportamento em frequência
w=0:1e-3:pi;
Nfft = length(w);
Y = fft(modelo(x, times), Nfft);
figure('Name', 'Comportamento em frequêcia');
plot((0:Nfft-1)/Nfft*2-1, 20*log10(fftshift(abs(Y))),'linewidth',2,'color',[0 0 0]);
grid on;    
title('Comportamento em Frequência');
xlabel('$\omega$','Interpreter','LaTex','FontSize',14);
ylabel('$|Y(e^{jw})|$ (dB)','Interpreter','LaTex','FontSize',14);
ax = gca; ax.FontSize=11; 
set(ax,'xtick', [0:1/4:1]); set(ax,'xlim',[0 1]);
set(ax,'xticklabel', {'0','\pi/4','\pi/2','2\pi/3','\pi'});
