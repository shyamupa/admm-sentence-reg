function [mu] = updateMu(v,u,N,M,rho)
%     [n,vocab_size]=size(M);
%     mu=zeros(vocab_size,1);
%     for i=1:vocab_size
%         rel_indices = M(:,i) ;    % the ith column
%         mu(i)=(dot(v,rel_indices) + dot(u,rel_indices)/rho)/N(i,1); 
%     end
    mu=(M'*v + (M'*u)./rho)./N;
%     assert(isequal(new_mu,mu));
end