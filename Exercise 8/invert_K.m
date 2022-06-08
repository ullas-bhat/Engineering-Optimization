function [Kinv] = invert_K(nDof, Ksys)
% [Kinv] = invert_K(nDof,Ksys)
%
% nDof  : number of degrees of freedom
% Ksys  : system matrix which has been assembled
%
% returns:  Kinv - inverse of system matrix
%           Before Kinv has been calculated, known degrees of freedom are eliminated.         
%



% first node is clamped, all DOFs are zero.
% therefore to solve the system it's sufficient to
% consider only the nonsingular submatrix:
Ksub = Ksys(4:end,4:end);

% invert:
Kinv = inv(Ksub);
