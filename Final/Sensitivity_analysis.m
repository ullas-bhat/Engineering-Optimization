%% Sensitivity Analysis Code
clc
clear all
close all
pert = 10.^[-15:-1];

syms P_c;
syms A_t;
syms A_e;
constants
Pcsens=(2.69e-7)*P_c_ref;
Atsens=0.1308*A_t_ref;
Aesens=0.0101*A_e_ref;

constants;
%Analytical Diffs
y=diff(objective_sens(P_c,A_t,A_e),P_c)%Diff_P_c

Analytical_derivatives_first=[vpa(subs(y,[P_c,A_t,A_e],[P_c_ref A_t_ref A_e_ref]))]


y=diff(objective_sens(P_c,A_t,A_e),A_t)%Diff_A_t

Analytical_derivatives_first=[Analytical_derivatives_first vpa(subs(y,[P_c,A_t,A_e],[P_c_ref A_t_ref A_e_ref]))]

y=diff(objective_sens(P_c,A_t,A_e),A_e)%Diff_A_e

Analytical_derivatives_first=[Analytical_derivatives_first vpa(subs(y,[P_c,A_t,A_e],[P_c_ref A_t_ref A_e_ref]))]

%%Second Derivatives
y=diff(objective_sens(P_c,A_t,A_e),P_c,2)%%Diff_P_c

Analytical_derivatives_second=[vpa(subs(y,[P_c,A_t,A_e],[P_c_ref A_t_ref A_e_ref]))]

y=diff(objective_sens(P_c,A_t,A_e),A_t,2)%Diff_A_t


Analytical_derivatives_second=[Analytical_derivatives_second vpa(subs(y,[P_c,A_t,A_e],[P_c_ref A_t_ref A_e_ref]))]

y=diff(objective_sens(P_c,A_t,A_e),A_e,2)%Diff_A_e
Analytical_derivatives_second=[Analytical_derivatives_second vpa(subs(y,[P_c,A_t,A_e],[P_c_ref A_t_ref A_e_ref]))]

%% Find Forward Difference Derivatives
x=[P_c_ref A_t_ref A_e_ref]


for i=1:15
   h=pert(i);
   xtemp1=x;
xtemp2=x;
xtemp3=x;
xtemp4=x;
xtemp5=x;
xtemp6=x;


xcentemp1=x;
xcentemp2=x
xcentemp3=x;
xcentemp4=x;
xcentemp5=x;
xcentemp6=x;

   xtemp1(1)=xtemp1(1)+h*xtemp1(1);
   FFD(1,i)= ( objective_sens(xtemp1(1),xtemp1(2),xtemp1(3)) - objective_sens(x(1),x(2),x(3)) )/(h*x(1));
   
   xtemp2(2)=xtemp2(2)+h*xtemp2(2);
   FFD(2,i)= ( objective_sens(xtemp2(1),xtemp2(2),xtemp2(3)) - objective_sens(x(1),x(2),x(3)) )/(h*x(2));

   xtemp3(3)=xtemp3(3)+h*xtemp3(3);
   FFD(3,i)= ( objective_sens(xtemp3(1),xtemp3(2),xtemp3(3)) - objective_sens(x(1),x(2),x(3)) )/(h*x(3));

   xcentemp1(1)=xcentemp1(1) - h*xcentemp1(1)
  
   CFD(1,i)= ( objective_sens(xtemp1(1),xtemp1(2),xtemp1(3))-objective_sens(xcentemp1(1),xcentemp1(2),xcentemp1(3)) )/(2*h*x(1));

    xcentemp2(2)=xcentemp2(2)-h*xcentemp2(2);
   CFD(2,i)= ( objective_sens(xtemp2(1),xtemp2(2),xtemp2(3))-objective_sens(xcentemp2(1),xcentemp2(2),xcentemp2(3)) )/(2*h*x(2));

 test1(i)= objective_function(xtemp2)
  test2(i)=objective_function(xcentemp2)

    xcentemp3(3)=xcentemp3(3)-h*xcentemp3(3);
   CFD(3,i)= ( objective_sens(xtemp3(1),xtemp3(2),xtemp3(3))-objective_sens(xcentemp3(1),xcentemp3(2),xcentemp3(3)) )/(2*h*x(3));

  
   xtemp4(1)=xtemp4(1)+2*h*xtemp4(1);
   DFD(1,i)=( objective_sens(xtemp4(1),xtemp4(2),xtemp4(3)) - 2*objective_sens(xtemp1(1),xtemp1(2),xtemp1(3)) + objective_sens(x(1),x(2),x(3)) )/((h*x(1)))^2;
  
   xtemp5(2)=xtemp5(2)+2*h*xtemp5(2);
   DFD(2,i)=( objective_sens(xtemp5(1),xtemp5(2),xtemp5(3)) - 2*objective_sens(xtemp2(1),xtemp2(2),xtemp2(3)) + objective_sens(x(1),x(2),x(3)) )/((h*x(2))^2);

   xtemp6(3)=xtemp6(3)+2*h*xtemp6(3);
   DFD(3,i)=( objective_sens(xtemp6(1),xtemp6(2),xtemp6(3)) - 2*objective_sens(xtemp3(1),xtemp3(2),xtemp3(3)) + objective_sens(x(1),x(2),x(3)) )/((h*x(3))^2);

   CDFD(1,i)=(objective_sens(xtemp1(1),xtemp1(2),xtemp1(3)) + objective_sens(xcentemp1(1),xcentemp1(2),xcentemp1(3)) - 2*objective_sens(x(1),x(2),x(3)))/((h*x(1))^2);

   CDFD(2,i)=(objective_sens(xtemp2(1),xtemp2(2),xtemp2(3)) + objective_sens(xcentemp2(1),xcentemp2(2),xcentemp2(3)) - 2*objective_sens(x(1),x(2),x(3)))/((h*x(2))^2);
  
   CDFD(3,i)=(objective_sens(xtemp3(1),xtemp3(2),xtemp3(3)) + objective_sens(xcentemp3(1),xcentemp3(2),xcentemp3(3)) - 2*objective_sens(x(1),x(2),x(3)))/((h*x(3))^2);
   
