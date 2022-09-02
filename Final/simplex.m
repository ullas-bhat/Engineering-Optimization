% Script to perform Nelder-Mead simplex optimization:
clc, clear
max_iter = 250;

x0 = [1 1 1]';

% Creating inital simplex
x = [x0 x0+0.1*rand(3,1) x0+0.1*rand(3,1) x0+0.1*rand(3,1)];



% Transformatin parameters:
alpha = 1;
beta = 0.5;
gamma = 2;
delta = 0.5;

% Simplex loop
convergence = 0;
iter = 0;

fprintf('Iterations:\tFunction value:\tTransformation:\n')
while ~convergence
f = [f_unconstrained(x(:,1)) f_unconstrained(x(:,2)) f_unconstrained(x(:,3)) f_unconstrained(x(:,4))];  % Evaluating function at each point
[f_sorted, f_index] = sort(f);  % Sorting function values
x_sorted = x(:,f_index);  % Sorting points

x_centroid = mean(x_sorted(:,1:3),2);  % Calculating centroid
iter = iter + 1;
% Transformatins:
% Reflection
x_reflection = x_centroid + alpha*(x_centroid - x_sorted(:,4));
% Checking validity of reflection:
if f_sorted(1) <= f_unconstrained(x_reflection) && f_unconstrained(x_reflection) < f_sorted(3)
    x_sorted(:,4) = x_reflection;
    transformation = 'Reflection';

elseif f_unconstrained(x_reflection) < f_sorted(1)
    % Expansion:
    x_expansion = x_centroid + gamma*(x_reflection - x_centroid);
    % Checking validity of expansion:
    if f_unconstrained(x_expansion) < f_unconstrained(x_reflection)
        x_sorted(:,4) = x_expansion;
        transformation = 'Expansion';

    else
        x_sorted(:,4) = x_reflection;
        transformation = 'Reflection';

    end
% Contraction:
elseif f_sorted(3) <= f_unconstrained(x_reflection) && f_unconstrained(x_reflection) < f_sorted(4)
    x_contraction = x_centroid + beta*(x_reflection - x_centroid);
    % Checking validity of contraction:
    if f_unconstrained(x_contraction) < f_unconstrained(x_reflection)
        x_sorted(:,4) = x_contraction;
        transformation = 'Contraction';

    else
        % Shrink:
        x_sorted(:,2:4) = x(:,1) + delta*(x(:,2:4) - x(:,1));
        transformation = 'Shrink';

    end
else
    x_contraction = x_centroid + beta*(x_sorted(:,4) - x_centroid);
    % Checking validity of contraction:
    if f_unconstrained(x_contraction) < f_sorted(4)
        x_sorted(:,4) = x_contraction;
        transformation = 'Contraction';

    else
        % Shrink:
        x_sorted(:,2:4) = x(:,1) + delta*(x(:,2:4) - x(:,1));
        transformation = 'Shrink';

    end
end
% Iterations results:
fprintf('%d\t\t\t%f\t\t%s\n', iter, f_sorted(1), transformation)

% Checking convergence:
if iter >= max_iter
    convergence = true;
    exit_flag = 1;
    fprintf('Max iterations reached\n')
elseif abs(f_sorted(1) - f_sorted(4)) < 1e-6
    convergence = true;
    exit_flag = 2;
    fprintf('Function values closer than tolarance\n')
elseif abs(x_sorted(:,1) - x_sorted(:,4)) < 1e-6
    convergence = true;
    exit_flag = 3;
    fprintf('Points closer than tolarance\n')
end
x = x_sorted;   % Updating simplex


end


fprintf('Optimization results:\n');
fprintf('Iterations: %d\n', iter)
fprintf('x = [%f, %f, %f]\n', x(1, 1), x(2, 1), x(3, 1));
fprintf('Objective function value = %f\n', objective_function(x));
[g, h] = constraint_functions(x);
fprintf('Constraint function values:\n');
fprintf('g = %f\n', g);
fprintf('h = [%f, %f]\n', h(1), h(2));


% Converting constrained optimization to unconstrained optimization
function f_val = f_unconstrained(x)
    p = 1e6;
    [g, h] = constraint_functions(x);
    f_val = objective_function(x) + p * sum(max(0, g).^2) + p * sum(h.^2);
end