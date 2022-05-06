% Initialization
clf
clear

% Importing preset spring properties
springparams1;

% Nominal valve area:
  Av = Dv^2*pi/4;

% Minimum needed spring force at closed valve:
  F1min = Av*p1;

% Minimum needed spring force at full opened valve:
  F2min = Av*p2;

% Maximum allowable sheer stress:
  Taumax = 600E+06;

% Lower bound for first eigenfrequency:
  freq1lb = ncamfac * 0.5 * nm;

% Matrix of output values for combinations of design variables D and d 
D = [0.020:0.001:0.040];
d = [0.002:0.0002:0.005];

for j=1:1:length(d)
  for i=1:1:length(D)
%   Analysis of valve spring.
    [svol,smass,bvol,matc,manc,Lmin,L2,k,F1,F2,Tau1,Tau2,freq1]=...
    springanalysis1(D(i),d(j),L0,L1,n,E,G,rho,Dv,h,p1,p2,nm,ncamfac,nne,matp,bldp);
    
    % Objective function
    obj_func(j, i) = smass;

    % Constraint functions in scaled null negative form
    con_func_L2(j, i) = 1 - L2/Lmin;
    con_func_F1(j, i) = 1 - F1/F1min;
    con_func_F2(j, i) = 1 - F2/F2min;
    con_func_Tau2(j, i) = Tau2/Taumax - 1;
    con_func_freq1(j, i) = 1 - freq1/freq1lb;
  end
end

% Constraint contour plots
contour(D, d, con_func_L2,[ -0.3 -0.2 -0.1 0], 'ShowText','on')
xlabel('D (m)'), ylabel('d (m)'), ...
   title('Contours of L2 constraint') 
grid

contour(D, d, con_func_F1,[ -0.3 -0.2 -0.1 0], 'ShowText','on')
xlabel('D (m)'), ylabel('d (m)'), ...
   title('Contours of F1 constraint') 
grid
contour(D, d, con_func_F2,[ -0.3 -0.2 -0.1 0], 'ShowText','on')
xlabel('D (m)'), ylabel('d (m)'), ...
   title('Contours of F2 constraint') 
grid

contour(D, d, con_func_Tau2,[ -0.3 -0.2 -0.1 0], 'ShowText','on')
xlabel('D (m)'), ylabel('d (m)'), ...
   title('Contours of Tau2 constraint') 
grid

contour(D, d, con_func_freq1,[ -0.3 -0.2 -0.1 0], 'ShowText','on')
xlabel('D (m)'), ylabel('d (m)'), ...
   title('Contours of freq1 constraint') 
grid

% Design space plot
contourf(D, d, con_func_L2, [0 0], 'FaceColor', '#FF0000')
hold on
contourf(D, d, con_func_F1, [0 0], 'FaceColor', '#FF0000')
contourf(D, d, con_func_F2, [0 0], 'FaceColor', '#FF0000')
contourf(D, d, con_func_Tau2, [0 0], 'FaceColor', '#FF0000')
contourf(D, d, con_func_freq1, [0 0], 'FaceColor', '#FF0000')
hold off
xlabel('D (m)'), ylabel('d (m)'), title('Design space')
grid


% Contour plot of spring mass (kg)
contour(D, d, obj_func, 'ShowText','on')
xlabel('D (m)'), ylabel('d (m)'), title('Contour of smass (kg)')
grid




