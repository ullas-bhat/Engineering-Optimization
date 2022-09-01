function x = descale(x_scaled)
    constants;
    x = x_scaled .* x_ref;
end