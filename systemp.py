import sympy as sp
from sympy import symbols as sbs

l_a, l_h = sbs('l_a, l_h')  # dist elev axis to heli,
K_f = sbs('K_f')
J_e, J_t, J_p = sbs('J_e, J_t, J_p')
m_n, m_w, m_g = sbs('m_n, m_w, m_g')


lamb = sbs('lambda')

# la Distance from elevation axis to helicopter body 0.63 m
# lh Distance from pitch axis to motor 0.18 m
# Kf Force constant motor 0.25 N/V
# Je Moment of inertia for elevation 0.83 kg m2
# Jt Moment of inertia for travel 0.83 kg m2
# Jp Moment of inertia for pitch 0.034 kg m2
# mh Mass of helicopter 1.05 kg
# mw Balance weight 1.87 kg
# mg Effective mass of the helicopter 0.05 kg
# Kp Force to lift the helicopter from the ground 0.49 N
# Table 2: Variables.
# Symbol Variable
# p Pitch
# pc Setpoint for pitch
# λ Travel
# r Speed of travel
# rc Setpoint for speed of travel
# e Elevation
# ec Setpoint for elevation
# Vf Voltage, motor in front
# Vb Voltage, motor in back
# Vd Voltage difference, Vf − Vb
# Vs Voltage sum, Vf + Vb
# Kpp, Kpd, Kep, Kei, Ked Controller gains
# Tg Moment needed to keep the helicopter flying
