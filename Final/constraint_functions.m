function [g_con, h_con] = constraint_functions(x)
    
    g = 1.2096;
R = 418;
T_c = 2964;
G = sqrt(g) * (2/(g+1))^((g+1)/(2*g-2));
P_a = 0.211E+05;
accel_g = 9.81;

rho_cn = 8980;
sigma_cn = 748E+06;

L_c = 1.3;

alpha_div = deg2rad(11.7);

f = 1.5;

P_c_ref = 58E+05;
A_t_ref = 0.1886;
A_e_ref = 0.7698;
x_ref = [P_c_ref A_t_ref A_e_ref]';

mass_flow_ref = G * P_c_ref * A_t_ref / sqrt(R * T_c);

rho_N2O4 = 1.44246E+03;
rho_UDMH = 791;

mass_N2O4 = 105462.963;
mass_UDMH = 62037.03704;

R_tank = 1.9;    
rho_tank = 2810;  
sigma_tank = 275E+06;   

V_UDMH = mass_UDMH / rho_UDMH; 
V_N2O4 = mass_N2O4 / rho_N2O4;

L_UDMH_tank = (1.1*V_UDMH - 4*pi*R_tank^3/3) / (pi*R_tank^2);
L_N2O4_tank = (1.1*V_N2O4 - 4*pi*R_tank^3/3) / (pi*R_tank^2);

mass_dry_ref = 31168.0910728278;
thrust_ref = 1.7426E+06; 
Isp_ref = 277.9207;

thrust_factor_ref = thrust_ref / ((mass_dry_ref + mass_N2O4 + mass_UDMH) * accel_g);


    
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
    
    g_con = zeros(1, 1);
    h_con = zeros(2, 1);

    g_con(1) = 1 - Isp/Isp_ref;
    h_con(1) = 1 - thrust_factor/thrust_factor_ref;
    h_con(2) = 1 - mass_flow/mass_flow_ref; 

end