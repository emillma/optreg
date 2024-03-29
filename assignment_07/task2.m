k1 = 1;
k2 = 1;
k3 = 1;
T = 0.1;

A_c = [0 1
    -k1 -k2];
B_c = [0 k3]';
C_c = [0 1];

A_d = eye(2) + A_c * T;
B_d = B_c * T;
C = [1 0];

Q = diag([4 4]);
R = 1;
[K, P, e] = dlqr(A_d, B_d, Q / 2, R / 2, []);

A_cl = A_d - B_d * K;
A_cl_eigvals = eig(A_cl);

p_obs_d = 0.5 + 0.03j * [1; -1];
KF = place(A_d', C', p_obs_d).';

Phi = [A_d - B_d * K B_d * K; zeros(2, 2) A_d - KF * C];
Phi_eigvals = eig(Phi);

tf = 50;
x0 = [5, 1]';
x0_hat = [6, 0]';

x = zeros(2, tf + 1);
x(:, 1) = x0;

x_hat = zeros(2, tf + 1);
kx_hat(:, 1) = x0_hat;

y = zeros(1, tf + 1);
u = zeros(1, tf + 1);

for t = 1:tf
    u(:, t) = -K * x_hat(:, t);
    x(:, t + 1) = A_d * x(:, t) + B * u(:, t);
    y(:, t) = C * x(:, t);
    x_hat(:, t + 1) = A_d * x_hat(:, t) + B * u(:, t) + KF * (y(:, t) - C * x_hat(:, t));
end

t_arr = 0:tf;
figure(1);

subplot(2, 1, 1);
plot(t_arr, x);
hold on;
plot(t_arr, x_hat); hold off;
legend('x_0', 'x_1', 'x\_hat_0', 'x\_hat_1');
grid('on');
subplot(2, 1, 2);
plot(t_arr, u);
grid('on');
xlabel('time');
ylabel('u');
