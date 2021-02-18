a = linspace(0,8, 100);
b = linspace(0,8, 100);
zero = linspace(0,0, 100);
[A,B] = meshgrid(a,b);
F = -3*A -2*B;

hold on;
contour(A,B,F)
plot(a, zero, 'k');
plot(zero, b, 'k');
plot(a, 8-2*a, 'k');
plot(15-3*b, b, 'k');
xlim([0 8]);
ylim([0 8]);