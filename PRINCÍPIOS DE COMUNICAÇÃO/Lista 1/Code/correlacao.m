function rho = correlacao(g, x)
    rho = 0;
    for i=1:length(g)
       rho = rho + g(i)*conj(x(i)); 
    end
    rho = rho* (1/sqrt(energia(g)*energia(x)));
end