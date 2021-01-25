close all; clc;

figure('Name','Correlação de sinais');
Dt = 0.01;
t = -0.5:Dt:6;
x = rect((t-2.5)/5);

subplot(231);
g1 = rect((t-2.5)/5);
plot(t,g1,'linewidth',1.5,'color',[0 0 0]);
ylim([-1.5 1.5]);
title(['\rho = ' sprintf('%.6f', correlacao(g1,x,Dt))]);
ylabel('g_1(t)');
xlabel('t');
grid on;

subplot(232);
g2 = rect((t-2.5)/5)/2;
plot(t,g2,'linewidth',1.5,'color',[0 0 0]);
ylim([-1.5 1.5]);
title(['\rho = ' sprintf('%.6f', correlacao(g2,x,Dt))]);
ylabel('g_2(t)');
xlabel('t');
grid on;

subplot(233);
g3 = -rect((t-2.5)/5);
plot(t,g3,'linewidth',1.5,'color',[0 0 0]);
ylim([-1.5 1.5]);
title(['\rho = ' sprintf('%.6f', correlacao(g3,x,Dt))]);
ylabel('g_3(t)');
xlabel('t');
grid on;

subplot(234);
g4 = exp(-t/5).*rect((t-2.5)/5);
plot(t,g4,'linewidth',1.5,'color',[0 0 0]);
ylim([-1.5 1.5]);
title(['\rho = ' sprintf('%.6f', correlacao(g4,x,Dt))]);
ylabel('g_4(t)');
xlabel('t');
grid on;

subplot(235);
g5 = exp(-t).*rect((t-2.5)/5);
plot(t,g5,'linewidth',1.5,'color',[0 0 0]);
ylim([-1.5 1.5]);
title(['\rho = ' sprintf('%.6f', correlacao(g5,x,Dt))]);
ylabel('g_5(t)');
xlabel('t');
grid on;

subplot(236);
g6 = sin(2*pi*t).*rect((t-2.5)/5);
plot(t,g6,'linewidth',1.5,'color',[0 0 0]);
ylim([-1.5 1.5]);
title(['\rho = ' sprintf('%.6f', correlacao(g6,x,Dt))]);
ylabel('g_6(t)');
xlabel('t');
grid on;

cd ..
print('img/ex4-corr','-dpng');
