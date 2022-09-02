function pressure_ratio = area_ratio_to_pressure_ratio(area_ratio)
    g = 1.2096; % specific heat ratio
    G = sqrt(g) * (2/(g+1))^((g+1)/(2*g-2));    % Vandenkerckhove parameter

    % Temporary variables
    j = 2 * g / (g - 1);
    k = 2 / g;
    l = (g - 1) / g;

    pressure_ratio0 = 0.015;        % Initial guess
    func = @(pressure_ratio) area_ratio - G/sqrt(j * ...
        pressure_ratio^k * (1-pressure_ratio^l));   % Function to solve
    options = optimoptions('fsolve', 'Display', 'none');
    pressure_ratio = fsolve(func, pressure_ratio0, options);

end