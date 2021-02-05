import sympy as sp


# Distance from elevation axis to helicopter body 0.63 m
l_a = sp.symbols('l_a')
l_h = sp.symbols('l_h')  # Distance from pitch axis to motor 0.18 m
K_f = sp.symbols('K_f')  # Force constant motor 0.25 N/V
J_e = sp.symbols('J_e')  # Moment of inertia for elevation 0.83 kg m2
J_t = sp.symbols('J_t')  # Moment of inertia for travel 0.83 kg m2
J_p = sp.symbols('J_p')  # Moment of inertia for pitch 0.034 kg m2
m_h = sp.symbols('m_h')  # Mass of helicopter 1.05 kg
m_w = sp.symbols('m_w')  # Balance weight 1.87 kg
m_g = sp.symbols('m_g')  # Effective mass of the helicopter 0.05 kg
K_p = sp.symbols('K_p')  # Force to lift the helicopter from the ground 0.49 N

const_dict = dict(l_a=0.63, l_h=0.18, K_f=0.25, J_e=0.83,
                  J_t=0.83, J_p=0.034, m_h=1.05, m_w=1.87, m_g=0.05, K_p=0.49)


p = sp.symbols('p')  # Pitch
p_c = sp.symbols('p_c')  # Setpoint for pitch
lamb = sp.symbols('lamb')  # Travel
r = sp.symbols('r')  # Speed of travel
r_c = sp.symbols('r_c')  # Setpoint for speed of travel
e = sp.symbols('e')  # Elevation
e_c = sp.symbols('e_c')  # Setpoint for elevation
V_f = sp.symbols('V_f')  # Voltage, motor in front
V_b = sp.symbols('V_b')  # Voltage, motor in back
V_d = sp.symbols('V_d')  # Voltage difference, Vf − Vb
V_s = sp.symbols('V_s')  # Voltage sum, Vf + Vb
K_p_p, K_p_d, K_e_p, K_e_i, K_e_d = sp.symbols(
    'K_p_p, K_p_d, K_e_p, K_e_i, K_e_d')  # Controller gains
T_g = sp.symbols('T_g')  # Moment needed to keep the helicopter flying
