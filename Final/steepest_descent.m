function [x_opt, f_val, exit_flag, iter] = steepest_descent(f, x0, df)
    convergence = false;
    iter = 0;
    max_iter = 25;
    
    while ~convergence
        s = -df(f, x0);
        s = s / mag(s);
        alpha = fminbnd(@(alpha) f(x0 + alpha*s), 0, 1);
        x = x0 + alpha*s;
        iter = iter + 1

        if iter >= max_iter
            convergence = true;
            exit_flag = 0;
        elseif mag(df(f, x)) <= 1E-6
            convergence = true;
            exit_flag = 1;
        elseif mag(x - x0) <= 1E-6
            convergence = true;
            exit_flag = 2;
        elseif mag(f(x) - f(x0)) <= 1E-6
            convergence = true;
            exit_flag = 3;
        end
        x0 = x;
    end

    x_opt = x;
    f_val = f(x);
end