function [w,v,history]=admm(docs,y,M,X,lambda_sen,lambda_las,rho)

[corpus_size,vocab_size]=size(M);

% bias
% X = [X, ones(length(docs),1)]; 
% vocab_size = vocab_size+1;
% M = [M, ones(corpus_size,1)];

N = sum(M(:,:));  % Ni is the sum of ith column of M, number of times ith word in vocab appears in the corpus
N = N';

w=zeros(vocab_size,1);
v=zeros(corpus_size,1);
u=zeros(corpus_size,1);
[m,n]=size(w);

MAXITER = 200;
ABSTOL = 0.001;
RELTOL = 0.001;

%%%%%%%%%%%%%%%%%
gOptions.maxIter = 50;
gOptions.verbose = 0; % Set to 0 to turn off output
options.corrections = 10; % Number of corrections to store for L-BFGS methods

lambda = 1; 
lambdaVect = lambda*[0;ones(size(X, 2)-1,1)];
%%%%%%%%%%%%%%%%%

iter = 1;
t =[];

history(MAXITER).r=[];
history(MAXITER).s=[];
history(MAXITER).eps_primal=[];
history(MAXITER).eps_dual=[];

while(iter <= MAXITER)
    tic;
    MyMu=updateMu(v,u,N,M,rho);
    time=toc;
    fprintf('Time taken for Mu Update %f \n',time);

    tic;
    funObj = @(w)lassoObj(w,v,X,y,M,rho,u,N,MyMu);
    w = L1General2_SPG(funObj,w,lambdaVect,gOptions);
    time=toc;
    fprintf('Time taken for W Update %f \n',time);
    
    tic;
    oldV=v;
    for d=1:length(docs)
        tic;
        for i=1:length(docs(d).sent_offsets)
            z(i) = M(docs(d).sent_offsets(i),:)*w - u(docs(d).sent_offsets(i))./rho; % z_(d,s)
%             fprintf('%f is \n',norm(z));
%             pause;
        end
        time=toc;
        fprintf('time taken for z %f',time);
        pause;
        parfor i=1:length(docs(d).sent_offsets)
            v{i}=updateV(lambda_sen,rho,z(i)); % v_(d,s)
        end
    end
    time=toc;
    fprintf('Time taken for V Update %f \n',time);
    assert(~isequal(v,oldV));
    
    u = u + rho*(v-M*w);
    iter = iter + 1;
    
    r = v-M*w;
    s = rho*M'*(v-oldV);
    
    eps_primal = ABSTOL*sqrt(corpus_size) + RELTOL*max([norm(M*w),norm(v)]);
    eps_dual = ABSTOL*sqrt(corpus_size) + RELTOL*max([norm(M*w),norm(v)]);
    
    if norm(r) < eps_primal && norm(s) < eps_dual
        break
    else
        history(iter).r = norm(r);
        history(iter).s = norm(s);
        history(iter).eps_primal = eps_primal;
        history(iter).eps_dual = eps_dual;
    end
    fprintf('Obj is %f, r is %f e_p is %f, s is %f e_d is %f \n',calcObj(v,w,X,y,M,docs,rho),norm(r),eps_primal,norm(s),eps_dual);
end

end