

% simple beam example

delta = 1e-3;

L=100;
n=10;
P=[0,0,1];
E=2e5;
A=2;
I=3;

[u,R,Kinv] = micro_fem(L,n,P,E,A,I);
format long G
for i=1:3 
    u(end,i) 
end