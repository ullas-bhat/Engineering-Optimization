function [Kelem] = Kelem_beam(Lelem, E, A, I)
% [Kelem] = Kelem_beam(Lelem, E, A, I)
%
% Lelem : length of beam element
% E     : Young's modulus of the material the beam is made of
% A     : area of the cross-section of the beam
% I     : moment of inertia of the cross-section of the beam
%
% returns: K element matrix, which is 6x6
%




    
% compute element stiffness matrix:    
a = E*A/Lelem;
b = 12*E*I/Lelem^3;
c = 6*E*I/(Lelem^2);
d = 2*E*I/(Lelem);

% calculate Kelem-matrix

    Kelem = [ a   0    0 -a   0    0
              0   b    c  0  -b    c
              0   c  2*d  0  -c    d
             -a   0    0  a   0    0
              0  -b   -c  0   b   -c
              0   c    d  0  -c  2*d ];    
    

