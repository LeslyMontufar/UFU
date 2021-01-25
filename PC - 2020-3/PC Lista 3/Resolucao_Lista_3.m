% Lesly Montúfar
% 11811ETE001

clc
clear variables
close all

%---------------------------------------------------------
% definicoes iniciais
%---------------------------------------------------------

fs = 44.1e3;                      % frequência de amostragem
T0 = 2;                           % intervalo do sinal
t = 0:1/fs:T0-1/fs;               % eixo temporal
N = length(t);                    % comprimento do vetor tempo
f = -fs/2 :fs/N: fs/2-fs/N;       % eixo de frequências [Hz]
w = 2*pi*f;                       % velocidade angular [rad/s]

GRAVACAO = 2;
FILE = 1;

nbits = 16;
filename = 'som_tom.wav';
flag = FILE;

%---------------------------------------------------------
% gravando voz 
%---------------------------------------------------------
% aprender threads posso colocar um pontinho enquanto a pessoa fala no inicio
% ...........
while 1
    flag = input('Usar a arquivo de som de tom (1)? ou gravar?(2) ');
    if flag~=FILE && flag~=GRAVACAO
        fprintf(2,'     Valor nao permitido!\n')
        fprintf(2,'     As opcoes sao 1 (para ARQUIVO) ou 2 (para GRAVAR agora) \n\n')
    else
        break
    end
end
    
if flag == GRAVACAO
    ncanais = 1;
    somObj = audiorecorder(fs,nbits,ncanais); % handle do audiorecorder

    if input("Começar gravação? (y/n)",'s')~='n'
        disp('Início ...');
        recordblocking(somObj, T0); % gravar durante 2 segundos
        disp('Fim da gravação.');
    else
        return
    end
    
    dadosDouble = getaudiodata(somObj)'; % usa a matriz transposta dos dados
elseif flag == FILE
    [dadosDouble,Fs] = audioread(filename);          
    dadosDouble = dadosDouble';
end

fprintf('Processando ...\n\n');
AV = 0.2/max(dadosDouble);
dadosDouble = dadosDouble*AV;        % ganho para aumentar o volume ou deixar num volume agradavel (para o PC)

%---------------------------------------------------------
% analise - espectro em frequencia
%---------------------------------------------------------

fft_dadosDouble = fft(dadosDouble)/N; % G(f)
des = abs(fft_dadosDouble).^2; % densidade espectral de energia 
energia_total = sum(des)/(2*fs); % sum(des)*dt/2

B_msg = 0; % Largura de banda da mensagem
soma = des(1); 
for index=2:N/2 % comeca a parte negativa do espectro em N/2
   soma = soma + des(index); % nao preciso usar soma_atual=soma_anterior+des(index), pode usar só soma
   if 0.95*energia_total <= soma/fs % nao faz muito diferenca na conta, mas multiplica dt na soma
       B_msg = (index/N)*fs; % (index/(N/2))*fs/2
       break
   end
end
B_msg_index = index;

% vou passar um filtro ideal para retirar as freq que nao sao essenciais
fft_dadosDouble = ifftshift((abs(f)<=B_msg).* fftshift(fft_dadosDouble));
dadosDouble = ifft(fft_dadosDouble, 'symmetric')*N;

%---------------------------------------------------------
% parametros para gerar sinal FM
%---------------------------------------------------------

fc = 1e6;                          % frequencia da portadora [Hz]
deltaf = 75e3;                     % desvio de frequencia maximo
beta = deltaf/B_msg;               % parametro de desvio
BW_FM = 2*B_msg*(beta+1);          % Largura de banda do sinal FM
kf = deltaf*2*pi/max(dadosDouble); % constante
A = 1.5e-6;
wc = 2*pi*fc;

freq_max = fc + BW_FM/2;
fsr = ceil(10*freq_max);           % frequência de reamostragem

% reamostragem sinal FM
[P, Q] = rat(fsr/fs);
mt = resample(dadosDouble, P, Q);

% vetores do eixo temporal e do espectro
T0_FM = length(mt)/fsr;            % duracao do sinal FM
t_FM = 0:1/fsr:T0_FM-1/fsr;        % novo eixo temporal
N_FM = length(t_FM);               % quantidade de amostras

f_FM = -fsr/2 :fsr/N_FM: fsr/2-fsr/N_FM; % eixo de frequências [Hz]
w_FM = 2*pi*f_FM;                        % velocidade angular[rad/s]

%---------------------------------------------------------
% modulacao FM
%---------------------------------------------------------

