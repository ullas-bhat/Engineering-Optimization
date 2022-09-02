
x = [1 1 1]'
%[gen_count,Best_value,Best_vector,exit_flag]=Genetic_Algoirthm(@f_unconstrained,0.5,10,3,100,50,30,1e-6)


options = optimoptions('fmincon','Display','iter','Algorithm','sqp',StepTolerance=1e-8);
%[x,fval]=fmincon(@objective_function,x,[],[],[],[],[],[],@constraint_functions,options)

%[x,fval,exitflag,output] = fminunc(@f_unconstrained,x)

[x,fval]=ga(@objective_function,3,[],[],[],[],[],[],@constraint_functions)
function f_val = f_unconstrained(x)
    [g, h] = constraint_functions(x);
    p = 10000;
    con_sum = 0;

    for i = 1:length(g)
        con_sum = con_sum + max(0, g(i))^2;
    end
    for i = 1:length(h)
        con_sum = con_sum + h(i)^2;
    end

    f_val = objective_function(x) + p * con_sum;
end