t = -1:10;
y = dirac(t+5);
idt = y == Inf; % find Inf
y(idt) = 1;     % set Inf to finite value
stem(x,y)