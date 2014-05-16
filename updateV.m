% Parallelize this update
function v=updateV(lambda_sen,rho,z)
    if norm(z) <= lambda_sen/rho
%         fprintf('OMG! \n')
        v=zeros(size(z));
    else
%         fprintf('PHEW! \n')
        v=z*(norm(z) - (lambda_sen/rho))/norm(z); 
    end
end