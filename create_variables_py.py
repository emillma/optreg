import sympy as sp
from sympy import symbols as sbs
import re

with open('variables.txt', 'r') as file:
    text = file.read()

constants = re.search(
    r"(?<=constants\n)[\s\S]*?(?=\n{3,})",
    text
)[0]

variables = re.search(
    r"(?<=variables\n)[\s\S]*?(?=\n{3,}|$)",
    text
)[0]

out = 'import sympy as sp\n\n\n'

constant_out = re.sub(
    r"^(?P<var>.*?) (?P<desc>[^0-9\n\r]*(?P<val>[0-9]+\.[0-9]*)?.*)$",
    r"\g<var> = sp.symbols('\g<var>')  # \g<desc>",
    constants,
    flags=re.MULTILINE)

out += constant_out + '\n\n'

matches = re.finditer(
    r"^(?P<var>.*?) [^0-9]*(?P<val>[0-9]+\.[0-9]*)",
    constants,
    flags=re.MULTILINE
)
conts_dict_string = 'const_dict = dict('
conts_dict_string += ', '.join([f'{m[1]}={m[2]}' for m in matches])
conts_dict_string += ')\n\n'

out += conts_dict_string + '\n\n\n'

vars_out = re.sub(
    r"^(?P<var>.*?(?:, .*?)*) (?P<desc>.*)$",
    r"\g<var> = sp.symbols('\g<var>')  # \g<desc>",
    variables,
    flags=re.MULTILINE)

out += vars_out
print(out)
with open('variables.py', 'w') as file:
    file.write(out)
#
