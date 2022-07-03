function x_scaled = scale(x, x_ref)
    for i = 1:length(x)
        x_scaled(i) = x(i) / x_ref(i);
    end
end