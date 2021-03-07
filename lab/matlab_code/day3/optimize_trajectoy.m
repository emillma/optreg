
N = 100;
q = 1;
p_lim = 30*(pi/180);

m_states = 4;
gain_states = 1;
opt_states = (m_states + gain_states)*N;
gopt = m_states * (N) +1; %index of fisrt gain state
x_init = zeros(opt_states, 1);

lambda_init = pi;
lamda_fin = 0;

init_con_A = zeros(m_states, opt_states);
init_con_A(:, 1:m_states) = eye(m_states);
init_con_B = [lambda_init 0 0 0]';

fin_con_A = zeros(m_states, opt_states);
fin_con_A(:, gopt-m_states:gopt-1) = eye(m_states);
fin_con_B = [lamda_fin 0 0 0]';

col_con_A = zeros(m_states*(N-1), opt_states);
col_con_A(1:m_states*(N-1), m_states+1:m_states*N) = -eye(m_states*(N-1));
for i = 0:N-2
    col_con_A(1+m_states*i:m_states*(i+1), 1+m_states*i:m_states*(i+1)) = A_d;
    col_con_A(1+m_states*i:m_states*(i+1), gopt+i) = B_d;
end
col_con_B = zeros(m_states*(N-1), 1);

con_A_eq = [init_con_A; fin_con_A; col_con_A];
con_B_eq = [init_con_B; fin_con_B; col_con_B];

G = zeros(opt_states, opt_states);
c = zeros(opt_states, 1);
for i = 0:N-2
    G(1+m_states*(i+1), 1+m_states*(i+1)) = 2;
    c(1+m_states*(i+1)) = -2*lamda_fin;
end
G(gopt:gopt+gain_states*N-1, gopt:gopt+gain_states*N-1) = 2*q*eye(gain_states*N);

con_A_ineq = zeros(2*N, opt_states);
con_B_ineq = p_lim*ones(2*N, 1);

for i = 0:N-1
    con_A_ineq(i+1, 3+m_states*i) = 1;
    con_A_ineq(N+i+1, 3+m_states*i) = -1;

end


opt_traj = quadprog(G, c, con_A_ineq, con_B_ineq, con_A_eq, con_B_eq);

lambda = opt_traj(1:m_states:end-N*gain_states);
r = opt_traj(2:m_states:end-N*gain_states);
p = opt_traj(3:m_states:end-N*gain_states);
p_dot = opt_traj(4:m_states:end-N*gain_states);

x_star = [lambda r p p_dot];
u_star = opt_traj(gopt:end);

u_star = [zeros(5/0.25,1);u_star;zeros(5/0.25,1)];
u_star = [0.25*(0:length(u_star)-1)' u_star];

x_pad_start = [lambda_init*ones(5/0.25, 1) zeros(5/0.25, 3)];
x_star = [x_pad_start;x_star;zeros(5/0.25,4)];
x_star = [0.25*(0:length(x_star)-1)' x_star];

p_dot = [zeros(5/0.25,1);p_dot;zeros(5/0.25,1)];
p_dot = [0.25*(0:length(p_dot)-1)' p_dot];

p = [zeros(5/0.25,1);p;zeros(5/0.25,1)];
p = [0.25*(0:length(p)-1)' p];

clf;
hold on;
plot(p(:, 1), p(:, 2));
plot(u_star(:, 1), u_star(:, 2));

