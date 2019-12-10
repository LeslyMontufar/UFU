clear all; clc;

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
ax = gca; ax.FontSize=12;

% Espectro de frequencia do sinal amostrado
X = fft(x_n); Nfft = length(n);
X_abs = abs(X);
X_phased = phase(X)*(180/pi);
w = n/(t_f-ti);% frequencia em Hz % usou Fs
subplot(2,1,2);
%stem(w, X_abs,'filled','black');
plot((0:Nfft-1)/Nfft*2-1, 20*log10(fftshift(abs(X))),'linewidth',2,'color',[0 0 0]);
title('Análise do Espectro de Frequência do Sinal Digital');
xlabel('$\omega$','Interpreter','LaTex','FontSize',14);
ylabel('$|X(e^{jw})|$ (dB)','Interpreter','LaTex','FontSize',14);
ax = gca; ax.FontSize=12; 
set(ax,'xtick', [0:1/4:1]); set(ax,'xlim',[0 1]);
set(ax,'xticklabel', {'0','\pi/4','\pi/2','2\pi/3','\pi'});

% Projeto do filtro rejeita banda
figure('Name','Projeto do filtro rejeita banda'); 
freq_rejeitada = 3e3; 
w_rejeitada = 2*pi*freq_rejeitada/Fs; % Freq Digital equivalente
erro = 2*pi*0.3e3/Fs;
zero = 0.9999*(cos(w_rejeitada)+ 1j*sin(w_rejeitada));
% um sistema estavel tem mais polos dq zeros
zeros = [zero; conj(zero)];
polo = 0.14*real(zero)+0.3j*imag(zero);
polo2 = 0.63*real(zero)+0.75j*imag(zero);
polos = [polo; conj(polo); polo2; conj(polo2)];
k = 0.2/(5+.5);
% [Hjw] = H(zeros, polos, k, w);
[b,a]=zp2tf(zeros,polos,1);
% Nfft = 512;
Hjw = k * fft(b,Nfft)./fft(a,Nfft);

subplot(2, 1, 1); polarplot([zeros; polos], '*');
title('Diagrama de polos e zeros do Filtro Seletivo');
subplot(2, 1, 2); 
% stem(w, abs(Hjw));
plot((0:Nfft-1)/Nfft*2-1, 20*log10(fftshift(abs(Hjw))),'linewidth',2,'color',[0 0 0]);

grid on    
title('Espectro em freq da Resposta ao Impulso');
xlabel('$\omega$','Interpreter','LaTex','FontSize',14);
ylabel('$|H(e^{jw})|$ (dB)','Interpreter','LaTex','FontSize',14);
ax = gca; ax.FontSize=12; 
set(ax,'xtick', [0:1/4:1]); set(ax,'xlim',[0 1]);
set(ax,'xticklabel', {'0','\pi/4','\pi/2','2\pi/3','\pi'});

% Para encontrar a saída filtrada tem-se:
Y = Hjw.* X;
Y_abs = abs(Y);
Y_phased = phase(Y)*(180/pi);

figure('Name','Sinal Transmitido');
subplot(2, 1, 1); %stem(w, Y_abs, 'filled','black');
plot((0:Nfft-1)/Nfft*2-1, 20*log10(fftshift(abs(Y))),'linewidth',2,'color',[0 0 0]);
title('Espectro em freq da saída');
xlabel('$\omega$','Interpreter','LaTex','FontSize',16);
ylabel('$|Y(e^{jw})|$','Interpreter','LaTex','FontSize',16);
ax = gca; ax.FontSize=12; 
set(ax,'xtick', [0:1/4:1]); set(ax,'xlim',[0 1]);
set(ax,'xticklabel', {'0','\pi/4','\pi/2','2\pi/3','\pi'});

yt = ifft(Y_abs);
yt_abs = real(yt);
subplot(2, 1, 2); stem(n*Ts, yt_abs);
hold on;
xt_filtro_ideal = k*(5*sin(2*pi*1000*t) + 0.5*cos(2*pi*5000*t));
ezplot(xt_filtro_ideal, [ti, t_f]);
title('Espectro no tempo da saída');
xlabel('$t$','Interpreter','LaTex','FontSize',16);
ylabel('$y(t)$','Interpreter','LaTex','FontSize',16);

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

function [Hjw] = H(zeros, polos, k, w)
    r = 1;
    Hjw = k;
    for ii = 1:length(zeros)
        Hjw = Hjw.*(1 - zeros(ii).*r.*exp(-1j*w));
    end
    for ii = 1:length(polos)
        Hjw = Hjw./(1 - polos(ii).*r.*exp(-1j*w));
    end
end