function e = energia(y,Dt)
    e = sum(y.*conj(y))*Dt;
end