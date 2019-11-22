clear; clc; close all;

%% PASSO 1: importa a musica e mostra seu espectro
[sinal, Fs] = audioread('sinal_questao4.wav');

%% PASSO 2: plota espectro (caso voce queira ver)
numero_amostras_sinal = length(sinal);
eixo_n = (0:numero_amostras_sinal-1);  
eixo_tempo = eixo_n*(1/Fs) ;  
espectro_sinal = fft(sinal);
eixo_frequencia_sinal = eixo_n*(Fs/numero_amostras_sinal); % esta parte não é estudada no nosso curso
espectro_de_magnitude = abs(espectro_sinal);
%plot(eixo_frequencia_sinal, espectro_de_magnitude); title('espectro Sinal A'); xlabel('Freq (Hz)'); ylabel('Amplitude (linear)');

%% PASSO 3: projeta os coeficientes dos filtros. Sao dois filtros no caso. Filtro 1 e 2. 
% passo 3.1: projeta filtro 1
[n,fo,ao,w] = firpmord([2000  2200  2210 2410],[1 0 1 ],[0.01 0.1 0.01],Fs);
b1 = firpm(n,fo,ao,w);
a1 = [1];
figure; freqz(b1,a1,1000, Fs); title('sistema 1');

% passo 3.2: projeta filtro 2
wp1= 2000/(Fs/2);
ws1= 2200/(Fs/2);
ws2= 2210/(Fs/2);
wp2= 2410/(Fs/2);
[n, wn]=buttord([wp1 wp2], [ws1 ws2], 1, 20);
[b2, a2]= butter(n,wn,'stop');
figure; freqz(b2, a2, 1000, Fs); title('sistema 2');

%% PASSO 4: faz filtragem usando o sistema 1 (coeficientes a1 e b1) e sistema 2 (coeficientes a2 e b2)
musica_filtrada_sis1 = filter(b1, a1, sinal);
musica_filtrada_sis2 = filter(b2, a2, sinal);

%% PASSO 5: gera audio filtrado pelos respectisos sistemas
audiowrite('arquivo_gerado_musica_filtrada_q4_sis1.wav',musica_filtrada_sis1,Fs);
audiowrite('arquivo_gerado_musica_filtrada_q4_sis2.wav',musica_filtrada_sis2,Fs);