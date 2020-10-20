% RESOLUCAO COMPUTACIONAL DA LISTA EXTRA DE SS2

% EXERCICIO 1
% b)

% Graficos de Bode
w = 1:0.01:300;
H1 = 640*(1i*w+1)./((1i*w+8).*(1i*w+40));
H2 = 0.01*(1i*w+40)./((1i*w+1).*(1i*w+8));
Htotal = 6.4 ./((1i*w+8).*(1i*w+8));

h = figure; plot(log10(w), 20*log10(abs(H1)));
title('Grafico de Bode de H_1(j\omega)');
xlabel('\omega (log10)');
ylabel('|H_1(j\omega)| (dB)');
f = figure; plot(log10(w), 20*log10(abs(H2)));
title('Grafico de Bode de H_2(j\omega)');
xlabel('\omega (log10)');
ylabel('|H_2(j\omega)| (dB)');
g = figure; plot(log10(w), 20*log10(abs(Htotal)));
title('Grafico de Bode de H_{total}(j\omega)');
xlabel('\omega (log10)');
ylabel('|H_{total}(j\omega)| (dB)');
% todos estao em escala dB

saveas(h, 'Ex1_b1.jpg');
saveas(f, 'Ex1_b2.jpg');
saveas(g, 'Ex1_btot.jpg');


% c)
w = 1:0.01:300;
H1 = 640*(1i*w+1)./((1i*w+8).*(1i*w+40));
H2 = 0.01*(1i*w+40)./((1i*w+1).*(1i*w+8));
Htotal = 6.4 ./((1i*w+8).*(1i*w+8));

h = figure; plot(w, 20*log10(abs(H1)));
title('Grafico de Bode de H_1(j\omega)');
xlabel('\omega');
ylabel('|H_1(j\omega)| (dB)');
f = figure; plot(w, 20*log10(abs(H2)));
title('Grafico de Bode de H_2(j\omega)');
xlabel('\omega');
ylabel('|H_2(j\omega)| (dB)');
g = figure; plot(w, 20*log10(abs(Htotal)));
title('Grafico de Bode de H_{total}(j\omega)');
xlabel('\omega');
ylabel('|H_{total}(j\omega)| (dB)');
% todos estao em escala dB

saveas(h, 'Ex1_c1.jpg');
saveas(f, 'Ex1_c2.jpg');
saveas(g, 'Ex1_ctot.jpg');
