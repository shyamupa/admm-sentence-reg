function yPred = testW(X,y,w)

sigmoid = @(x) ( 1 ./ ( 1 + exp(-x) ) );
classify = @(x, w) ( sigmoid( x*w ) );
yPred = classify( X, w ); 

end
