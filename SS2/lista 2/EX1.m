clear all; clc;

% Invervalo a ser analisado - beep beep beep
ti = 0;
tf = 0.0018;
t_total = tf-ti;

% Sinal recebido
syms t real
xt = 5*sin(2*pi*1000*t) + 2*cos(2*pi*3000*t) + 0.5*cos(2*pi*5000*t);
figure('Name', 'Receptor'); subplot(2,1,1); ezplot(xt, [ti, tf])
title('Sinal Recebido', 'FontSize',14);
hold on;

% Conversor A/D: Amostragem
Fs = 20e3; % Fs > 2*Fmax_sinal (Teorema de Nyquist para evitar a amostragem)
Ts = 1/Fs; % esquece no tempo t
n = ti/Ts:1:tf/Ts; % numero de amostras depende de [ti tf]
t_sample = ti:Ts:length(n)*Ts;

x_n = 5*sin(2*pi*1000*n/Fs) + 2*cos(2*pi*3000*n/Fs) + 0.5*cos(2*pi*5000*n/Fs);
% Converteu o sinal em digital normalizando por /Fs

scatter(Ts.*n, x_n);
title('Pós Conversor A/D com Fs=15kHz');
xlabel('$nT_s$','Interpreter','LaTex','FontSize',18);
ylabel('$x[nT_s]$','Interpreter','LaTex','FontSize',18);

% Espectro de frequencia do sinal amostrado
X = fft(x_n);
X_abs = abs(X);
X_phased = phase(X)*(180/pi);
w = n/(tf-ti);% frequencia em Hz
subplot(2,1,2); stem(w, X_abs);
title('Análise do Espectro de Frequência do Sinal Digital');
set(gca,'FontSize',12);

% Projeto do filtro rejeita banda
H_ganho = ones(1, length(n));
erro = 0.5e3;
freq_rejeitada = 3e3; % para voltar para a escala do discreto divide pelo tempo total analisado
H_ganho(round((freq_rejeitada-erro)*t_total):round((freq_rejeitada+erro)*t_total)) = 0;
figure('Name','Projeto do filtro rejeita banda'); stem(w, H_ganho);
title('Espectro em freq da Resposta ao Impulso');
xlabel('$\omega$','Interpreter','LaTex','FontSize',18);
ylabel('$|H(jw)|$','Interpreter','LaTex','FontSize',18);

% Temos o filtro projetado
% Para encontrar a saída filtrada tem-se:
% Y(jw)=H(jw)*X(jw)

% em modulo: |Y(jw)|=|H(jw)|*|X(jw)|
Y_abs = H_ganho.*X_abs;
figure('Name','Sinal Transmitido');
subplot(2, 1, 1); stem(w, Y_abs);
title('Espectro em freq da saída');
xlabel('$\omega$','Interpreter','LaTex','FontSize',18);
ylabel('$|Y(jw)|$','Interpreter','LaTex','FontSize',18);

% nao vejo necessidade em defasar o sinal (ainda)
yt = ifft(Y_abs);
yt_abs = real(yt);
subplot(2, 1, 2); stem(n*Ts+7*Ts, yt_abs);
title('Espectro no tempo da saída');
xlabel('$t$','Interpreter','LaTex','FontSize',18);
ylabel('$y(t)$','Interpreter','LaTex','FontSize',18);

hold on;
xt_filtro_ideal = 5*sin(2*pi*1000*t) + 0.5*cos(2*pi*5000*t);
ezplot(xt_filtro_ideal, [ti, tf]);

% observando o filtro ideal, eh necessario defasar o sinal
% 

