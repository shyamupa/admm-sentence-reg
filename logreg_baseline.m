function [wout]=logreg_baseline(X,y)
% log reg with no regularization
[nInst,nVars]= size(X);

w_init = zeros(nVars,1);

fprintf('\nRunning Scaled Conjugate Gradient\n');
options.Method = 'scg';
options.MAXITER = 100;
[wout,~,~,~]=minFunc(@LogisticLoss,w_init,options,X,y);
