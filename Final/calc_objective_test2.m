 function total_mass = calc_objective_test2(x_scaled)
    % Function to calculate the value of the objective function at design
    % point x

    % Importing motor constants
    constants;
    [g0,h0]=calc_constraints(x_scaled)
    x = descale(x_scaled, x_ref);
    lb=[0.1,0.1,0.1]
    ub=[10,10,10]
    P_c = x(1);
    A_t = x(2);
    A_e = x(3);
    
    %% Propellant tank calculations
    V_UDMH = m_UDMH / rho_UDMH;
    V_N2O4 = m_N2O4 / rho_N2O4;
   

    L_UDMH_tank = (1.1*V_UDMH - 4*pi*R_tank^3/3) / (pi * R_tank^2);
    L_N2O4_tank = (1.1*V_N2O4 - 4*pi*R_tank^3/3) / (pi * R_tank^2);

    t_cyl = (P_c + 10E+05) * R_tank * 1.5/ sigma_tank;
    t_sph = t_cyl / 2;

    mass_UDMH_tank = 1.2 * (2*t_cyl*pi*R_tank*L_UDMH_tank + 4*t_sph*R_tank^2) * rho_tank;
    mass_N2O4_tank = 1.2 * (2*t_cyl*pi*R_tank*L_N2O4_tank + 4*t_sph*R_tank^2) * rho_tank;

    
%%  % IRT calculations
    mass_flow = Gamma * P_c * A_t / sqrt(R * T_c);  % mass flow through the nozzle (kg/s)
    A_c = (mass_flow * R * T_c)/(0.3 * P_c * sqrt(gamma_val*R*T_c));    % area of the chamber (m2)
    R_c = sqrt(A_c / pi);   % chamber radius (m)
    Kloads= 1;%correction for high chamber pressures
    V_c = pi * R_c^2 * L_c; % chamber volume (m3)
    chamber_mass = Kloads * (2/(L_c/R_c) + 2) * rho_val/sigma_val * f * P_c * V_c;   % chamber mass using thin shell theory (kg)
    injector_mass = rho_val/sigma_val * f * (1.2 * A_c * R_c * sqrt(P_c*sigma_val));  % injector plate mass using thin shell theory (kg)
    
%     nozzle_convergent_mass = (rho/sigma) * f * (A_t * (((A_c/A_t)-1)/sind(beta)) * (P_c*R_c));  % convergent nozzle mass using thin shell theory (kg)
    nozzle_divergent_mass = (rho_val/sigma_val) * f * (A_t * (((A_e/A_t)-1)/sind(alpha_val)) * (P_c*R_c));  % divergent nozzle mass using thin shell theory (kg)

%     total_mass = chamber_mass + injector_mass + nozzle_convergent_mass + nozzle_divergent_mass; % total mass of the motor (kg)
    total_mass = chamber_mass + injector_mass + nozzle_divergent_mass + mass_UDMH_tank + mass_N2O4_tank; % total mass of the motor (kg)

    total_mass=total_mass+15000000*(max(0,g0)^2)+10000000*(h0)^2+ 10000000*(max(0,0.1-lb(1))^2)  + 10000000*(max(0,0.1-lb(2))^2) + 10000000*(max(0,0.1-lb(3))^2) + 10000000*(max(0,ub(1)-10)^2) + 10000000*(max(0,ub(2)-10)^2) + 10000000*(max(0,ub(3)-10)^2) 
end