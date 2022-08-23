import numpy as np

# Combustion properie
gamma = 1.2096  # specific heat ratio
R = 418  # gas constant [J/kgK]
T_c = 2964  # combustion temperature [K]
P_a = 0.211E+05  # ambient pressure [Pa]
g0 = 9.81   # acceleration due to gravity [m/s^2]
Gamma = np.sqrt(gamma) * (2/(gamma + 1))**((gamma + 1)/(2*gamma - 2))

# Nozzle material properties
rho = 8980  # density [kg/m^3]
sigma = 748E+06  # ultimate tensile strength [Pa]

L_c = 1.3   # combustion chamber length [m]

alpha = np.radians(11.7)  # nozzle divergence angle [rad]

f = 1.5  # safety factor

# Reference motor values
P_c_ref = 58E+05    # reference combustion pressure [Pa]
A_t_ref = 0.1886    # reference throat area [m^2]
A_e_ref = 0.7698    # reference exit area [m^2]
# reference motor design variable values [Pa, m^2, m^2]
x_ref = np.array([[P_c_ref, A_t_ref, A_e_ref]]).T

mass_flow_ref = Gamma * P_c_ref * A_t_ref / \
    np.sqrt(R * T_c)  # reference mass flow rate [kg/s]

# Fuel and oxidizer tank properties
rho_N2O4 = 1.44246E+03  # oxidizer density [kg/m^3]
rho_UDMH = 791       # fuel density [kg/m^3]

mass_N2O4 = 105462.963  # oxidizer mass [kg]
mass_UDMH = 62037.03704    # fuel mass [kg]

R_tank = 1.9    # tank radius [m]
rho_tank = 2810  # tank density [kg/m^3]
sigma_tank = 275E+06    # tank ultimate tensile strength [Pa]

V_UDMH = mass_UDMH / rho_UDMH  # fuel volume [m^3]
V_N2O4 = mass_N2O4 / rho_N2O4  # oxidizer volume [m^3]

L_UDMH_tank = (1.1*V_UDMH - 4*np.pi*R_tank**3 / 3) / \
    (np.pi * R_tank**2)    # fuel tank length [m]
L_N2O4_tank = (1.1*V_N2O4 - 4*np.pi*R_tank**3 / 3) / \
    (np.pi * R_tank**2)    # oxidizer tank length [m]

mass_dry_ref = 31168.0910728278  # reference dry mass [kg]
thrust_ref = 1.7426E+06  # reference thrust [N]
Isp_ref = 277.9207  # reference specific impulse [s]
thrust_factor_ref = thrust_ref / \
    ((mass_dry_ref + mass_N2O4 + mass_UDMH) * g0)  # reference thrust factor
