clc, clear
x0 = [1.69 1.82 2.25]';


lb = [0.1 0.1 0.1];
ub = [10 10 10];
options = optimoptions('fminunc', 'Algorithm', 'quasi-newton')
tic
[x,fval,exitflag,output] = fminunc(@f_unconstrained, x0);
toc
output

mag(forward_diff(@f_unconstrained, x))
fprintf('x = [%.4f %.4f %.4f]\n', x(1), x(2), x(3));
fprintf('F val %.4f', objective_function(x))

