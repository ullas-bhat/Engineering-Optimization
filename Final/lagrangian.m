function L = lagrangian(x, lambda, mu)
    % Function to calculate the lagrangian at x
    % x: vector of x values
    % lamda: vector of lagrange equality multipliers
    % mu: vector of lagrange inequality multipliers
    % L: lagrangian at x
    
    [g, h] = constraint_functions(x);   % Calculate the constraint functions
    L = objective_function(x) + mu'*g + lambda'*h;   % Calculate the legrangian
end