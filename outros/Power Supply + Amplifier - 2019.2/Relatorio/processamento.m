clc; % nao limpar os dados!

% Tratamento de dados 
array = table2array(table);

h = figure('Name', 'Dados Recebidos');
plot(array(:,1), array(:,2));
title('Sinal de saída');
xlabel('$t$','Interpreter','LaTex','FontSize',16);
ylabel('$V_{OUT}$ (V)','Interpreter','LaTex','FontSize',16);

% saveas(h, 'Sinal_IN.png');

espectro = fft(array(:, 2));
g = figure('Name','Espectro do Sinal'); 
stem(abs(espectro));
title('Espectro da tensão de saída');
xlabel('$t$','Interpreter','LaTex','FontSize',16);
ylabel('$V_{OUT}$ (V)','Interpreter','LaTex','FontSize',16);
xlim([0 120]);

saveas(g, 'Espectro_OUT.png');