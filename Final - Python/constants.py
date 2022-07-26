import numpy as np

gamma = 1.2096
R = 418
T_c = 2964
P_a = 0.211E+05
g0 = 9.81
Gamma = np.sqrt(gamma) * (2/(gamma + 1))**((gamma + 1)/(2*gamma - 2))

rho = 8980
sigma = 748E+06

L_c = 1.3

alpha = np.radians(11.7)

f = 1.5

P_c_ref = 58E+05
A_t_ref = 0.1886
A_e_ref = 0.7698
x_ref = np.array([[P_c_ref, A_t_ref, A_e_ref]]).transpose()

mass_flow_ref = Gamma * P_c_ref * A_t_ref / np.sqrt(R * T_c)

rho_N2O4 = 1.44246E+03
rho_UDMH = 791

m_N2O4 = 105462.963
m_UDMH = 62037.03704

R_tank = 1.9
rho_tank = 2810
sigma_tank = 275E+06

V_UDMH = m_UDMH / rho_UDMH
V_N2O4 = m_N2O4 / rho_N2O4

L_UDMH_tank = (1.1*V_UDMH - 4*np.pi*R_tank**3 / 3) / (np.pi * R_tank**2)
L_N2O4_tank = (1.1*V_N2O4 - 4*np.pi*R_tank**3 / 3) / (np.pi * R_tank**2)

mass_dry_ref = 31168.0910728278