at = cumsum(mt)/fsr;
sFM = A*cos(wc*t_FM+kf*at);

fft_sFM = fft(sFM)/N_FM;

% vou passar um filtro faixa ideal para retirar as freq que nao sao essenciais 
% no sinal FM
fft_sinalFM = (abs(f_FM)>=fc-BW_FM/2).* fftshift(fft_sFM);
fft_sinalFM = (abs(f_FM)<=fc+BW_FM/2).* fft_sinalFM;
fft_sinalFM = ifftshift(fft_sinalFM);
sinalFM = ifft(fft_sinalFM, 'symmetric')*N_FM;

%---------------------------------------------------------
% demodulacao FM 
%---------------------------------------------------------

% metodo ideal do diferenciador
H = 1j*w_FM; % fnc de transferencia de diferenciador ideal
fft_sFMderivativo = ifftshift((abs(f_FM)~=0) .* (fftshift(fft_sinalFM) .* H));
sFMderivativo = ifft(fft_sFMderivativo,'symmetric')*N_FM;

% detector de envoltoria
% como nao temos ruído para o transporte do sinal FM até o receptor
% não é preciso um limitador passa-faixa, para deixar a amplitude do sinal
% FM uniforme
sFMretificado = (sFMderivativo>0).* sFMderivativo;
fft_sFMretificado = fft(sFMretificado)/N_FM;

% fitro passa-baixa em B e passa-alta para eliminar componente DC (A*wc)
fft_sFMposFiltro = (abs(f_FM)~=0) .* (abs(f_FM)<=B_msg) .* fftshift(fft_sFMretificado);
fft_sFMposFiltro = fftshift(fft_sFMposFiltro);

sFMposFiltro = ifft(fft_sFMposFiltro, 'symmetric')*N_FM;

%---------------------------------------------------------
% ouvir
%---------------------------------------------------------
% posso colocar uma linha mostrando onde está na gravação

if input("Ler gravação? (y/n)",'s')~='n'
   if flag == GRAVACAO
       play(somObj); 
   elseif flag == FILE
       sound(dadosDouble,fs,nbits);
   end
end

sMod = sFMposFiltro;
[P,Q] = rat(N/N_FM);
sMod = resample(sMod,P, Q);
sMod = sMod(1:length(dadosDouble));
fft_sMod = fft(sMod)/N;
if input("Ler sinal modulado? (y/n)",'s')~='n'
    sound(sMod,fs,nbits);
end

%---------------------------------------------------------
% salvando dados
%---------------------------------------------------------

if flag == GRAVACAO && input("Salvar gravação? (y/n)",'s')~='n'
    filename = input('\nDigite o nome do arquivo .wav: ', 's');
    audiowrite([filename '.wav'],getaudiodata(somObj),fs);
end

%---------------------------------------------------------
% graficos
%---------------------------------------------------------

