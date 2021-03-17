%% Assignment 5, Problem 2 b)
%  MPC with quadprog. Perfect model.
%  Tor Aksel N. Heirung, April 2013.

%% Problem data
% System matrices, model
A = [0 0 0;
    0 0 1;
    0.1 -0.79 1.78];
B = [1 0 0.1]';
C = [0 0 1];

x0 = [0 0 1]'; % Initial state

N = 30;
block_len = [1, 1, 2, 4, 8, 14]';
n_blocks = numel(block_len);

state_len = size(A, 2);
gain_len = size(B, 2);

Qt = 2 * diag([0, 0, 1]);
Q = kron(eye(N), Qt);
Rt = 2 * 1;
R = kron(diag(block_len), Rt);
G = blkdiag(Q, R);

Aeq_c1 = eye(N * state_len);
Aeq_c2 = kron(diag(ones(N - 1, 1), -1), -A);
one_block = blkdiag(ones(block_len(1), 1), ...
    ones(block_len(2), 1), ...
    ones(block_len(3), 1), ...
    ones(block_len(4), 1), ...
    ones(block_len(5), 1), ...
    ones(block_len(6), 1));
Aeq_c3 = kron(one_block, -B);
Aeq = [Aeq_c1 + Aeq_c2, Aeq_c3];

beq = [A * x0; zeros((N - 1) * state_len, 1)];

x_lb = -Inf(N * state_len, 1);
x_ub = Inf(N * state_len, 1);
u_lb = -ones(n_blocks * gain_len, 1);
u_ub = ones(n_blocks * gain_len, 1);
lb = [x_lb; u_lb];
ub = [x_ub; u_ub];

[z, fval, exitflag, output, lambda] = quadprog(G, [], [], [], Aeq, beq, lb, ub);

y = [x0(3); z(state_len:state_len:N * state_len)];
u_blocks = z(N * state_len + 1:N * state_len + n_blocks * gain_len);
u = one_block * u_blocks;

t = 1:N;

figure(5);
subplot(2, 1, 1);
plot([0, t], y, '-ko');
grid('on');
ylabel('y_t');
subplot(2, 1, 2);
hold('on');
stairs(t - 1, u, 'k');
plot(t - 1, u, 'ko');
hold('off');
box('on');
grid('on');
xlabel('t');
ylabel('u_t');
