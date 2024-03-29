
N = 40;
q = 1;
p_lim = 30*(pi/180);

m_states = size(A_d, 2);
gain_states = size(B_d, 2);
opt_states = m_states*N + gain_states * (N-1);
gopt = m_states * (N) +1; %index of fisrt gain state
x_init = zeros(opt_states, 1);

lambda_init = pi;
lamda_fin = 0;
x_init(1) = lambda_init;

init_con_A = zeros(4, opt_states);
init_con_A(1:4, 1:4) = eye(4);
init_con_B = [lambda_init 0 0 0]';

fin_con_A = zeros(4, opt_states);
fin_con_A(:, gopt-6:gopt-3) = eye(4);
fin_con_B = [lamda_fin 0 0 0]';

col_con_A = zeros(m_states*(N-1), opt_states);
col_con_A(1:m_states*(N-1), m_states+1:m_states*N) = -eye(m_states*(N-1));
for i = 0:N-2
    col_con_A(1+m_states*i:m_states*(i+1), 1+m_states*i:m_states*(i+1)) = A_d;
    col_con_A(1+m_states*i:m_states*(i+1), gopt+gain_states*i:gopt+gain_states*(i+1)-1) = B_d;
end
col_con_B = zeros(m_states*(N-1), 1);

con_A_eq = [init_con_A; fin_con_A; col_con_A];
con_B_eq = [init_con_B; fin_con_B; col_con_B];

G = zeros(opt_states, opt_states);
c = zeros(opt_states, 1);
for i = 0:N-2
    G(1+m_states*(i+1), 1+m_states*(i+1)) = 2;
    G(5+m_states*(i+1), 5+m_states*(i+1)) = 2;

    c(1+m_states*(i+1)) = -2*lamda_fin;
end
G(gopt:gopt+gain_states*(N-1)-1, gopt:gopt+gain_states*(N-1)-1) = 2*q*eye(gain_states*(N-1));

con_A_ineq = zeros(2*N, opt_states);
con_B_ineq = p_lim*ones(2*N, 1);

for i = 0:N-1
    con_A_ineq(i+1, 3+m_states*i) = 1;
    con_A_ineq(N+i+1, 3+m_states*i) = -1;

end

objective_function = @(state)(0.5*state.'*G*state + c.'*state);
nonlineq = @(x)conditions(x);
% opt_traj = quadprog(G, c, con_A_ineq, con_B_ineq, con_A_eq, con_B_eq);

opt = optimoptions("fmincon", "MaxFunctionEvaluations", 1e4, "Algorithm", "sqp");
opt_traj = fmincon(objective_function, x_init, con_A_ineq, con_B_ineq, con_A_eq, con_B_eq, [], [],nonlineq, opt);

lambda = opt_traj(1:m_states:gopt-1);
r = opt_traj(2:m_states:gopt-1);
p = opt_traj(3:m_states:gopt-1);
p_dot = opt_traj(4:m_states:gopt-1);
e = opt_traj(5:m_states:gopt-1);
e_dot = opt_traj(6:m_states:gopt-1);

u_p = opt_traj(gopt:2:end);
u_e = opt_traj(gopt+1:2:end);

time = 0.25*(0:length(lambda)-1)';
clf;
subplot(421)
plot(time, lambda);
subplot(422)
plot(time, r);
subplot(423)
plot(time, p);
subplot(424)
plot(time, p_dot);
subplot(425)
plot(time, e);
subplot(426)
plot(time, e_dot);
subplot(427)
plot(time(1:end-1), u_p);
subplot(428)
plot(time(1:end-1), u_e);


x_star = [lambda r p p_dot e, e_dot];
u_star = [u_p u_e];

u_star = [zeros(5/0.25,gain_states);u_star;zeros(5/0.25,gain_states)];
u_star = [0.25*(0:length(u_star)-1)' u_star];

x_pad_start = [lambda_init*ones(5/0.25, 1) zeros(5/0.25,5)];
x_star = [x_pad_start;x_star;zeros(5/0.25,m_states)];
x_star = [0.25*(0:length(x_star)-1)' x_star];

p_dot = [zeros(5/0.25,1);p_dot;zeros(5/0.25,1)];
p_dot = [0.25*(0:length(p_dot)-1)' p_dot];

p = [zeros(5/0.25,1);p;zeros(5/0.25,1)];
p = [0.25*(0:length(p)-1)' p];






