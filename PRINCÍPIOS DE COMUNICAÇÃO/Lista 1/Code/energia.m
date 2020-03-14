function Energia = energia(y, T)
    Energia = 0;
    for i= 1:T/0.01
        Energia = Energia + y(i)^2;
    end
end