if input("Plotar e mostrar info detalhada? (y/n)",'s')~='n' 
    figure('Name','Análise dos dados');
    subplot(221);
    plot(t,dadosDouble); % double: normaliza os valores de -1 a 1
    ylabel('Sinal de entrada (double)');
    xlabel('Tempo (s)');
    
    subplot(222);
    plot(f/1e3,fftshift(abs(fft_dadosDouble)),'linewidth',1.5,'color',[0 0 0]);
    fft_dadosDouble95 = zeros(size(fft_dadosDouble));
    fft_dadosDouble95(1:B_msg_index-1) = fft_dadosDouble(1:B_msg_index-1);
    hold on; plot(f/1e3,fftshift(abs(fft_dadosDouble95)),'linewidth',1.5,'color',[0 1 0]); % mostra a largura de banda da mensagem
    ylabel('Espectro do sinal de entrada');
    xlabel('Frequência [kHz]');  
    xlim([-20 20]);
    
    subplot(223);
    plot(t_FM,sinalFM);
    ylabel('Sinal de saída FM');
    xlabel('Tempo (s)');
    
    subplot(224);
    plot(f_FM/1e3,fftshift(abs(fft_sinalFM)),'linewidth',1.5,'color',[0 0 0]);
    ylabel('Espectro do sinal de saída FM');
    xlabel('Frequência [kHz]');
    xlim([-freq_max/1e3 freq_max/1e3]);
    
    suptitle('Dados do sinal de entrada e sinal FM');
    
    
    figure('Name', 'Processo de demodulação do sinal FM', 'Position', [0 40 1.1e3 580]);
    subplot(321);
    plot(t_FM,sFMderivativo);
    ylabel('Sinal FM depois do derivativo');
    xlabel('Tempo (s)');
    
    subplot(322);
    plot(f_FM/1e3,fftshift(abs(fft_sFMderivativo)),'linewidth',1.5,'color',[0 0 0]);
    ylabel('Espectro depois do derivativo');
    xlabel('Frequência [kHz]');  
    xlim([-freq_max/1e3 freq_max/1e3]);
    
    subplot(323);
    plot(t_FM,sFMretificado);
    ylabel('Sinal FM depois da retificação');
    xlabel('Tempo (s)');
    
    subplot(324);
    plot(f_FM/1e3,fftshift(abs(fft_sFMretificado)),'linewidth',1.5,'color',[0 0 0]);
    ylabel('Espectro depois da retificação');
    xlabel('Frequência [kHz]'); 
    xlim([-20 20]);
    
    subplot(325);
    plot(t_FM,sFMposFiltro);
    ylabel('Sinal FM depois dos filtros');
    xlabel('Tempo (s)');
    
    subplot(326);
    plot(f_FM/1e3,fftshift(abs(fft_sFMposFiltro)),'linewidth',1.5,'color',[0 0 0]);
    ylabel('Espectro depois dos filtros');
    xlabel('Frequência [kHz]'); 
    xlim([-20 20]);
    
    suptitle('Processo de demodulação do sinal FM');
    
    fprintf('\nInfo\n');
    fprintf('\tMensagem:\n');
    fprintf('\t\tB: %g [Hz]\n', B_msg);
    fprintf('\t\tFs: %g [Hz]\n', fs);
    fprintf('\tSinal FM:\n');
    fprintf('\t\tBW_FM: %g [Hz]\n', BW_FM);
    fprintf('\t\tFreq. para reamostragem: %g [Hz]\n', fsr);
    fprintf('\n');
end

%---------------------------------------------------------
% grafico simples
%---------------------------------------------------------

if input("Plotar e mostrar info simples? (y/n)",'s')~='n' 
    figure('Name','Modulação e demodulação FM');
    subplot(221);
    plot(t,dadosDouble); % double: normaliza os valores de -1 a 1
    ylabel('Sinal de entrada (double)');
    xlabel('Tempo (s)');
    
    subplot(222);
    plot(f/1e3,fftshift(abs(fft_dadosDouble)),'linewidth',1.5,'color',[0 0 0]);
    fft_dadosDouble95 = zeros(size(fft_dadosDouble));
    fft_dadosDouble95(1:B_msg_index-1) = fft_dadosDouble(1:B_msg_index-1);
    hold on; plot(f/1e3,fftshift(abs(fft_dadosDouble95)),'linewidth',1.5,'color',[0 1 0]); % mostra a largura de banda da mensagem
    ylabel('Espectro do sinal de entrada');
    xlabel('Frequência [kHz]');  
    xlim([-20 20]);
    
    subplot(223);
    plot(t(1:length(sMod)),sMod);
    ylabel('Sinal demodulado');
    xlabel('Tempo (s)');
    
    subplot(224);
    plot(f/1e3,fftshift(abs(fft_sMod)),'linewidth',1.5,'color',[0 0 0]);
    ylabel('Espectro do sinal modulado');
    xlabel('Frequência [kHz]'); 
    xlim([-20 20]);
    
    suptitle('Modulação e demodulação FM');
    
    fprintf('\nInfo\n');
    fprintf('\tMensagem:\n');
    fprintf('\t\tB: %g [Hz]\n', B_msg);
    fprintf('\t\tFs: %g [Hz]\n', fs);
    fprintf('\tSinal FM:\n');
    fprintf('\t\tBW_FM: %g [Hz]\n', BW_FM);
    fprintf('\t\tFreq. para reamostragem: %g [Hz]\n', fsr);
    fprintf('\n');
    fprintf('Obs: em verde é marcada as frequencias positivas de valor inferior à largura de banda do sinal\n');
end

%---------------------------------------------------------
% salva os dados
%---------------------------------------------------------

% save('mod_demod_FM.mat');

% Não está mais dando erro no resample do matlab
% soma = 0;
% sFM = zeros(1,N_FM);
% i = 1;
% for index = 1:N_FM
%     if i<=N
%         if t(i)>=t_FM(index) && t(i)< t_FM(index+1)
%             soma = soma + dadosDouble(i);
%             i = i+1;
%         end
%     end
%     sFM(index) = A*cos(wc*t_FM(index)+kf*soma/fs); % construindo o sinal FM
% end
