function [obj] = calcObj(v,w,X,y,M,docs,rho)
[obj] = LogisticLoss(w,X,y); 
obj = obj + norm(w,1);

sum=0;
for d=1:length(docs)
    for i=1:length(docs(d).sent_offsets)
        sum= sum+ norm(v(docs(d).sent_offsets(i)));
    end
end

obj = obj + sum;