function Energia = energia(y, T)
    Energia = 0;
    for i= 0:0.01:T
        Energia = Energia + y(i)^2;
    end
    Potencia = Energia/T;
end