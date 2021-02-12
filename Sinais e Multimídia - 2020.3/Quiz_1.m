Fs = 500;
t = 0:1/Fs:4*pi;
% a frequencia é o dois ultimos digitos da matricula: 01
% y = cos(t).*(exp(j*(t+pi/2))- exp(-j*(t+pi/2)))/(2*j);
y = (cos(t)).^2;
hold on;
plot(t,y);
energia = sum(abs(y).^2);
pot = energia/(5*Fs);

fprintf('Energia: %g J\nPotência: %g W\n', energia, pot);