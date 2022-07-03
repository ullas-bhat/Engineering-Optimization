function x = descale(x_scaled, x_ref)
    for i = 1:length(x_scaled)
        x(i) = x_scaled(i) * x_ref(i);
    end
end