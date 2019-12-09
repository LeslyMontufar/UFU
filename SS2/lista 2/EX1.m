clear all; clc; clear t_f

% Invervalo a ser analisado - beep beep beep
ti = 0;
t_f = 0.0018;
t_total = t_f-ti;

% Sinal recebido
syms t real
xt = 5*sin(2*pi*1000*t) + 2*cos(2*pi*3000*t) + 0.5*cos(2*pi*5000*t);
figure('Name', 'Receptor'); subplot(2,1,1); ezplot(xt, [ti, t_f]);
% title('Sinal Recebido', 'FontSize',14);
hold on;

% Amostragem
Fs = 20e3; % Fs > 2*Fmax_sinal (Teorema de Nyquist para evitar o aliasing)
Ts = 1/Fs; % esquece no tempo t
n = ti/Ts:1:t_f/Ts; % numero de amostras depende de [ti t_f]

x_n = 5*sin(2*pi*1000*n/Fs) + 2*cos(2*pi*3000*n/Fs) + 0.5*cos(2*pi*5000*n/Fs);

scatter(Ts.*n, x_n);
title('Sinal recebido pós amostragem com Fs=20kHz');
xlabel('$nT_s$','Interpreter','LaTex','FontSize',16);
ylabel('$x[nT_s]$','Interpreter','LaTex','FontSize',16);

% Espectro de frequencia do sinal amostrado
X = fft(x_n);
X_abs = abs(X);
X_phased = phase(X)*(180/pi);
w = n/(t_f-ti);% frequencia em Hz
subplot(2,1,2); stem(w, X_abs);
title('Análise do Espectro de Frequência do Sinal Digital');
set(gca,'FontSize',12);

% Projeto do filtro rejeita banda
freq_rejeitada = 3e3; 
w_rejeitada = 2*pi*freq_rejeitada/Fs; % Freq Digital equivalente
zero = 0.98*(cos(w_rejeitada)+ 1j*sin(w_rejeitada));
zeros = [zero; conj(zero)];
polo = 0.80*real(zero)+1j*imag(zero);
polos = [polo; conj(polo)];
complex_numbers = [zeros polos];

k = 0.2/(5 * 0.5); % nao possui amplitude superior a 0.2 de pico
% polyfit

[b, a] = zp2tf(zeros,polos,k);
% [b, a] = butter(1,20/(Fs/2));

Hz = tf(b,a, Ts);
% H_ganho = abs(Hz);
% H_phased = phase(Hz)*(180/pi);
%[H wH] = amostragem(Hz, Hz.variable, Fs, t_total);

figure('Name','Projeto do filtro rejeita banda'); 
subplot(3, 1, 1); polarplot(complex_numbers, '*');
title('Diagrama de polos e zeros do Filtro Seletivo');

subplot(3, 1, 2); impulse(Hz);
title('Espectro em freq da Resposta ao Impulso');
xlabel('$\omega$','Interpreter','LaTex','FontSize',14);
ylabel('$|H(jw)|$','Interpreter','LaTex','FontSize',14);
gca.XTick = 0:1e3:Fs;

subplot(3, 1, 3); stepplot(Hz);
% Temos o filtro projetado
% Para encontrar a saída filtrada tem-se:
% Y(jw)=H(jw)*X(jw)

Y = Hz .* X;
%Y_abs = abs(Y);
%Y_phased = phase(Y)*(180/pi);

figure('Name','Sinal Transmitido');
subplot(2, 1, 1); stem(w, Y);
title('Espectro em freq da saída');
xlabel('$\omega$','Interpreter','LaTex','FontSize',18);
ylabel('$|Y(jw)|$','Interpreter','LaTex','FontSize',18);

yt = ifft(Y_abs);
yt_abs = real(yt);
subplot(2, 1, 2); stem(n*Ts, yt_abs);
title('Espectro no tempo da saída');
xlabel('$t$','Interpreter','LaTex','FontSize',18);
ylabel('$y(t)$','Interpreter','LaTex','FontSize',18);

hold on;
xt_filtro_ideal = 5*sin(2*pi*1000*t) + 0.5*cos(2*pi*5000*t);
ezplot(xt_filtro_ideal, [ti, t_f]);

% Functions

function [s, w] = amostragem(sinal, var, Fs, ttotal)
    % CONVERSORAD (sinal, var, Fs)
    % sinal: em funcao de var
    % var: variavel de percurso analógico
    % Fs: freqûencia de amostragem desejada
    % ttotal: intervalo de tempo de tempo a ser amostrado
    
    s = strrep(sinal,var,'n/Fs');
    % s = str2func(['@(' var ')' s]);
    n = ti*Fs:1:t_f*Fs; % Ts=1/Fs
    w = n/ttotal;
    plot(w, s);
end
