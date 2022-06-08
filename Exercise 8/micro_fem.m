function [u,R, Kinv, K0] = micro_fem(L, n, P, E, A, I)
% [u,R, Kinv, K0] = micro_fem(L, n, P, E, A, I)
%
% L : total length of beam, OR: vector with lengths of elements
% n : number of elements the beam will be subdivided in.
% P : load at the end of the beam. Three-element vector: [Px, Py, M]
% E : Young's modulus of the material the beam is made of
% A : area of the cross-section of the beam
% I : moment of inertia of the cross-section of the beam
%
% returns: u, a (n+1)-by-3 matrix, each row contains the DOFs of a node,
%          in the order [u, v, phi]. The first row corresponds to the
%          clamped start of the beam, the last row to the end.
%          R, a 3-element vector containing the reaction force at the
%          first node, in the order [Rx, Ry, M].
%          Kinv - inverse of system matrix (can be used for semi-analytical
%          sens.)
%          K0 - the system matrix (can be used for semi-analytical sens.)


% this variable controls whether the result is plotted:
% set it to 0 to suppress plotting, or to 1 otherwise.
plot_solution = 1;


%__________________________________________________________________
%
%                 INITIALIZATION
%__________________________________________________________________
%

% check input:
error(nargchk(6,6,nargin));

% Get element lengths:
if length(L)==n
    % indiv. element lengths given. compute total length
    Lelem = L; L = sum(L);
else
   % total length specified: subdivide into equal elements
   Lelem = L/n*ones(1,n);
end

% Calculate DOF, for entire model:
nDof = 3*(n+1);



%__________________________________________________________________
%
%                 FEM CALCULATION
%__________________________________________________________________
%

% Set up the system matrix. Done element-by-element
Ksys = zeros(nDof);
for i=1:n
    % Calculate single element contribution
    Kelem = kelem_beam(Lelem(i), E, A, I);
    % Add it to the system matrix
    Ksys  = assemble_K(i,Kelem,Ksys);
end
K0 = Ksys;

% Invert Ksys, b.c. are taken into account
Kinv = invert_K(nDof,Ksys);

% Set up the vector of prescribed loads:
F = load_vector(nDof, P);

% "back substitution":
Usub = Kinv * F;
U = [0; 0; 0; Usub(:)];


%__________________________________________________________________
%
%                 POST PROCESSING
%__________________________________________________________________
%

% reformat solution vector:
u = reshape(U,3,n+1)';


% compute reaction forces:
R = Ksys(1:3,4:end)*Usub;


% plot the solution
if plot_solution
    scale_fac = 0.1*L/sqrt( u(end,1)^2 + u(end,2)^2 );
    if scale_fac==0, scale_fac=1; end;
    x = [0, cumsum(Lelem)]'; 
    dx = u(:,1)*scale_fac;
    y = u(:,2)*scale_fac;
    
    plot(x+dx,y,'-bo'); axis equal
    title('Deformed beam');
end

