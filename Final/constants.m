% Script containing all the required constants:

g = 1.2096; % specific heat ratio
R = 418;    % gas constant [J/kg/K]
T_c = 2964; % chamber temperature [K]
G = sqrt(g) * (2/(g+1))^((g+1)/(2*g-2));    % Vandenkerckhove parameter
P_a = 0.211E+05;    % ambient pressure [Pa]
accel_g = 9.81;     % acceleration due to gravity [m/s^2]

rho_cn = 8980;    % density of the chamber and nozzle material [kg/m^3]
sigma_cn = 748E+06;   % yield strength of the chamber and nozzle material [Pa]

L_c = 1.3;  % length of the chamber [m]

alpha_div = deg2rad(11.7);  % divergence angle [rad]

f = 1.5;    % safety factor

P_c_ref = 58E+05;   % reference chamber pressure [Pa]
A_t_ref = 0.1886;   % reference throat area [m^2]
A_e_ref = 0.7698;   % reference exit area [m^2]
x_ref = [P_c_ref A_t_ref A_e_ref]';  % reference design variable

mass_flow_ref = G * P_c_ref * A_t_ref / sqrt(R * T_c);  % reference mass flow rate [kg/s]

rho_N2O4 = 1.44246E+03; % density of N2O4 [kg/m^3]
rho_UDMH = 791; % density of UDMH [kg/m^3]

mass_N2O4 = 105462.963; % mass of N2O4 [kg]
mass_UDMH = 62037.03704;    % mass of UDMH [kg]

R_tank = 1.9;   % tank radius [m]    
rho_tank = 2810;    % tank material density [kg/m^3]
sigma_tank = 275E+06;   % tank material yield strength [Pa]   

V_UDMH = mass_UDMH / rho_UDMH;  % volume of UDMH [m^3] 
V_N2O4 = mass_N2O4 / rho_N2O4;  % volume of N2O4 [m^3]

L_UDMH_tank = (1.1*V_UDMH - 4*pi*R_tank^3/3) / (pi*R_tank^2);   % length of UDMH tank [m]
L_N2O4_tank = (1.1*V_N2O4 - 4*pi*R_tank^3/3) / (pi*R_tank^2);   % length of N2O4 tank [m]

mass_dry_ref = 31168.0910728278;    % reference dry mass [kg]
thrust_ref = 1.7426E+06;    % reference thrust [N]
Isp_ref = 277.9207; % reference specific impulse [s]

thrust_factor_ref = thrust_ref / ((mass_dry_ref + mass_N2O4 + mass_UDMH) * accel_g);    % reference thrust factor



