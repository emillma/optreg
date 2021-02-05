from variables import *
import sympy as sp
from sympy.physics.vector.printing import vpprint, vlatex


def rewrite(eq, var):
    return sp.Eq(var, sp.solve(eq, var), evaluate=False)


handout = dict()
handout['2a'] = sp.Eq(J_e*e.diff(t, 2), l_a*K_f*V_s-T_g, evaluate=False)
handout['2b'] = sp.solve(handout['2a'], e.diff(t, 2))
