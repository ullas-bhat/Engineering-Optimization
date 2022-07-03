function [g, h] = calc_constraints(x_scaled)
    % Function to calculate constraints at design point x

    constants;  % values of constants used
    
    x = descale(x_scaled, x_ref);

    P_c = x(1);
    A_t = x(2);
    A_e = x(3);
    
    
    % Motor perfomance values from IRT simulations
    thrust_ref =  1.742630969760778e+06;
    Isp_ref = 2.779207422017025e+02;

    thrust_factor_ref = thrust_ref / ((mass_dry + m_UDMH + m_N2O4) * g0);
    
    mass_flow = Gamma * P_c * A_t / sqrt(R * T_c);  % mass flow through the nozzle (kg/s)
    
    % temp calculation variables
    a = 2 * gamma_val / (gamma_val - 1);
    b = 2 / gamma_val;
    c = (gamma_val - 1) / (gamma_val);


    % Calculating exit pressure
    options = optimoptions('fsolve', 'Display', 'none');
    func = @(P_e) A_e/A_t - Gamma/sqrt(a * (P_e/P_c)^b * (1 - (P_e/P_c)^c));
    P_e = fsolve(func, 1E+05, options);  % exit pressure of nozzle (Pa)

    u_e = sqrt(a * R * T_c * (1 - (P_e/P_c)^c));    % exit velocity of nozzle (m/s)
    
    thrust = mass_flow * u_e + (P_e - P_a)*A_e; % thrust calculated using IRT (N)
    Isp = thrust / (mass_flow * g0);    % Isp (s)

    total_mass_dry = calc_objective_test(x_scaled);
    total_mass_wet = total_mass_dry + m_UDMH + m_N2O4;
    thrust_factor = thrust / (total_mass_wet * g0);

    g(1) = 1 - Isp/Isp_ref;   % Isp constraint
    h(1) = 1 - thrust_factor/thrust_factor_ref; % thrust constraint

end