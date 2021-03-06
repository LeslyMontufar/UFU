% Reset sounds
clc;
close all;
clearvars

% Recebe os dados
[filename path] = uigetfile('*', 'Select voice file');
voice.path = strcat(path, filename);
[voice.audiodata, voice.Fs] = audioread(voice.path);
voice.player = audioplayer(voice.audiodata, voice.Fs);

[filename path] = uigetfile('*', 'Select voice file');
music.path = strcat(path, filename);
music.path= 'Howls Moving Castle.wav';
[music.audiodata, music.Fs] = audioread(music.path); % audiodata is the a matrix mxn where n is the number of channels
music.player = audioplayer(music.audiodata(:, 1), music.Fs);

% Dados dos sinais
voice = signal_audio_info(voice);
info('Minha voz', voice);
music = signal_audio_info(music);
info('M�sica', music);

% Plot de tempo espec�fico
signal_audio_plot(voice,'Time vs. Freq', 3.2, 3.4);
signal_audio_plot(music,'Time vs. Freq');

% Plot do espectro
signal_audio_plot(voice,'Hz vs. Espectro de Freq', 3.2, 3.4);
signal_audio_plot(music,'Hz vs. Espectro de Freq');

% Trecho maior
voice_trecho.audiodata = voice.audiodata(1*voice.Fs: 4*voice.Fs); %minha grav
if voice.Fs == music.Fs
    voice_trecho.Fs = voice.Fs;
    voice_trecho = signal_audio_info(voice_trecho);
    res.Fs = voice_trecho.Fs;
    res.audiodata = ones(voice_trecho.number_of_samples, 1); 
    for n = 1:voice_trecho.number_of_samples
        res.audiodata(n) = voice_trecho.audiodata(n) + music.audiodata(5*music.Fs+n);
    end
    res = signal_audio_info(res);
    res.player = audioplayer(res.audiodata, res.Fs);
    voice_trecho.player = audioplayer(voice_trecho.audiodata, voice_trecho.Fs);
end

% Hora de ouvir
if input('ouvir tudo? (0/1)')
    %play(voice.player);
    play(res.player);
end

% Plot do sinal resultante
if input('mostrar espectro? (0/1)')
    %signal_audio_plot(res,'Time vs. Freq');
    signal_audio_plot(res,'Hz vs. Espectro de Freq');
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
    audio.espectro_abcissa_em_Hz = audio.n * audio.Fs * (1/audio.number_of_samples); % s� audio.n � vetor, cujo length � importante para manter o padrao dos outros vet 
end
function signal_audio_plot(audio, type, ti, tf)
    if strcmp(type,'Time vs. Freq')
        if nargin > 2
            figure('Name', 'Sound'); plot(audio.t(ti*audio.Fs:tf*audio.Fs), audio.audiodata(ti*audio.Fs:tf*audio.Fs));
        else
            figure('Name', 'Sound'); plot(audio.t, audio.audiodata);
        end
    elseif strcmp(type,'Hz vs. Espectro de Freq')
        if nargin > 2
            figure('Name', 'Sound'); plot(audio.espectro_abcissa_em_Hz(ti*audio.Fs:tf*audio.Fs), ...
            audio.espectro_abs(ti*audio.Fs:tf*audio.Fs));
        else
            figure('Name', 'Sound'); plot(audio.espectro_abcissa_em_Hz, audio.espectro_abs);
        end
    end
end