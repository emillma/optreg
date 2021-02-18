%%CodeformakingacontourplotforProblem 2.
x1_l = -1.5; x1_h = 6.5;
x2_l = -1.5; x2_h = 6.5;
res = 0.01;
[x1, x2] = meshgrid(x1_l:res:x2_h, x1_l:res:x2_h);
f = -(3 - 0.4 * x1) .* x1 -(2 - 0.2 * x2) .* x2;
levels = (-12:2:8)';
[C, h] = contour(x1, x2, f, levels, 'Color', .7 * [1 1 1]);
set(h, 'ShowText', 'on', 'LabelSpacing', 300); %Fortextlabels
%%Changesmadetothefileqp_prodplan.m
%Quadraticobjective(MODIFYTHESE)
G = [0.8 0;
    0 0.4]; %Rememberthefactor 1/2 intheobjective
c = [-3; -2];
%Linearconstraints(MODIFYTHESE)
A = [2 1;
    1 3];
b = [8; 15];
