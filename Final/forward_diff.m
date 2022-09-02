function df = forward_diff(f, x)
    % Function to compute the forward difference gradient 
    % of a function f at a point x
    % f: function handle
    % x: point at which to compute the gradient
    % df: gradient of f at x

    h = 1E-08;  % step size

    df = zeros(length(x), 1);   % initialize gradient vector
    x_forw = x; 
    for i = 1:length(x)
        x_forw = x; % initialize forward step
        x_forw(i) = x_forw(i) + h;  % take forward step
        df(i) = (f(x_forw) - f(x)) / h; % compute forward difference
    end
        
end