k1 = 1;
k2 = 1;
k3 = 1;
T = 0.1;

A_c = [0 1
    -k1 -k2];
B_c = [0 k3]';

A_d = eye(2) + A_c * T;
B_d = B_c * T;
C = [1 0];

N = 10;
n_x = size(A_d, 2);
n_u = size(B_d, 2);

identity_N = eye(N);
Qt = diag([4 4]);
Q = kron(identity_N, Qt);
Rt = 1;
R = kron(identity_N, Rt);
G = blkdiag(Q, R);

x_lowbound = -Inf(N * n_x, 1);
x_upbound = Inf(N * n_x, 1);
u_lowbound = -4 * ones(N * n_u, 1);
u_upbound = 4 * ones(N * n_u, 1);
lowbound = [x_lowbound; u_lowbound];
upbound = [x_upbound; u_upbound];

Aeq_c1 = eye(N * n_x);
Aeq_c2 = kron(diag(ones(N - 1, 1), -1), -A_d);
Aeq_c3 = kron(identity_N, -B_d);
Aeq = [Aeq_c1 + Aeq_c2, Aeq_c3];

p_obs_d = 0.5 + 0.03j * [1; -1];
KF = place(A_d', C', p_obs_d).';

tf = 50;
x = NaN(2, tf + 1);
u = NaN(1, tf + 1);
y = NaN(1, tf + 1);
x_hat = NaN(2, tf + 1);

x0 = [5, 1]';
x0_hat = [6, 0]';

x(:, 1) = x0;
x_hat(:, 1) = x0_hat;

beq = [zeros(n_x, 1); zeros((N - 1) * n_x, 1)];

for t = 1:tf

    beq(1:n_x) = A_d * x_hat(:, t);
    opt_traj = quadprog(G, [], [], [], Aeq, beq, lowbound, upbound);

    u_opt = opt_traj(N * n_x + 1:N * n_x + N * n_u);
    u(t) = u_opt(1);

    x(:, t + 1) = A_d * x(:, t) + B_d * u(t);

    y(:, t) = C * x(:, t);

    x_hat(:, t + 1) = A_d * x_hat(:, t) + B_d * u(:, t) + KF * (y(:, t) - C * x_hat(:, t));
end

t_arr = 0:tf;

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