end

% plot the results
% FFD sensitivity:
figure('color','w')
semilogx(pert, 100*( FFD(1,:)-Analytical_derivatives_first(1))/(Analytical_derivatives_first(1)),'ro--');
hold on
semilogx(pert, 100*((CFD(1,:)-Analytical_derivatives_first(1))/Analytical_derivatives_first(1)),'b*--');
% some additional lines
semilogx(pert, zeros(size(pert)),'k--');
semilogx(pert, ones(size(pert)),'k--');
semilogx(pert, -ones(size(pert)),'k--');
ylim([-10 10])
title(['Relative error of First Order Finite Difference sensitivities P_c']);
xlabel('Relative design perturbation');
ylabel('Error [%] in Derivatives')
legend('Forward FD','Central FD');

% plot the results
% FFD sensitivity:
figure('color','w')
semilogx(pert, 100*( FFD(2,:)-Analytical_derivatives_first(2))/(Analytical_derivatives_first(2)),'ro--');
hold on
semilogx(pert, 100*((CFD(2,:)-Analytical_derivatives_first(2))/Analytical_derivatives_first(2)),'b*--');
% some additional lines
semilogx(pert, zeros(size(pert)),'k--');
semilogx(pert, ones(size(pert)),'k--');
semilogx(pert, -ones(size(pert)),'k--');
ylim([-10 10])
title(['Relative error of  First Order Finite Difference sensitivities A_t']);
xlabel('Relative design perturbation');
ylabel('Error [%] in Derivatives')
legend('Forward FD','Central FD');



% plot the results
% FFD sensitivity:
figure('color','w')
semilogx(pert, 100*( FFD(3,:)-Analytical_derivatives_first(3))/(Analytical_derivatives_first(3)),'ro--');
hold on
semilogx(pert, 100*((CFD(3,:)-Analytical_derivatives_first(3))/Analytical_derivatives_first(3)),'b*--');
% some additional lines
semilogx(pert, zeros(size(pert)),'k--');
semilogx(pert, ones(size(pert)),'k--');
semilogx(pert, -ones(size(pert)),'k--');
ylim([-10 10])
title(['Relative error of  First Order Finite Difference sensitivities A_e']);
xlabel('Relative design perturbation');
ylabel('Error [%] in Derivatives')
legend('Forward FD','Central FD');


% plot the results
% DFD sensitivity:
figure('color','w')
semilogx(pert, 100*( DFD(3,:)-Analytical_derivatives_second(3))/(DFD(3,2)),'ro--');
hold on
semilogx(pert, 100*((CDFD(3,:)-Analytical_derivatives_second(3))/DFD(3,2)),'b*--');
% some additional lines
semilogx(pert, zeros(size(pert)),'k--');
semilogx(pert, ones(size(pert)),'k--');
semilogx(pert, -ones(size(pert)),'k--');
ylim([-10 10])
title(['Relative error of Second Order Finite Difference sensitivities A_e']);
xlabel('Relative design perturbation');
ylabel('Error [%] in Derivatives')
legend('Forward FD','Central FD');


% plot the results
% DFD sensitivity:
figure('color','w')
semilogx(pert, 100*( DFD(2,:)-Analytical_derivatives_second(2))/(Analytical_derivatives_second(2)),'ro--');
hold on
semilogx(pert, 100*((CDFD(2,:)-Analytical_derivatives_second(2))/Analytical_derivatives_second(2)),'b*--');
% some additional lines
semilogx(pert, zeros(size(pert)),'k--');
semilogx(pert, ones(size(pert)),'k--');
semilogx(pert, -ones(size(pert)),'k--');
ylim([-10 10])
title(['Relative error of Second Order Finite Difference sensitivities A_t']);
xlabel('Relative design perturbation');
ylabel('Error [%] in Derivatives')
legend('Forward FD','Central FD');

% plot the results
% DFD sensitivity:
figure('color','w')
semilogx(pert, 100*( DFD(1,:)-Analytical_derivatives_second(1))/(Analytical_derivatives_second(1)),'ro--');
hold on
semilogx(pert, 100*((CDFD(1,:)-Analytical_derivatives_second(1))/Analytical_derivatives_second(1)),'b*--');
% some additional lines
semilogx(pert, zeros(size(pert)),'k--');
semilogx(pert, ones(size(pert)),'k--');
semilogx(pert, -ones(size(pert)),'k--');
ylim([-10 10])
title(['Relative error of Second Order Finite Difference sensitivities P_c']);
xlabel('Relative design perturbation');
ylabel('Error [%] in Derivatives')
legend('Forward FD','Central FD');
