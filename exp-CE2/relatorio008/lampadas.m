clc; % nao limpar os dados!

% Tratamento de dados 
array = table2array(table);

h = figure('Name', 'Dados Recebidos');
plot(array(:,1), array(:,2));
title('Sinal não-senoidal sobre o resistor acoplado ao LED');
xlabel('$t$','Interpreter','LaTex','FontSize',16);
ylabel('$V_{LED}$ (V)','Interpreter','LaTex','FontSize',16);

saveas(h, 'Sinal_IN.png');