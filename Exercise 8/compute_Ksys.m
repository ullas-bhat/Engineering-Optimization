function [K] = compute_Ksys(L, n, E, A, I)
% [K] = compute_Ksys(L, n, E, A, I)
%
% L : total length of beam, OR: vector with lengths of elements
% n : number of elements the beam will be subdivided in.
% E : Young's modulus of the material the beam is made of
% A : area of the cross-section of the beam
% I : moment of inertia of the cross-section of the beam
%
% returns: K - the system matrix (can be used for semi-analytical sens.)
%
% Matthijs Langelaar, 2011



%__________________________________________________________________
%
%                 INITIALIZATION
%__________________________________________________________________
%

% check input:
error(nargchk(5,5,nargin));

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
%                 K CALCULATION
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
K = Ksys;

