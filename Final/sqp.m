% Script to perform SQP optimization:
clc, clear
max_iter = 1000;
x0 = [1.69 1.82 2.25]';    % Initial guess
lambda0 = [0 0]';     % Initial Lagrange equality multipliers
mu0 = 0;              % Initial lagrange inequality multiplier

tic
W = double_forward_diff(@(x) lagrangian(x, lambda0, mu0), x0);  % Initial Hessian
d_con1 = forward_diff(@con1, x0);   
d_con2 = forward_diff(@con2, x0);
d_con3 = forward_diff(@con3, x0);
A = [d_con1 d_con2 d_con3]';    % Initial constraint Jacobian

df = forward_diff(@objective_function, x0); % Initial gradient
convergence = false;
iter = 0;
options = optimoptions('quadprog', 'Display','none');   % Options for quadprog
% SQP loop
fprintf('Iteration:\tFirst-order optimality:\tStep size:\n');
while ~convergence
    % Move limits for sqp update:
    lb = [-0.1 -0.1 -0.1];
    ub = [0.1 0.1 0.1];
    delta_x = quadprog(W, df, [], [], A, -[con1(x0); con2(x0); con3(x0)], lb, ub, [0 0 0],options); % Update step
    multiplier_update = A'\(-df - W*delta_x);   % Update Lagrange multipliers
    lambda = multiplier_update(1:2);    % Lagrange multipliers for equality constraints
    mu = multiplier_update(3);        % Lagrange multiplier for inequality constraint
    x = x0 + delta_x;   % Update x
    % Ensuring x is not negative
    x = max(0, x);
    iter = iter + 1;    
    dL = forward_diff(@(x) lagrangian(x, lambda, mu), x);   % Calculate Lagrangian gradient

    % Print results:
    fprintf('%d\t\t\t%f\t\t\t\t%f\n', iter, mag(dL), mag(delta_x));
    
    % checking for convergence:
    if iter >= max_iter
        convergence = true;
        exit_flag = 1;
        fprintf('Maximum number of iterations reached.\n');
    elseif mag(dL) < 1e-6
        convergence = true;
        exit_flag = 2;
        fprintf('First-order optimality less than 1e-8.\n');
    elseif mag(delta_x) < 1e-6
        convergence = true;
        exit_flag = 3;
        fprintf('Step size less than 1e-8.\n');
    end

    % Update values:
    x0 = x;
    lambda0 = lambda;
    mu0 = mu;
    W = double_forward_diff(@(x) lagrangian(x, lambda0, mu0), x0);
    d_con1 = forward_diff(@con1, x0);
    d_con2 = forward_diff(@con2, x0);
    d_con3 = forward_diff(@con3, x0);
    A = [d_con1 d_con2 d_con3]';
end
toc
% Print optimization results:
fprintf('Optimization results:\n');
fprintf('x = [%.4f %.4f %.4f]\n', x(1), x(2), x(3));
fprintf('lambda = [%f, %f]\n', lambda(1), lambda(2));
fprintf('mu = %f\n', mu);
fprintf('Objective function value = %f\n', objective_function(x));
fprintf('Constraint 1 value = %f\n', con1(x));
fprintf('Constraint 2 value = %f\n', con2(x));
fprintf('Constraint 3 value = %f\n', con3(x));
fprintf('First-order optimality = %f\n', mag(dL));
fprintf('Exit flag = %d\n', exit_flag);
