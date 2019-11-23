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

% Quero o histograma
% figure('Name', 'Voice: Histogram of AudioData');
% hist(voice.audiodata);
% figure('Name', 'Music: Histogram of AudioData');
% hist(music.audiodata);

fig = uifigure;
btn = uibutton(fig);

% Entrada de sons
fprintf('SELECT\nG - Play\nP - Pause\nR - Resume\nS - Stop\n\n')
while 1
    switch input('choice: ', 's')
        case 'G'
            play(voice.player);
        case 'P'
            pause(voice.player);
        case 'R'
            resume(voice.player);
        case 'S'
            stop(voice.player);
    end
end


function buttonPlot()
% Create a figure window
fig = uifigure;

% Create a UI axes
ax = uiaxes('Parent',fig,...
            'Units','pixels',...
            'Position', [104, 123, 300, 201]);   

% Create a push button
btn = uibutton(fig,'push',...
               'Position',[420, 218, 100, 22],...
               'ButtonPushedFcn', @(btn,event) Play(btn,ax));
end

% Create the function for the ButtonPushedFcn callback
function Play(btn,ax)
        x = linspace(0,2*pi,100);
        y = sin(x);
        plot(ax,x,y)
end
