function [x_opt, f_val, exit_flag, iter] = conjugate_gradient(f, x0, df)
    convergence = false;
    iter = 0;
    max_iter = 1000;
    while ~convergence
        if mod(iter, length(x0)) == 0
            s = -df(f, x0);
        else
            s = -df(f, x0) + (mag(df(f, x0))^2 / mag(df(f, x_prev))^2) * s; 
        end
        
        s = s / mag(s);
        f_temp = @(alpha) f(x0 + alpha*s);
        alpha = fminbnd(f_temp, 0, 1);
        x = x0 + alpha*s;
        iter = iter + 1;

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
        x_prev = x0;
        x0 = x;
    end

    x_opt = x;
    f_val = f(x);
end