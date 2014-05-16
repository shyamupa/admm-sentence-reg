function [mu] = updateMu(v,u,N,M,rho)
    mu=(M'*v + (M'*u)./rho)./N;
end