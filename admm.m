function [w,v]=admm(docs,y,M,X,lambda_sen,lambda_las,rho)

[corpus_size,vocab_size]=size(M);
X = [X, ones(length(docs),1)]; % bias
vocab_size= vocab_size+1;
M = [M, ones(corpus_size,1)];

N = sum(M(:,:));  % Ni is the sum of ith column of M, number of times ith word in vocab appears in the corpus


w=zeros(vocab_size,1);
w = [w; 0];


v=zeros(corpus_size,1);
u=zeros(corpus_size,1);
[m,n]=size(w);

MAXITER = 30;

%%%%%%%%%%%%%%%%%
gOptions.maxIter = 50;
gOptions.verbose = 0; % Set to 0 to turn off output
options.corrections = 10; % Number of corrections to store for L-BFGS methods

lambda = 1; 
lambdaVect = lambda*[0;ones(size(X, 2)-1,1)];
%%%%%%%%%%%%%%%%%

iter = 1;
t =[];

while(iter <= MAXITER)
    tic;
    
    MyMu=updateMu(v,u,N,M,rho);
    
    funObj = @(w)lassoObj(w,v,X,y,M,rho,u,N,MyMu);
    w = L1General2_SPG(funObj,w,lambdaVect,gOptions);
    
    oldV=v;
    for d=1:length(docs)
        for i=1:length(docs(d).sent_offsets)
            z=M(docs(d).sent_offsets(i),:)*w - u(docs(d).sent_offsets(i))./rho; % z_(d,s)

            v(docs(d).sent_offsets(i))=updateV(lambda_sen,rho,z); % v_(d,s)
        end
    end
    
    u = u + rho*(v-M*w);
    iter = iter + 1;
    
    r = v-M*w;
    s = rho*M(v-oldV);
    
    eps_primal = ABSTOL*sqrt(corpus_size) + RELTOL*max([norm(M*w),norm(v)]);
    eps_dual = ABSTOL*sqrt(corpus_size) + RELTOL*max([norm(M*w),norm(v)]);
    
    if norm(r) < eps_primal && norm(s) < eps_dual
        break
    end
    rho=updateRho(r,s,eps_primal,eps_dual);
    disp(['Obj is ',num2str(calcObj(v,w,X,y,M,docs,rho))]);
    disp(['iter ', num2str(iter)]);
    
    toc;
end

save('w_hail_mary', 'w')

end