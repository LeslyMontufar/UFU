clear; clc; close all;

a = [1.0000   -9.2385   38.8549  -97.9289  163.7584 -189.8177  154.4490  -87.1113   32.5982   -7.3103    0.7463];
b = [0.8639   -8.2216   35.6168  -92.4564  159.2227 -190.0507  159.2227  -92.4564   35.6168   -8.2216    0.8639];

[sinal, Fs] = audioread('sinal_questao4.wav');


%para gravar um audio que esta vetor 'musica_filtrada', use o codigo abaixo:
audiowrite('arquivo_gerado_musica_filtrada_q4.wav',musica_filtrada,Fs);

%para plotar um espectro, use o código da questao 3.
