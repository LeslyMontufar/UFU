function [y_n] = eqdif(b, a, x_n)
    % EQDIF determina a saida por meio da eq de diferencas
    
    % y_n(0)=0; matlab nao aceita
    for n=1:length(x_n)
        y_n(n) = 0; ia=2; 
        while ia<=n
            y_n(n) = y_n(n) - a(ia)*y_n(n-(ia-1));
            ia = ia+1;
            if ia > length(a) break; end
        end
        ib = 1;
        while (n-1)-(ib-1)>=0 % pensar no básico
            y_n(n) = y_n(n) + b(ib)*x_n(n-(ib-1));
            ib = ib+1;
            if ib > length(b) break; end
        end
        y_n(n) = y_n(n)/a(1);
    end
end