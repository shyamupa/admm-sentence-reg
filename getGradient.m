function [g] = getGradient(w,X,y,rho,N,mu)
% gradient for the first part (sum(LogLoss(xi,yi,w)))
%[obj,grad,lossobj,regobj] = bcls(w,x,y,lambda)
lambda = 0;  % no reg inside this loss 

% save('tmp3'); 
[nll,g,lossobj,regobj] = bcls(w,X,y,0); 
% [nll,g] = LogisticLoss(w,X,y);
% gradient for the rho/2 sum(Ni(w_i-mu_i)^2)
g = g + rho.*N'.*(w-mu);


