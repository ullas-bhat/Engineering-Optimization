% Initialization
clf, hold off, clear

% Constant parameter values
w=1;
ktarget=10000; 
frtarget=300;
xq=[0.022 0.004];
sq1=[0.002 0.0];
sq2=[0.0 -0.0005];
sq3=[0.002 -0.0005];

%alpha=x
%values for all three alphas
a1=fminbnd(@(x)springobjw3(x,xq,sq1,ktarget,frtarget,w),0,20)
D1 = xq(1) + a1*sq1(1);
d1 = xq(2) + a1*sq1(2);
minf1=springobjw3(a1,xq,sq1,ktarget,frtarget,w)


a2o=fminbnd(@(x)springobjw3(x,xq,sq2,ktarget,frtarget,w),0,20)
D2o = xq(1) + a2o*sq2(1);
d2o = xq(2) + a2o*sq2(2);
minf2o=springobjw3(a2o,xq,sq2,ktarget,frtarget,w)


a3=fminbnd(@(x)springobjw3(x,xq,sq3,ktarget,frtarget,w),0,20)
D3 = xq(1) + a3*sq3(1);
d3 = xq(2) + a3*sq3(2);
minf3=springobjw3(a3,xq,sq3,ktarget,frtarget,w)


%% code for running fminbnd with different otpimset options
%disp=iter
options= optimset('Display','iter');

a2=fminbnd(@(x)springobjw3(x,xq,sq2,ktarget,frtarget,w),0,20,options)
D2 = xq(1) + a2*sq2(1);
d2 = xq(2) + a2*sq2(2);
minf2=springobjw3(a2,xq,sq2,ktarget,frtarget,w)

%Tolx=1e-8
options = optimset('Display','iter','TolX',1.0e-8);
a2=fminbnd(@(x)springobjw3(x,xq,sq2,ktarget,frtarget,w),0,20,options)
D2 = xq(1) + a2*sq2(1);
d2 = xq(2) + a2*sq2(2);
minf2=springobjw3(a2,xq,sq2,ktarget,frtarget,w)

