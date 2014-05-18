clear all; close all; clc; 
 
[M,X,docs,y]=getData();

lambda_sen = 0.001; 
lambda_las = 0.1; 
rho = 1; 
[w,history]=admm(docs,y,M,X,lambda_sen,lambda_las,rho); 

