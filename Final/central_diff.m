function df = central_diff(f, x)
    % Function to calculate central finite difference gradient
    % of a function f at point x
    % f: function handle
    % x: point at which to calculate gradient
    % df: gradient of f at x

    h = 1E-08;  % step size

    df = zeros(length(x), 1);   % initialize gradient vector
   

    for i = 1:length(x)
        x_forw = x;                 % initialize forward step vector
        x_back = x;                 % initialize backward step vector
        x_forw(i) = x_forw(i) + h;  % forward step
        x_back(i) = x_back(i) - h;  % backward step
        df(i) = (f(x_forw) - f(x_back)) / (2*h); % central difference
    end
end