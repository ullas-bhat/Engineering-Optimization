function con_val = con3(x)
    % Inequality constraint function
    
    [g, h] = constraint_functions(x);
    con_val = g;
end