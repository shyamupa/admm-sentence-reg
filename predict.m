function [p]=predict(X,y,w)
Xw = X*w;
sig = 1./(1+exp(-Xw));
sig(sig>0.5)=1;
sig(sig<0.5)=-1;
p=sig;
error=abs(sum(p-y));
total=size(y,1);
fprintf('error %f out of %f \n',error,total);


