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
voice.number_of_samples = size(voice.audiodata, 1); % 3.2s a 3.6s
voice.n = 0:voice.number_of_samples - 1; % discreto;
voice.t = voice.n/voice.Fs; % tempo tem o mesmo tam que audiodata matrix
figure('Name', 'Voice'); plot(voice.t, voice.audiodata);
info('Minha voz', voice);
music.number_of_samples = size(music.audiodata, 1);
info('Música', music);

function info(title, audio)
    fprintf('%s\n', title);
    amostras = length(audio.audiodata);
    fprintf('\tNúmero de amostras no audio: %g\n', amostras);
    fprintf('\tTaxa de amostragem em Hz: %g\n', audio.Fs); % a cada 1 segundo tem Fs amostras -> amostras/seg
    fprintf('\tTempo de duração: %g segundos\n\n', amostras/audio.Fs); %(amostras)*(seg/amostras) = seg -> amostras*1/Fs
end

function [audio] = signal_audio_plot(audio, type)
    if srtcmp(type,'Time vs. Freq')
        audio.number_of_samples = size(audio.audiodata, 1);
        audio.n = 0:audio.number_of_samples - 1; % discreto;
        audio.t = audio.n/audio.Fs; % tempo tem o mesmo tam que audiodata matrix
    end
end