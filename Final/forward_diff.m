function df = forward_diff(f, x)
    h = 1E-08;

    df = zeros(length(x), 1);
    x_forw = x;
    for i = 1:length(x)
        x_forw(i) = x_forw(i) + h;
        df(i) = (f(x_forw) - f(x)) / h;
        x_forw(i) = x_forw(i) - h;
    end
        
end