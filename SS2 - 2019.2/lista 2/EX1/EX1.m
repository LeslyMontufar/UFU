clear all; close all; clc;

% Invervalo a ser analisado - beep beep beep
ti = 0;
t_f = 0.0018;
t_total = t_f-ti;

% Sinal recebido
syms t real
xt = 5*sin(2*pi*1000*t) + 2*cos(2*pi*3000*t) + 0.5*cos(2*pi*5000*t);

% Amostragem
Fs = 20e3; % Fs > 2*Fmax_sinal (Teorema de Nyquist para evitar o aliasing)
Ts = 1/Fs; 
figure('Name', 'Receptor');
subplot(2, 1, 1);
[x_n, n] = figure_amostragem('$nT_s$','$x[nT_s]$', xt, t, Fs, ti, t_f);
title(strcat('Sinal recebido pós amostragem com Fs=', string(Fs/1e3), 'kHz'));
ax = gca; ax.FontSize=11;

% Espectro de frequencia do sinal amostrado
X = fft(x_n); Nfft = length(n);
X_abs = abs(X);
X_phased = phase(X)*(180/pi);
w = (pi/Fs)*n/(t_f-ti); % frequencia digital 0:pi com mesmo numero de amostra que n
subplot(2,1,2);
stem((0:Nfft-1)/Nfft*2-1, 20*log10(fftshift(abs(X))),'linewidth',2,'color',[0 0 0]);
title('Análise do Espectro de Frequência do Sinal de Entrada');
xlabel('$\omega$','Interpreter','LaTex','FontSize',14);
ylabel('$|X(e^{jw})|$ (dB)','Interpreter','LaTex','FontSize',14);
ax = gca; ax.FontSize=11; 
set(ax,'xtick', [0:1/4:1]); set(ax,'xlim',[0 1]);
set(ax,'xticklabel', {'0','\pi/4','\pi/2','2\pi/3','\pi'});

% Projeto do filtro rejeita banda
p_filtro = figure('Name','Projeto do filtro rejeita banda'); 
freq_rejeitada = 3e3; 
w_rejeitada = 2*pi*freq_rejeitada/Fs; % Freq Digital equivalente
zero = 0.9999*(cos(w_rejeitada)+ 1j*sin(w_rejeitada));
zeros = [zero; conj(zero)];
polo = 0.14*real(zero)+0.3j*imag(zero);
polo2 = 0.63*real(zero)+0.75j*imag(zero);
polos = [polo; conj(polo); polo2; conj(polo2)]; 
% um sist estável possui mais polos dq zeros

k = 0.2/(5+.5);
[b,a]=zp2tf(zeros,polos,k);
Hjw = fft(b,Nfft)./fft(a,Nfft);

subplot(2, 1, 1); polarplot([polos], '*');
hold on; polarplot([zeros], 'o'); ax = gca; ax.FontSize=11; 
title('Diagrama de polos e zeros do Filtro Seletivo');
subplot(2, 1, 2); 
stem((0:Nfft-1)/Nfft*2-1, 20*log10(fftshift(abs(Hjw))),'linewidth',2,'color',[0 0 0]);
grid on;    
title('Espectro em freq da Resposta ao Impulso');
xlabel('$\omega$','Interpreter','LaTex','FontSize',14);
ylabel('$|H(e^{jw})|$ (dB)','Interpreter','LaTex','FontSize',14);
ax = gca; ax.FontSize=11; 
set(ax,'xtick', [0:1/4:1]); set(ax,'xlim',[0 1]);
set(ax,'xticklabel', {'0','\pi/4','\pi/2','2\pi/3','\pi'});

% Para encontrar a saída filtrada tem-se:
Y = Hjw.* X;
Y_abs = abs(Y);
Y_phased = phase(Y)*(180/pi);

figure('Name','Sinal Transmitido');
subplot(2, 1, 1);
stem((0:Nfft-1)/Nfft*2-1, 20*log10(fftshift(abs(Y))),'linewidth',2,'color',[0 0 0]);
title('Espectro em frequência da saída');
xlabel('$\omega$','Interpreter','LaTex','FontSize',16);
ylabel('$|Y(e^{jw})|$','Interpreter','LaTex','FontSize',16);
ax = gca; ax.FontSize=11; 
set(ax,'xtick', [0:1/4:1]); set(ax,'xlim',[0 1]);
set(ax,'xticklabel', {'0','\pi/4','\pi/2','2\pi/3','\pi'});

yt = ifft(Y);
yt_abs = real(yt);
subplot(2, 1, 2); stem(n*Ts, yt_abs);
title('Espectro no tempo da saída');
xlabel('$t$','Interpreter','LaTex','FontSize',16);
ylabel('$y(t)$','Interpreter','LaTex','FontSize',16);
ax = gca; ax.FontSize=11; 


% Pelo laço for

% a(1) y[n] = - a(1+1) y[n-1] - a(2+1) y[n-2] - a(3-1) y[n-3] ...
%        b(1) x[n-0] + b(2) x[n-1] + ... 
y_n = eqdif(b, a, x_n);
figure; stem(n*Ts, y_n);
title('Sinal de saída y[n]');
xlabel('$t$','Interpreter','LaTex','FontSize',16);
ylabel('$y[n]$','Interpreter','LaTex','FontSize',16);
ax = gca; ax.FontSize=11;
grid minor;

% Functions

function [s, n] = amostragem(sinal, var, Fs, ti, t_f)
    % AMOSTRAGEM (sinal, var, Fs, ti, t_f)
    % sinal: em funcao de var
    % var: variavel de percurso analógico
    % Fs: frequencia de amostragem desejada
    % ti: tempo inicial
    % t_f: tempo final
    
    n = ti*Fs:1:t_f*Fs; % Ts=1/Fs
    s = eval(strrep(string(sinal),char(var),'n/Fs'));
end

function [s_n, n]= figure_amostragem(x_label, y_label, sinal, var, Fs, ti, t_f)
    % FIGURE_AMOSTRAGEM (x_label, y_label, sinal, var, Fs, ti, t_f)
    % x_label: str
    % y_label: str
    % sinal: em funcao de var
    % var: variavel de percurso analógico
    % Fs: frequencia de amostragem desejada
    % ti: tempo inicial
    % t_f: tempo final
    
    [s_n, n] = amostragem(sinal, var, Fs, ti, t_f);
    ezplot(sinal, [ti t_f]);
    hold on;
    scatter(n/Fs, s_n);
    xlabel(x_label,'Interpreter','LaTex','FontSize',16);
    ylabel(y_label,'Interpreter','LaTex','FontSize',16);
end

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

