% Parallelize this update
function v=updateV(lambda_sen,rho,z)
    if norm(z) <= lambda_sen/rho
        v=zeros(size(z));
    else
        v=z*(norm(z) - (lambda_sen/rho))/norm(z); 
    end
end