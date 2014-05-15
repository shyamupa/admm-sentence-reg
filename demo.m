clear all; close all; clc; 
 
[M,X,docs,y]=getData();

lambda_sen = 1; 
lambda_las = 1; 
rho = 1; 
[w,v]=admm(docs,y,M,X,lambda_sen,lambda_las,rho); 

