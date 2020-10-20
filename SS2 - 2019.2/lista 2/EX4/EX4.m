clearvars; close all;
% Do esquema do enunciado tem-se:
zeta = 0.4037; wn = 113.9424;
A = wn^2/25;%2*zeta*wn-25;
K = wn^2/100;
w = 0:1e-3:pi;
s = 1j*w;
Hjw = (100*K)./((s+A).*(s + 25));

b = [100*K];
a = [1 25+A 25*A];
[z, p, k] = tf2zp(b, a);

fvtool(b,a,'polezero')
text(real(z)+.1,imag(z),'Zero')
text(real(p)+.1,imag(p),'Pole')

% Resposta ao degrau 
figure; 
[u,t] = step(tf(b, a), 1); 
plot(t, u); 
title('Resposta ao degrau unitário');
xlabel('$t$','Interpreter','LaTex','FontSize',14);
ylabel('$s(t)$','Interpreter','LaTex','FontSize',14);
ax = gca; ax.FontSize=11; 
grid minor;

tf(b, a)
