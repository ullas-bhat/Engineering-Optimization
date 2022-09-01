% Script containing all the required constants:
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



