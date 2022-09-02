function con_val = con1(x)
    % Equality constraint function

    [g, h] = constraint_functions(x);
    con_val = h(1);
end