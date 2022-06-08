function [Ksys] = assemble_K(elem_no,Kelem,Ksys)
% [Ksys] = assemble_K(elem_no,Kelem,Ksys)
%
% elem_no : element number
% Kelem   : element matrix to be added in system matrix
% Ksys    : partially assembled system matrix
%
% returns: Ksys which includes Kelem
%

% determine location in matrix:
locvec = [1:6] + (elem_no-1)*3;

% add element to matrix:
Ksys(locvec,locvec) = Ksys(locvec,locvec) + Kelem;
