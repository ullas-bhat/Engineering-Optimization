function ddf = double_forward_diff(f, x)
    % Function to calculate the double forward difference of a function f wrt x
    % f: function handle
    % x: point at which the double forward difference is to be calculated
    % ddf: double forward difference of f wrt x

    h = 1e-4;   % step size
    ddf = zeros(length(x), length(x));  % initialize the matrix
    
    for i = 1:length(x)
        x1 = x; 
        x1(i) = x1(i) + h;  % x1 is x with the ith element incremented by h
        for j = 1:length(x)
            x2 = x; 
            x3 = x1;
            x2(j) = x2(j) + h;  % x2 is x with the jth element incremented by h
            x3(j) = x3(j) + h;  % x3 is x1 with the jth element incremented by h

            ddf(i,j) = (f(x3) - f(x1) - f(x2) + f(x)) / h^2;    % compute the double derivative
        end
    end

end