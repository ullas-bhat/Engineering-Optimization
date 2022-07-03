<<<<<<< HEAD
function [] = Simplex(x0,maxiter)
%SIMPLEX Implementation of Nelder mead simplex method
%   Detailed explanation goes here
clc
clear all
close all
constants;
x0=[1,1,1]
pert=0.05;
iter=0;
x1(1)=x0(1)+pert;
x1(2)=x0(2);
x1(3)=x0(3);

x2(1)=x0(1);
x2(2)=x0(2)+pert;
x2(3)=x0(3);

x3(1)=x0(1);
x3(2)=x0(2);
x3(3)=x0(3)+pert;
[g0,h0]=calc_constraints(x0);
[g1,h2]=calc_constraints(x1);
[g3,h3]=calc_constraints(x2);
[g4,h4]=calc_constraints(x3);



options = optimoptions('fmincon','Display','iter','Algorithm','sqp','TolX',1E-8,'plotfcns',@optimplotfval);
A = []; 
b = [];
Aeq = [];
beq = [];
lb = [0.1, 0.1, 0.1];
ub = [10, 10, 10];
tic
[xout1, fval1, exitflag1, output1, lambda1] = fmincon(@(x0)calc_objective_test2(x0),x0,A,b,Aeq,beq,lb,ub,[],options);
toc
objective=calc_objective_test(xout1)
[g,h]=calc_constraints(xout1)

xout1



        
   
        




end

=======
function [] = Simplex()
%SIMPLEX Summary of this function goes here
%   Detailed explanation goes here

end

>>>>>>> effc81c97095aab48138219e61cb93631f7b5df3
