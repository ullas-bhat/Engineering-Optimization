clc, clear

clc, clear
x = [0.5 0.5 0.5]';
[x_opt, f_val, exit_flag, iter] = steepest_descent(@f_unconstrained, x, @forward_diff)




function f_val = f_unconstrained(x)
    [g, h] = constraint_functions(x);
    p = 100;
    con_sum = 0;

    for i = 1:length(g)
        con_sum = con_sum + max(0, g(i))^2;
    end
    for i = 1:length(h)
        con_sum = con_sum + h(i)^2;
    end

    f_val = objective_function(x) + p * con_sum;
end