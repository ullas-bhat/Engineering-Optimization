function [g_con, h_con] = constraint_functions(x)
    constants;
    x_descale = descale(x);

    P_c = x_descale(1);
    A_t = x_descale(2);
    A_e = x_descale(3);

    mass_flow = G * P_c * A_t / sqrt(R * T_c);

    j = 2 * g / (g - 1);
    k = 2 / g;
    l = (g - 1) / g;

    area_ratio = A_e / A_t;
    pressure_ratio = area_ratio_to_pressure_ratio(area_ratio);
    P_e = P_c * pressure_ratio;

    u_e = sqrt(j * R * T_c * (1-pressure_ratio^l));
    thrust = mass_flow * u_e + (P_e - P_a)*A_e;
    mass_wet = objective_function(x) * mass_dry_ref + mass_N2O4 + mass_UDMH;
    thrust_factor = thrust / (mass_wet * accel_g);
    Isp = thrust / (mass_flow * accel_g);

    g_con(1) = 1 - Isp/Isp_ref;
    h_con(1) = 1 - thrust_factor/thrust_factor_ref;
    h_con(2) = 1 - mass_flow/mass_flow_ref; 

end