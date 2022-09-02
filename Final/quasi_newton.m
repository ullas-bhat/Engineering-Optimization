% Script to perform quasi-Newton optimization using the BFGS update
clc, clear
max_iter = 100;
x0 = [1.5 1.5 1.5]';    % Initial guess
B = eye(length(x0));    % Initial Hessian approximation
convergence = false;    % Flag to indicate convergence
iter = 0;               % Iteration counter

fprintf('Iteration:\tFirst-order optimality:\tStep size:\n');
while ~convergence
    s = -B * forward_diff(@f_unconstrained, x0);    % Search direction
    s = s / mag(s);                               % Normalize search direction
    alpha = fminbnd(@(alpha) f_unconstrained(x0 + alpha*s), 0, 1);    % Line search
    x = x0 + alpha*s;    % Update x
    iter = iter + 1;     % Increment iteration counter

    dx = x - x0;        % Change in x
    df = forward_diff(@f_unconstrained, x);
    fprintf('%d\t\t\t%f\t\t\t\t%f\n', iter, mag(df), mag(dx));
    % Check for convergence
    if iter >= max_iter
        convergence = true;
        exit_flag = 0;
        fprintf('Maximum number of iterations reached.')
    elseif mag(forward_diff(@f_unconstrained, x)) <= 1E-4
        convergence = true;
        exit_flag = 1;
        fprintf('Gradient tolerance reached.')
    elseif mag(x - x0) <= 1E-4
        convergence = true;
        exit_flag = 2;
        fprintf('Step size tolerance reached.')
    end

    % Updating values:
    DD = df - forward_diff(@f_unconstrained, x0);    % Change in gradient
    B = B + BFGS_update(B, dx, DD);    % Update Hessian approximation
    x0 = x;    % Update x0
end

% Calculating the Lagrange multipliers:
d_con1 = forward_diff(@con1, x0);   
d_con2 = forward_diff(@con2, x0);
d_con3 = forward_diff(@con3, x0);
A = [d_con1 d_con2 d_con3];
multipliers = A \ -forward_diff(@objective_function, x);
lambda = multipliers(1:2);
mu = multipliers(3);

% Calculating first order optimality of Lagrangian:
dL = forward_diff(@(x) lagrangian(x, lambda, mu), x);

% Print optimization results:
fprintf('Optimization results:\n');
fprintf('x = [%f, %f, %f]\n', x(1), x(2), x(3));
fprintf('lambda = [%f, %f]\n', lambda(1), lambda(2));
fprintf('mu = %f\n', mu);
fprintf('Objective function value = %f\n', objective_function(x));
fprintf('Constraint 1 value = %f\n', con1(x));
fprintf('Constraint 2 value = %f\n', con2(x));
fprintf('Constraint 3 value = %f\n', con3(x));
fprintf('First-order optimality = %f\n', mag(dL));
fprintf('Exit flag = %d\n', exit_flag);




% function [x_opt, f_val, exit_flag, iter] = quasi_newton(f, x0, df, max_iter)
    

%     B = eye(length(x0));
%     convergence = false;
%     iter = 0;

%     while ~convergence
%         s = -B * df(f, x0);
%         s = s / mag(s);
%         alpha = fminbnd(@(alpha) f(x0 + alpha*s), 0, 1);
%         x = x0 + alpha*s;
%         iter = iter + 1

%         if iter >= max_iter
%             convergence = true;
%             exit_flag = 0;
%         elseif mag(df(f, x)) <= 1E-6
%             convergence = true;
%             exit_flag = 1;
%         elseif mag(x - x0) <= 1E-6
%             convergence = true;
%             exit_flag = 2;
%         elseif mag(f(x) - f(x0)) <= 1E-6
%             convergence = true;
%             exit_flag = 3;
%         end

%         dx = x - x0;
%         DD = df(f, x) - df(f, x0);
%         B = B + BFGS_update(B, dx, DD);

%         x0 = x;
%     end

%     x_opt = x;
%     f_val = f(x);
% end