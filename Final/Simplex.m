%SIMPLEX Implementation of Nelder mead simplex method
%   Detailed explanation goes here
clc
clear all
close all
constants;
maxiter=100000;
x0=[1,1,1]
pert=0.01;
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

alpha_simp=1;
beta_simp=0.5;
gamma_simp=2;
delta_simp=0.5;

xarray=[x0 x1 x2 x3]

xs=x0;
x2s=x1;
x2h=x2;
xh=x3;

xplot=1;
iterplot=0;
% options = optimoptions('fmincon','Display','iter','MaxfunctionEvaluations',10000,'Algorithm','sqp','TolX',1E-8,'plotfcns',@optimplotfval);
% A = []; 
% b = [];
% Aeq = [];
% beq = [];
% lb = [0.1, 0.1, 0.1];
% ub = [10, 10, 10];
% tic
% [xout1, fval1, exitflag1, output1, lambda1] = fmincon(@(x0)calc_objective_test2(x0),x0,A,b,Aeq,beq,lb,ub,[],options);
% toc
% objective=calc_objective_test(xout1)
% [g,h]=calc_constraints(xout1)
% 
% xout1
convergence=0;
    while iter<=maxiter && convergence==0
    
        shrink=0;
        
    fun=[{calc_objective_test2(x0) calc_objective_test2(x1) calc_objective_test2(x2) calc_objective_test2(x3)};{xs x2s x2h xh}]
       
    fun=sortrows(fun',1);
    xs=cell2mat(fun(1,2))
    x2s=cell2mat(fun(2,2))
    x2h=cell2mat(fun(3,2))
    xh=cell2mat(fun(4,2))
        
      


    c=(xs+x2s+x2h)/3;%centroid

    xr=c+alpha_simp*(c-xh);
    xcr=c+beta_simp*(xr-c);
    xe=c+gamma_simp*(xr-c);
    xch=c+beta_simp*(xh-c);
    if calc_objective_test2(xr)<calc_objective_test2(x1)
        
        if calc_objective_test2(xe)<calc_objective_test2(xr)
            xnew=xe
        elseif calc_objective_test2(xcr)<calc_objective_test2(xr)
            xnew=xcr    
        else
            xnew=xr
        end
  
        
    else 

        if calc_objective_test2(xch)<calc_objective_test2(xh)
            xnew=xch
        else
           shrink=1;
        end
    end 
   if shrink==0
       
           x0=xs+delta_simp*(x0-xs);
           x1=xs+delta_simp*(x1-xs);
           x2=xs+delta_simp*(x2-xs);
           x3=xs+delta_simp*(x3-xs);
   else
       xh=xnew;
       fun(:,2)=[{xs x2s x2h xh}];
       fun(4,1)={calc_objective_test2(xh)};

   end
   iter=iter+1;

    f1=calc_objective_test2(xs);
    f2=calc_objective_test2(x2s);
    f3=calc_objective_test2(x2h);
    f4=calc_objective_test2(xh);

xplot=[xplot,xs];
iterplot=[iterplot,iter];
plot(xs,iter)
if abs(x2s-xs)<=1e-6 & abs(x2s-x2h)<=1e-6 & abs(x2h-xh)<=1e-6 & abs(xh-x2s)<=1e-6
    convergence=1;
    disp('exitflag1')
elseif abs(f1-f2)<=1e-6 & abs(f2-f3)<=1e-6 & abs(f3-f4)<=1e-6 & abs(f4-f1)<=1e-6
        convergence=1;
        disp('exitflag2')
        calc_objective_test2(xh)
end
    
    
iter 

    end
    
    

        
   
        




