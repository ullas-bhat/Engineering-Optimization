function con_val = con2(x)
    [g, h] = constraint_functions(x);
    con_val = h(2);
end