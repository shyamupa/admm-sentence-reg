function [mu] = updateMu(v,u,N,M,rho)
    [n,vocab_size]=size(M);
    mu=zeros(vocab_size,1);
    for i=1:vocab_size
        rel_indices = M(:,i) ;    % the ith column
        mu(i)=(dot(v,rel_indices) + dot(u,rel_indices)/rho)/N(1,i); 
    end
    disp(['New mu']);
end