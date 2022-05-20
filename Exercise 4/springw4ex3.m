% Initialization
clc, clf, clear

% Setting constants
springparams1;
k_target = 10000;
fr_target = 300;
w = 1;
x_lim = [0.02 0.04; 0.002 0.005];

% Setting solver properties
options = optimoptions('fminunc', 'HessianApproximation', 'bfgs', 'Display', 'iter');
% options = optimset('HessUpdate', 'steepdesc', 'Display', 'iter');
problem.options = options;
problem.x0 = [0.022 0.0035];
problem.objective = @(x) s_objw43(x, k_target, fr_target, w);
problem.solver = 'fminunc';

[x, fval, exitflag, output] = fminunc(problem);

disp('Optima : ')
disp(x)
disp(fval)

% Problem visualization
% Matrix of output values for combinations of design variables D and d 
D = [0.020:0.0005:0.040];
d = [0.002:0.00004:0.005];
for j=1:1:length(d)
  for i=1:1:length(D)
%   Analysis of valve spring.
    [svol,smass,bvol,matc,manc,Lmin,L2,k,F1,F2,Tau1,Tau2,freq1]=...
    springanalysis1(D(i),d(j),L0,L1,n,E,G,rho,Dv,h,p1,p2,nm,ncamfac,nne,matp,bldp);
 	 % Scaled objective function
     fobj(j,i) = ((k-k_target)/k_target)^2 + w*((freq1-fr_target)/fr_target)^2;
     stiffness(j,i) = k;
     freq(j,i) = freq1;
  end
end

% Contour plot of scaled spring optimization problem
%contour(D, d, fobj,[0:0.05:0.2 0.2:0.1:0.5 0.5:0.5:2 2:5:100])
cc = [0.01 0.02 0.05];
contour(D, d, fobj,[cc 10*cc 100*cc 1000*cc 10000*cc 100000*cc 1000000*cc])
xlabel('Coil diameter D (m)'), ylabel('Wire diameter d (m)'), ...
title({'Spring stiffness and'; 'frequency optimization problem (w = 1.0)'})
hold on
[C,h] = contour(D,d,stiffness,[10000 10000], 'Color', '#EDB120');
h.LineWidth = 1;
[C,h] = contour(D,d,freq,[300 300], 'Color', '#77AC30');
h.LineWidth = 1;
grid
c = [0 0.4470 0.7410; 1 0 0];
scatter([problem.x0(1) x(1)], [problem.x0(2) x(2)], 25, c, 'o', 'filled')

