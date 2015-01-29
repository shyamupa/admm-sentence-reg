% function yPred = testW(X,y,w,docs)
% X = [X, ones(length(docs),1)]; 
% sigmoid = @(x) ( 1 ./ ( 1 + exp(-x) ) );
% classify = @(x, w) ( sigmoid( x*w ) );
% yPred = classify( X, w ); 
% yPred(yPred>0.5)=1;
% yPred(yPred<0.5)=0;
% errors=sum(yPred-y)
% end
