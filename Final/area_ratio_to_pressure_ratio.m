function pressure_ratio = area_ratio_to_pressure_ratio(area_ratio)
    constants;

    j = 2 * g / (g - 1);
    k = 2 / g;
    l = (g - 1) / g;

    pressure_ratio0 = 0.015;
    func = @(pressure_ratio) area_ratio - G/sqrt(j * ...
        pressure_ratio^k * (1-pressure_ratio^l));
    options = optimoptions('fsolve', 'Display', 'none');
    pressure_ratio = fsolve(func, pressure_ratio0, options);

end