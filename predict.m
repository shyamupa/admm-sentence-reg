function [p]=predict(X,y,w)
Xw = X*w;
sig = 1./(1+exp(-Xw))
sig(sig>0.5)=1;
sig(sig<0.5)=-1;
p=sig;
error=sum(p-y)
total=size(y);


