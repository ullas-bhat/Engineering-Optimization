function con_val = con3(x)
    [g, h] = constraint_functions(x);
    con_val = g;
end