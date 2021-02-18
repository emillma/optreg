
N = 100;
q = 0.1;
p_lim = 30*(pi/180);

m_states = 4;
gain_states = 1;
opt_states = (m_states + gain_states)*N;
gopt = m_states * (N) +1;
x_init = zeros(opt_states, 1);

lambda_init = 0;
lamda_fin = pi;

init_con_A = zeros(4, opt_states);
init_con_A(1:m_states, 1:m_states) = eye(4);
init_con_B = [lambda_init 0 0 0]';

fin_con_A = zeros(4, opt_states);
fin_con_A(:, gopt-m_states:gopt-1) = eye(4);
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
lambdas = opt_traj(1:m_states:end-N*gain_states);
r = opt_traj(2:m_states:end-N*gain_states);
p = opt_traj(3:m_states:end-N*gain_states);
p_dot = opt_traj(4:m_states:end-N*gain_states);
u = opt_traj(gopt:end);

plot(p)
