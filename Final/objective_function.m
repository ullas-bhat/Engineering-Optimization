function mass_scaled = objective_function(x)
    
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