k1 = 1;
k2 = 1;
k3 = 1;
T = 0.1;

A_c = [0 1
    -k1 -k2];
B_c = [0 k3]';
C_c = [0 1];

A_d = eye(2) + A_c * T;
B = B_c * T;
C = [1 0];

Q = diag([4 4]);
R = 1;
[K, P, e] = dlqr(A_d, B, Q / 2, R / 2, []);

A_cl = A_d - B * K;
p_sys_dlqr = eig(A_cl)
