clc; clear all;
%% prepara para gerar sinal:
Fs = 10000; %voce deve/pode alterar. Trata-se da frequencia de "aquisicao"
t=0:1/Fs:0.01; %voce deve/pode alterar. Trata-se de quanto tempo voce deseja analisar o sinal.

%% projeta filtro:
[n,fo,ao,w] = firpmord([500  1000],[1 0],[0.01 0.1],Fs); %estes valores de parametros devem alterar segundo seu exemplo. Consulte o help do Matlab para entender ou procure o professor para esclarecimentos
coeficientes_sistema = firpm(n,fo,ao,w);
freqz(coeficientes_sistema,1,512);%esta funcao apenas gera um grafico para mostrar como o sistema projetado se comporta. O eixo de frequencias esta normalizado

%% agora eh sua vez,....filtra pra mim vai ;)