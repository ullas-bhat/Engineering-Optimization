function x = mag(X)
    % Function to calculate the magnitude of a vector
    
    x = sqrt(sum(X .* X));
end