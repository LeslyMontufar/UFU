[filename path] = uigetfile('*', 'Select voice file');
voice.path = strcat(path, filename);
[voice.audiodata, voice.Fs] = audioread(voice.path);
sound(voice.audiodata, voice.Fs);

[filename path] = uigetfile('*', 'Select voice file');
music.path = strcat(path, filename);
[music.audiodata, music.Fs] = audioread(music.path);
sound(voice.audiodata, voice.Fs);

t = 0:1/Fs:1;
figure;
plot(t(1:length(y)), y);