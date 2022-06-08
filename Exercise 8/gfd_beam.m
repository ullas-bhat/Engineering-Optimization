function gfd_beam(n)
% gfd_beam(n)
% n      = number of elements (optional, default 10)
%
% This script compares sensitivities computed by the Global Finite
% Difference approach for the beam example. Forward and central finite
% differences are considered. The output consists of two graphs with the
% relative error of the sensitivity results as a function of the relative
% design perturbation. Furthermore, the total evaluation time is listed.
% The number of elements n can be varied to examine the effect of mesh
% refinement.

% preparations
format long g


% define beam constants
L = 100;         % initial length
P = [1,1,0];     % load vector at tip: [Fx Fy M]
E = 2e5;         % Young's modulus
A = 2;           % cross-sectional area
I = 3;           % moment of inertia

% set number of elements
if ~nargin
    n = 10;  % relatively coarse mesh
    %n = 100; % fine mesh
end

% compute analytical sensitivity values, used as reference
dux_dL = P(1)/(E*A);
duy_dL = P(2)*L^2/(E*I);
du_ref = [dux_dL; duy_dL];

% relative design perturbations
pert = 10.^[-15:-1];

% compute forward finite difference sensitivities:
disp('Forward finite differences')
tic
sens_forward = ffd(pert, L, n, P, E, A, I);
toc

% compute central finite difference sensitivities:
disp('Central finite differences')
tic
sens_central = cfd(pert, L, n, P, E, A, I);
toc

% plot the results
% ux sensitivity:
figure('color','w')
semilogx(pert, 100*(sens_forward(1,:)-dux_dL)/dux_dL,'ro--');
hold on
semilogx(pert, 100*(sens_central(1,:)-dux_dL)/dux_dL,'b*--');
% some additional lines
semilogx(pert, zeros(size(pert)),'k--');
semilogx(pert, ones(size(pert)),'k--');
semilogx(pert, -ones(size(pert)),'k--');

title(['Relative error of GFD sensitivities for mesh with ',...
    num2str(n),' elements']);
xlabel('Relative design perturbation');
ylabel('Error [%] in du_x/dL')
legend('Forward FD','Central FD');

set(gca,'ylim',[-5 5]);

% uy sensitivity:
figure('color','w')
semilogx(pert, 100*(sens_forward(2,:)-duy_dL)/duy_dL,'ro--');
hold on
semilogx(pert, 100*(sens_central(2,:)-duy_dL)/duy_dL,'b*--');
% some additional lines
semilogx(pert, zeros(size(pert)),'k--');
semilogx(pert, ones(size(pert)),'k--');
semilogx(pert, -ones(size(pert)),'k--');

title(['Relative error of GFD sensitivities for mesh with ',...
    num2str(n),' elements']);
xlabel('Relative design perturbation');
ylabel('Error [%] in du_y/dL')
legend('Forward FD','Central FD');

set(gca,'ylim',[-5 5]);



%% ----------------
% subroutines that perform the actual calculations

function sens = ffd (pert, L, n, P, E, A, I)
% ffd computes the forward finite difference sensitivity for every
% perturbation given in 'pert' and returns it in 'sens'.

% perform FEA for unperturbed case:
[u,R,Kinv] = micro_fem(L,n,P,E,A,I);
u0 = [u(n+1,1); u(n+1,2)]; % nominal tip displacement

% compute ffd derivative:
sens = zeros(2,length(pert));
for i=1:length(pert)
    [u,R,Kinv] = micro_fem(L*(1+pert(i)),n,P,E,A,I);
    utip = [u(n+1,1); u(n+1,2)];
    sens(:,i) = (utip - u0)/(pert(i)*L);
end


function sens = cfd (pert, L, n, P, E, A, I)
% cfd computes the central finite difference sensitivity for every
% perturbation given in 'pert' and returns it in 'sens'.

% perform FEA for unperturbed case: # not needed for cfd sensitivity.
%[u,R,Kinv] = micro_fem(L,n,P,E,A,I);
%u0 = [u(n+1,1); u(n+1,2)]; % nominal tip displacement

% compute cfd derivative:
sens = zeros(2,length(pert));
for i=1:length(pert)
    [u,R,Kinv] = micro_fem(L*(1-pert(i)),n,P,E,A,I);
    utip1 = [u(n+1,1); u(n+1,2)];

    [u,R,Kinv] = micro_fem(L*(1+pert(i)),n,P,E,A,I);
    utip2 = [u(n+1,1); u(n+1,2)];
    
    sens(:,i) = (utip2 - utip1)/(2*pert(i)*L);
end

