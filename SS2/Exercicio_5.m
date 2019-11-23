% Reset sounds
clear sound; 
clc;
close all;
clear all;

% Recebe os dados
[filename path] = uigetfile('*', 'Select voice file');
voice.path = strcat(path, filename);
[voice.audiodata, voice.Fs] = audioread(voice.path);

[filename path] = uigetfile('*', 'Select voice file');
music.path = strcat(path, filename);
[music.audiodata, music.Fs] = audioread(music.path); % audiodata is the a matrix mxn where n is the number of channels

% Quero o histograma
figure('Name', 'Voice: Histogram of AudioData');
hist(voice.audiodata);
figure('Name', 'Music: Histogram of AudioData');
hist(music.audiodata);

% Entrada de sons
sound(voice.audiodata, voice.Fs);
sound(music.audiodata, music.Fs);

