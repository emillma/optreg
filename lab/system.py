from variables import (
    l_a, l_h, K_f, J_e, J_t, J_p, m_h, m_w, m_g, K_p,
    p, p_c, lamb, r, r_c, e, e_c, V_f, V_b, V_d, V_s, K_p_p, T_g,
    t
)
import sympy as sp
from sympy.physics.vector.printing import vpprint, vlatex


def rewrite(eq, var):
    return sp.Eq(var, sp.solve(eq, var), evaluate=False)


handout = dict()
handout['2a'] = sp.Eq(J_e*e.diff(t, 2), l_a*K_f*V_s-T_g, evaluate=False)
handout['2b'] = sp.solve(handout['2a'], e.diff(t, 2))[0]
