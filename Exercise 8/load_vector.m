function [F] = load_vector(nDof, P)
% [F] = load_vector(nDof, P)
%
% Calculate load vector for a beam model, clamped at one side and
% loaded at the free tip.
%
% Input:
%
% nDof : Number of unknown degrees of freedom
% P    : load at the end of the beam. Three-element vector: [Px, Py, M]
%
% returns: Loadvector F. It contains only the specified load, i.e.
%          reaction forces and moments have been removed.
%




% load vector:
Ftemp = zeros(nDof,1);
Ftemp((end-2):end) = P(:);

% First few components are reactions and are consequently removed.
F = Ftemp(4:end);