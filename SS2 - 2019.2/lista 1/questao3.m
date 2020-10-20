clear; clc; close all;

%% PROCESSA SINAL A
    % parte  1: importa sinais e seus valores de taxa de aquisicao Fs (todo arquivo tem que vir a taxa indicando qual foi a Fs usada pra discretizar o sinal)
    [sinal_A, Fs_A] = audioread('sinal_questao3a.wav');
    
    %parte 2: reconstroi eixo do tempo de ambos sinais
    numero_amostras_sinal_A = length(sinal_A);
    eixo_n = (0:numero_amostras_sinal_A-1);  
    eixo_tempo_A = eixo_n*(1/Fs_A) ;  %estou aplicando a formula t=n*Ts onde Ts=1/Fs
    
    % parte 3: plota informacoes sinal A
    figure;
    subplot(2,1,1); plot(eixo_tempo_A, sinal_A); title('Sinal A'); xlabel('tempo (s)'); ylabel('Amplitude');
    espectro_sinal_A = fft(sinal_A);
    eixo_frequencia_sinal_A = eixo_n*(Fs_A/numero_amostras_sinal_A); % esta parte não é estudada no nosso curso
    espectro_de_magnitude = abs(espectro_sinal_A);
    subplot(2,1,2); plot(eixo_frequencia_sinal_A, espectro_de_magnitude); title('espectro Sinal A'); xlabel('Freq (Hz)'); ylabel('Amplitude (linear)');

%% PROCESSA SINAL A
    % parte  1: importa sinais e seus valores de taxa de aquisicao Fs (todo arquivo tem que vir a taxa indicando qual foi a Fs usada pra discretizar o sinal)
    [sinal_B, Fs_B] = audioread('sinal_questao3b.wav');
    sinal_B = sinal_B(:); %IMPORTANTE! Neste ponto, estou pegando todo o sinal B e jogando nele de novo. Mas se eu quizer pegar so um trecho, como, por exemplo, da amostra 2000 a 2800, deve fazer: sinal_B = sinal_B(2000:2800);
    
    %parte 2: reconstroi eixo do tempo de ambos sinais
    numero_amostras_sinal_B = length(sinal_B);
    eixo_n = (0:numero_amostras_sinal_B-1);  
    eixo_tempo_B = eixo_n*(1/Fs_B) ;  %estou aplicando a formula t=n*Ts onde Ts=1/Fs
        
    % parte 3: plota informacoes sinal A
    figure;
    subplot(2,1,1); plot(eixo_tempo_B, sinal_B); title('Sinal B'); xlabel('tempo (s)'); ylabel('Amplitude');
    espectro_sinal_B = fft(sinal_B);
    eixo_frequencia_sinal_B = eixo_n*(Fs_B/numero_amostras_sinal_B); % esta parte não é estudada no nosso curso
    espectro_de_magnitude = abs(espectro_sinal_B);
    subplot(2,1,2); plot(eixo_frequencia_sinal_B, espectro_de_magnitude);  title('espectro Sinal B'); xlabel('Freq (Hz)'); ylabel('Amplitude (linear)');