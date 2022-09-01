function f_unc = constrained_to_unconstrained(f, con)
    p = 100;
    
    function f_unc = f_unconstrained(x)
        [g, h] = con(x);

        con_sum = 0;
    
        for i = 1:length(g)
            con_sum = con_sum + max(0, g(i))^2;
        end
        for i = 1:length(h)
            con_sum = con_sum + h(i)^2;
        end

        f_unc = f(x) + p * con_sum;
    end

    f_unc = f_unconstrained;
end