clear all; close all; clc;

% Plotando o sinal
b=1;
a=-1;
tol=1.e-5;
T=b-a;
N=11;
w0=2*pi/T;

figure('Name','Sinal periódico analisado');
Ts = 1e-6; 
t = -T/2:Ts:T/2; % t discreto
M=4;
y = Delta(t/2);

time = [];
yp = [];
for i=-M:M % como tem simetria em y não precisa do -1
   time = [time i*T+t];
   yp = [yp y];
end

plot(time,yp,'linewidth',1.5,'color',[0 0 0]);
xlim([-9 9]);
ylim([0 1.5]);
title('\Delta (t/2)'); 
grid on;

% Separacao dos sinais que compoem o sinal
Func= @(t) Delta(t/2);
Dn(N+1) = 1/T*quad(Func, a, b, tol); 

for i = 1:N
    Func = @(t) exp(-1j*w0*t*i).*Delta(t/2);
    Dn(i+N+1)=1/T*quad(Func, a, b, tol);
    
    Func = @(t) exp(1j*w0*t*(N+1-i)).*Delta(t/2);
    Dn(i)=1/T*quad(Func, a, b, tol);

end

figure('Name','Componentes exponenciais');
subplot(211);stem([-N:N],abs(Dn),'linewidth',1.5,'color',[0 0 0]);
xlim([-15 15]);
ylim([0 0.8]);
title('|D_n|');
grid on;

subplot(212);stem([-N:N],angle(Dn),'linewidth',1.5,'color',[0 0 0]);
xlim([-15 15]);
ylim([-4 4]);
title('\angle D_n');
grid on;

% figure('Name','Recriando o sinal');
% n = -N:N;
% triangulo = @(t) Dn.*exp(1j*w0*t*n);
% fplot(triangulo,[a b]);

% Salva as imagens obtidas
cd ..
% print('-f1','img/ex5-sinal','-dpng');
print('-f2','img/ex5-sinais-Dn','-dpng');
