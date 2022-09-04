function [g_con, h_con] = constraint_functions(x)
    % Function to evaluate the constraints
    % x: design variables
    % g_con: inequality constraints
    % h_con: equality constraints

    % Required constants:
    g = 1.2096; % specific heat ratio
    R = 418;    % gas constant [J/kg/K]
    T_c = 2964; % chamber temperature [K]
    G = sqrt(g) * (2/(g+1))^((g+1)/(2*g-2));    % Vandenkerckhove parameter
    P_a = 0.211E+05;    % ambient pressure [Pa]
    accel_g = 9.81;     % acceleration due to gravity [m/s^2]
    P_c_ref = 58E+05;   % reference chamber pressure [Pa]
    A_t_ref = 0.1886;   % reference throat area [m^2]
    A_e_ref = 0.7698;   % reference exit area [m^2]
    mass_flow_ref = G * P_c_ref * A_t_ref / sqrt(R * T_c);  % reference mass flow rate [kg/s]
    mass_N2O4 = 105462.963; % mass of N2O4 [kg]
    mass_UDMH = 62037.03704;    % mass of UDMH [kg]
    mass_dry_ref = 17515;    % reference dry mass [kg]
    thrust_ref = 1.7426E+06;    % reference thrust [N]
    Isp_ref = 277.9207; % reference specific impulse [s]
    thrust_factor_ref = thrust_ref / ((mass_dry_ref + mass_N2O4 + mass_UDMH) * accel_g);    % reference thrust factor
    

    x_descale = descale(x); % descale design variables

    % Design variables:
    P_c = x_descale(1);
    A_t = x_descale(2);
    A_e = x_descale(3);

    mass_flow = G * P_c * A_t / sqrt(R * T_c);  % mass flow rate [kg/s]

    % Temporary variables:
    j = 2 * g / (g - 1);
    k = 2 / g;
    l = (g - 1) / g;

    area_ratio = A_e / A_t; % area ratio [-]
    pressure_ratio = area_ratio_to_pressure_ratio(area_ratio);  % pressure ratio [-]
    P_e = P_c * pressure_ratio;   % exit pressure [Pa]

    u_e = sqrt(j * R * T_c * (1-pressure_ratio^l)); % exit velocity [m/s]
    thrust = mass_flow * u_e + (P_e - P_a)*A_e; % thrust [N]
    mass_wet = objective_function(x) * mass_dry_ref + mass_N2O4 + mass_UDMH;    % wet mass [kg]    
    thrust_factor = thrust / (mass_wet * accel_g);  % thrust factor [-]
    Isp = thrust / (mass_flow * accel_g);   % specific impulse [s]
    
    g_con = zeros(1, 1);    % inequality constraints
    h_con = zeros(2, 1);    % equality constraints

    g_con(1) = 1 - Isp/Isp_ref; % Isp constraint
    h_con(1) = 1 - thrust_factor/thrust_factor_ref; % thrust factor constraint
    h_con(2) = 1 - mass_flow/mass_flow_ref; % mass flow rate constraint 
end