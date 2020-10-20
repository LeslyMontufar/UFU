clc; clear all; close all;
% Desenvolvido no documento tem-se:
r = 1; w = 0:1e-3:pi;
z = r.*exp(1j.*w);
Hz = (1 + 0.25*z.^(-1) + 0.125*z.^(-2))./(1 - 1*z.^(-1) + 0.25*z.^(-2));
Nfft = length(w);
figure('Name', 'Reposta ao impulso');
plot(w, 20*log10((abs(Hz))),'linewidth',2, 'color', [0 0 0]);
grid on;    
title('Espectro em Frequência');
xlabel('$\omega$','Interpreter','LaTex','FontSize',14);
ylabel('$|H(e^{jw})|$ (dB)','Interpreter','LaTex','FontSize',14);
ax = gca; ax.FontSize=11; 
set(ax,'xtick', [0:1/4:1]); set(ax,'xlim',[0 1]);
set(ax,'xticklabel', {'0','\pi/4','\pi/2','2\pi/3','\pi'});

% Estabilidade do sistema
[zeros,p,k]=tf2zp([1 0.25 0.125], [1 -1 0.25]);
for i=1:length(p)
   estavel = (p<=1);
   if length(p)<length(zeros) estavel=0; end 
   if estavel == 0 break; end
end

if estavel fprintf('Sistema estável!\n');  
else fprintf('Sistema instável!\n'); end
%p'

% Resposta ao degrau
figure('Name', 'Reposta ao degrau');
Uz = 1./(1-z.^(-1));
Y = Uz.*Hz;
subplot(121); plot(w, 20*log10(abs(Y)), 'linewidth',2, 'color', [0 0 0]);
grid on;    
title('Resposta ao degrau na frequência');
xlabel('$\omega$','Interpreter','LaTex','FontSize',14);
ylabel('$|Y(e^{jw})|$ (dB)','Interpreter','LaTex','FontSize',14);
ax = gca; ax.FontSize=11; 
set(ax,'xtick', [0:1/4:1]); set(ax,'xlim',[0 1]);
set(ax,'xticklabel', {'0','\pi/4','\pi/2','2\pi/3','\pi'});

y = eqdif([1 0.25 0.125], [1 -1 0.25], ones(1, 80));
subplot(122); plot(0:length(y)-1, abs(y), 'linewidth',2, 'color', [0 0 0]);
title('Espectro no tempo da saída');
xlabel('$t$','Interpreter','LaTex','FontSize',16);
ylabel('$y(t)$','Interpreter','LaTex','FontSize',16);
ylim([0 6]);
ax = gca; ax.FontSize=11;
grid on;

function [y_n] = eqdif(b, a, x_n)
    % EQDIF determina a saida por meio da eq de diferencas
    
    % y_n(0)=0; matlab nao aceita
    for n=1:length(x_n)
        y_n(n) = 0; ia=2; 
        while ia<=n
            y_n(n) = y_n(n) - a(ia)*y_n(n-(ia-1));
            ia = ia+1;
            if ia > length(a) break; end
        end
        ib = 1;
        while (n-1)-(ib-1)>=0 % pensar no básico
            y_n(n) = y_n(n) + b(ib)*x_n(n-(ib-1));
            ib = ib+1;
            if ib > length(b) break; end
        end
        y_n(n) = y_n(n)/a(1);
    end
end
