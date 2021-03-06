import sympy as sp
from sympy.physics.mechanics import dynamicsymbols

rs = lambda name: sp.symbols(name, real=True)

drs = lambda name: dynamicsymbols(name, real=True)

t = sp.symbols('t')

l_a = rs('l_a')  # Distance from elevation axis to helicopter body 0.63 m
l_h = rs('l_h')  # Distance from pitch axis to motor 0.18 m
K_f = rs('K_f')  # Force constant motor 0.25 N/V
J_e = rs('J_e')  # Moment of inertia for elevation 0.83 kg m2
J_t = rs('J_t')  # Moment of inertia for travel 0.83 kg m2
J_p = rs('J_p')  # Moment of inertia for pitch 0.034 kg m2
m_h = rs('m_h')  # Mass of helicopter 1.05 kg
m_w = rs('m_w')  # Balance weight 1.87 kg
m_g = rs('m_g')  # Effective mass of the helicopter 0.05 kg
K_p = rs('K_p')  # Force to lift the helicopter from the ground 0.49 N

const_dict = dict(l_a=0.63, l_h=0.18, K_f=0.25, J_e=0.83, J_t=0.83, J_p=0.034, m_h=1.05, m_w=1.87, m_g=0.05, K_p=0.49)




p = drs('p')  # Pitch
p_c = drs('p_c')  # Setpoint for pitch
lamb = drs('lamb')  # Travel
r = drs('r')  # Speed of travel
r_c = drs('r_c')  # Setpoint for speed of travel
e = drs('e')  # Elevation
e_c = drs('e_c')  # Setpoint for elevation
V_f = drs('V_f')  # Voltage, motor in front
V_b = drs('V_b')  # Voltage, motor in back
V_d = drs('V_d')  # Voltage difference, Vf − Vb
V_s = drs('V_s')  # Voltage sum, Vf + Vb
K_p_p, K_p_d, K_e_p, K_e_i, K_e_d = drs('K_p_p, K_p_d, K_e_p, K_e_i, K_e_d')  # Controller gains
T_g = drs('T_g')  # Moment needed to keep the helicopter flying