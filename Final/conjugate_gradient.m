% Script to perform conjugate gradient optimization:
clc, clear
max_iter = 1000;
x0 = [1.69 1.82 2.25]';    % Initial guess
convergence = false;    % Flag to indicate convergence
iter = 0;               % Iteration counter

fprintf('Iteration:\tFirst-order optimality:\tStep size:\n');
tic
while ~convergence
    if mod(iter, length(x0)) == 0   % Reset search direction
        s = -forward_diff(@f_unconstrained, x0);        
    else
        df1 = forward_diff(@f_unconstrained, x0);
        df2 = forward_diff(@f_unconstrained, x_prev);
        s = -df1 + (mag(df1)^2 / mag(df2)^2) * s;   % Calculate search direction   
    end
    s = s / mag(s);                         % Normalize search direction
    alpha = fminbnd(@(alpha) f_unconstrained(x0 + alpha*s), 0, 1);  % Line search
    x = x0 + alpha*s;                       % Update x

    iter = iter + 1;     % Increment iteration counter

    dx = x - x0;        % Change in x
    df = forward_diff(@f_unconstrained, x);
    f_update = f_unconstrained(x) - f_unconstrained(x0);
    fprintf('%d\t\t\t%f\t\t\t\t%f\n', iter, mag(df), mag(dx));

    % Check for convergence
    if iter >= max_iter
        convergence = true;
        exit_flag = 0;
        fprintf('Maximum number of iterations reached.\n')
    elseif mag(f_update) <= 1E-6
        convergence = true;
        exit_flag = 1;
        fprintf('Function update tolarance reached.\n')
    elseif mag(x - x0) <= 1E-6
        convergence = true;
        exit_flag = 2;
        fprintf('Step size tolerance reached.\n')
    end

    % Updating values:
    x_prev = x0;
    x0 = x;
end
toc
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
fprintf('x = [%.4f, %.4f, %.4f]\n', x(1), x(2), x(3));
fprintf('Objective function value = %f\n', objective_function(x));
fprintf('Constraint 1 value = %f\n', con1(x));
fprintf('Constraint 2 value = %f\n', con2(x));
fprintf('Constraint 3 value = %f\n', con3(x));
fprintf('First-order optimality = %f\n', mag(dL));
fprintf('Exit flag = %d\n', exit_flag);


% Converting constrained optimization to unconstrained optimization
function f_val = f_unconstrained(x)
    p = 1e6;
    [g, h] = constraint_functions(x);
    f_val = objective_function(x) + p * sum(max(0, g).^2) + p * sum(h.^2);
end



% function [x_opt, f_val, exit_flag, iter] = conjugate_gradient(f, x0, df)
%     convergence = false;
%     iter = 0;
%     max_iter = 1000;
%     while ~convergence
%         if mod(iter, length(x0)) == 0
%             s = -df(f, x0);
%         else
%             s = -df(f, x0) + (mag(df(f, x0))^2 / mag(df(f, x_prev))^2) * s; 
%         end
        
%         s = s / mag(s);
%         f_temp = @(alpha) f(x0 + alpha*s);
%         alpha = fminbnd(f_temp, 0, 1);
%         x = x0 + alpha*s;
%         iter = iter + 1;

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
%         x_prev = x0;
%         x0 = x;
%     end

%     x_opt = x;
%     f_val = f(x);
% end