clear all; close all; clc; 
 
[M,X,docs,y]=getData();

% bias
X = [X, ones(size(X,1),1)]; % one more col to X
y(y==0)=-1; % important!
M = [M, ones(size(M,1),1)]; % one more col to M

lambda_sen = 0.001; 
lambda_las = 0.1; 
rho = 1; 
[w,history]=admm(docs,y,M,X,lambda_sen,lambda_las,rho); 
predict(X,y,w);
