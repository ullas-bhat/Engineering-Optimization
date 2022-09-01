function df = central_diff(f, x)
    h = 1E-08;

    df = zeros(length(x), 1);
    x_forw = x;
    x_back = x;

    for i = 1:length(x)
        x_forw(i) = x_forw(i) + h;
        x_back(i) = x_back(i) - h;
        df(i) = (f(x_forw) - f(x_back)) / (2*h);
        x_forw(i) = x_forw(i) - h;
        x_back(i) = x_back(i) + h;
    end
end