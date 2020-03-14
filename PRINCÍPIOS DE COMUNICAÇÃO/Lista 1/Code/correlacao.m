function rho = correlacao(g, x, T)
    rho = 0;
    for i=1:length(g)
       rho = rho + g(i)*conj(x(i)); 
    end
    rho = rho* (1/sqrt(energia(g, T)*energia(x, T)));
end