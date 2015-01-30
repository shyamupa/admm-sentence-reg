function [w] = logreg_regularized(X,y,initVal)
[nInst,nVars]= size(X);
w_init = zeros(nVars,1);
lambda = initVal*ones(nVars,1);
funObj = @(w)LogisticLoss(w,X,y);
fprintf('\nComputing L1-Regularized Logistic Regression Coefficients...\n');
w=L1General2_PSSgb(funObj,w_init,lambda);
