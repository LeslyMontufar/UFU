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
info('Música', music);

% Plot de parte especifica
signal_audio_plot(voice,'Time vs. Freq', 3.2, 3.6);
signal_audio_plot(music,'Time vs. Freq');

function info(title, audio)
    fprintf('%s\n', title);
    amostras = length(audio.audiodata);
    fprintf('\tNúmero de amostras no audio: %g\n', amostras);
    fprintf('\tTaxa de amostragem em Hz: %g\n', audio.Fs); % a cada 1 segundo tem Fs amostras -> amostras/seg
    fprintf('\tTempo de duração: %g segundos\n\n', amostras/audio.Fs); %(amostras)*(seg/amostras) = seg -> amostras*1/Fs
end
function [audio] = signal_audio_info(audio)
    audio.number_of_samples = size(audio.audiodata, 1);
    audio.n = 0:audio.number_of_samples - 1; % discreto;
    audio.t = audio.n/audio.Fs; % tempo tem o mesmo tam que audiodata matrix
end
function signal_audio_plot(audio, type, ti, tf)
	if nargin <= 2
        figure('Name', 'Sound'); plot(audio.t, audio.audiodata);
    elseif strcmp(type,'Time vs. Freq')
        figure('Name', 'Sound'); plot(audio.t(ti*audio.Fs:tf*audio.Fs), audio.audiodata(ti*audio.Fs:tf*audio.Fs));
    end
end