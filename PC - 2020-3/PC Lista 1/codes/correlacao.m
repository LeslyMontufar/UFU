function rho = correlacao(g, x,Dt)
    rho = sum(g.*conj(x)) *Dt/sqrt(energia(g,Dt)*energia(x,Dt));
end