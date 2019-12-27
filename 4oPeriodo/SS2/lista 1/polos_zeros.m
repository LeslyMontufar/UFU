clc;
syms H(w)

zeros = [];
polos =[];
mag = input('mag: ');
zeros = input('zeros: ');
polos = input('polos: ');

H(w)= mag;
for n=1:length(zeros)
    H(w) = H(w) .* (1j*w + zeros(n));
end

for n=1:length(polos)
    H(w) = H(w) ./(1j*w + polos(n));
end

while 1
    fprintf('%s\n', H(w));
    w = input('w: ');
    fprintf('linear: %g fase %g\n', abs(H(w)), angle(H(w))*(180/pi));
    fprintf('dB: %g\n', 20*log10(H(w)));
end