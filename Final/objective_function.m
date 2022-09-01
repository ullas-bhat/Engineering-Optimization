function mass_scaled = objective_function(x)
    constants;
    x_descale = descale(x);

    P_c = x_descale(1);
    A_t = x_descale(2);
    A_e = x_descale(3);
    
    t_cyl = f * P_c * R_tank / sigma_tank;
    t_sph = t_cyl / 2;
    mass_UDMH_tank = (2*pi*t_cyl*R_tank*L_UDMH_tank + ...
        4*pi*t_sph*R_tank^2) * rho_tank;
    mass_N2O4_tank = (2*pi*t_cyl*R_tank*L_N2O4_tank + ...
        4*pi*t_sph*R_tank^2) * rho_tank;

    mass_flow = G * P_c * A_t / sqrt(R * T_c);
    A_c = mass_flow * R * T_c / (0.3 * P_c * sqrt(g*R*T_c));
    R_c = sqrt(A_c / pi);
    V_c = pi * R_c^2 * L_c;
    k_load = 1;
    
    mass_chamber = f * k_load * (2/(L_c/R_c) + 2) * rho_cn/sigma_cn * P_c * V_c;
    mass_injector = f * (rho_cn/sigma_cn) * (1.2*A_c*R_c*sqrt(P_c*sigma_cn));
    mass_nozzle = f * (rho_cn/sigma_cn) * (A_t * ((A_e/A_t - 1)/sin(alpha_div) * P_c * R_c));

    mass_scaled = (mass_UDMH_tank + mass_N2O4_tank + mass_chamber + mass_injector + mass_nozzle) / mass_dry_ref;

end