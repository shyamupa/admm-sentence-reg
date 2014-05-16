function testW(X,y,w)

sigmoid = @(x) ( 1 ./ ( 1 + exp(-x) ) );
classify = @(x, w) ( sigmoid( x*w ) );
yPred1 = classify( X, w ); 

sum (yPred1  > .5 ~= y);

end
