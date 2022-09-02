function con_val = con1(x)
    [g, h] = constraint_functions(x);
    con_val = h(1);
end