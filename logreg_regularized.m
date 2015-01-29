function [w] = logreg_regularized(X,y)
[nInst,nVars]= size(X);
w_init = zeros(nVars,1);
lambda = 1*ones(nVars,1);
funObj = @(w)LogisticLoss(w,X,y);
fprintf('\nComputing L1-Regularized Logistic Regression Coefficients...\n');
w=L1General2_PSSgb(funObj,w_init,lambda);
