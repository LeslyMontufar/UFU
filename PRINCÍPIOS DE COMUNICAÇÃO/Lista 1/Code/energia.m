function Energia = energia(y)
    Energia = 0;
    for i= 1:length(y)
        Energia = Energia + y(i)^2;
    end
end