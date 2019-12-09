t = -1:10;
y = dirac(t);
idt = y == Inf; % find Inf
y(idt) = 1;     % set Inf to finite value
stem(t,y)