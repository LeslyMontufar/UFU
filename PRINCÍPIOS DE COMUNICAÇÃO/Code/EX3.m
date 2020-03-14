clear all; close all; clc;

figure('Name','Sinais periódicos');
T = 6;
M = 3;
t = -M*T:0.01:M*T;

plot(t, y(t),'linewidth',1.5,'color',[0 0 0]);
xlim([-20 20]);

function out = y(t)
    out = exp(-abs(t)/2).*sin(2*pi*t).*rect((t-2)/4);
end
