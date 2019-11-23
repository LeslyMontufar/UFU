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
voice.number_of_samples = size(voice.audiodata, 1);
voice.maxtime = voice.number_of_samples/voice.Fs;
voice.t = 0:voice.number_of_samples - 1; %discreto;
info('Minha voz', voice);
music.number_of_samples = size(music.audiodata, 1);
info('Música', music);

% Entrada de sons
% fprintf('SELECT\nG - Play\nP - Pause\nR - Resume\nS - Stop\n\n')
% while 1
%     switch input('choice: ', 's')
%         case 'G'
%             play(voice.player);
%         case 'P'
%             pause(voice.player);
%         case 'R'
%             resume(voice.player);
%         case 'S'
%             stop(voice.player);
%             break;
%     end
% end


function info(title, audio)
    fprintf('%s\n', title);
    amostras = length(audio.audiodata);
    fprintf('\tNúmero de amostras no audio: %g\n', amostras);
    fprintf('\tTaxa de amostragem em Hz: %g\n', audio.Fs); % a cada 1 segundo tem Fs amostras -> amostras/seg
    fprintf('\tTempo de duração: %g segundos\n\n', amostras/audio.Fs); %(amostras)*(seg/amostras) = seg -> amostras*1/Fs
end
