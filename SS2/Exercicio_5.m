% Reset sounds
clear sound; 
clc;
close all;
clear all;

% Recebe os dados
[filename path] = uigetfile('*', 'Select voice file');
voice.path = strcat(path, filename);
[voice.audiodata, voice.Fs] = audioread(voice.path);
voice.player = audioplayer(voice.audiodata, voice.Fs);

[filename path] = uigetfile('*', 'Select voice file');
music.path = strcat(path, filename);
[music.audiodata, music.Fs] = audioread(music.path); % audiodata is the a matrix mxn where n is the number of channels
music.player = audioplayer(music.audiodata, music.Fs);

% Dados dos sinais
voice = signal_audio_info(voice);
info('Minha voz', voice);
music = signal_audio_info(music);
info('M�sica', music);

% Plot de tempo espec�fico
signal_audio_plot(voice,'Time vs. Freq', 3.3, 3.4);
signal_audio_plot(music,'Time vs. Freq');

% Plot do espectro
signal_audio_plot(voice,'Hz vs. Espectro de Freq', 3.3, 3.4);
signal_audio_plot(music,'Hz vs. Espectro de Freq');

% Espande no tempo para an�lise espe�fica
n = 1;
ii = 1;
while n <= voice.number_of_samples
    if mod(ii, 2)==1
        voice.expanded(ii) = voice.audiodata(n);
        n = n + 1;
    else
        voice.expanded(ii) = 0;
    end
    ii=ii+1;
end

function info(title, audio)
    fprintf('%s\n', title);
    amostras = length(audio.audiodata);
    fprintf('\tN�mero de amostras no audio: %g\n', amostras);
    fprintf('\tTaxa de amostragem em Hz: %g\n', audio.Fs); % a cada 1 segundo tem Fs amostras -> amostras/seg
    fprintf('\tTempo de dura��o: %g segundos\n\n', amostras/audio.Fs); %(amostras)*(seg/amostras) = seg -> amostras*1/Fs
end
function [audio] = signal_audio_info(audio)
    audio.number_of_samples = size(audio.audiodata, 1);
    audio.n = 0:audio.number_of_samples - 1; % discreto; % para simplesmente passar para vetor
    audio.t = audio.n/audio.Fs; % tempo tem o mesmo tam que audiodata matrix
    audio.espectro = fft(audio.audiodata);
    audio.espectro_abs = abs(audio.espectro);
    audio.espectro_abcissa_em_Hz = audio.n * audio.Fs * (1/audio.number_of_samples); % s� audio.n � vetor, cujp length � importante para manter o padrao dos outros vet 
end
function signal_audio_plot(audio, type, ti, tf)
	if nargin <= 2
        ti=1/audio.Fs; tf=(audio.number_of_samples)/audio.Fs; % no matlab vet comeca em 1
    end
    if strcmp(type,'Time vs. Freq')
        figure('Name', 'Sound'); plot(audio.t(ti*audio.Fs:tf*audio.Fs), audio.audiodata(ti*audio.Fs:tf*audio.Fs));
    elseif strcmp(type,'Hz vs. Espectro de Freq')
        if nargin > 2
        figure('Name', 'Sound'); plot(audio.espectro_abcissa_em_Hz(double(ti*audio.Fs):double(tf*audio.Fs)), ...
            audio.espectro_abs(int64(ti*audio.Fs):int64(tf*audio.Fs)));
        else
            figure('Name', 'Sound'); plot(audio.espectro_abcissa_em_Hz, audio.espectro_abs);
        end
    end
end