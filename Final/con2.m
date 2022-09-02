function con_val = con2(x)
    % Equality constraint function 
    
    [g, h] = constraint_functions(x);
    con_val = h(2);
end