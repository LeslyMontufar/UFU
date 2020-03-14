function out = Delta(t)
    out = (1-2*abs(t)).*rect(t);
end