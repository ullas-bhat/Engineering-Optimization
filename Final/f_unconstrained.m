function f_val = f_unconstrained(x)
    % Function to convert from constrained to unconstrained space
    % using penalty method
    % x: design variables

    p = 1e6;    % penalty factor
    [g, h] = constraint_functions(x);   % evaluate constraints
    f_val = objective_function(x) + p * sum(max(0, g).^2) + p * sum(h.^2);  % objective function
end