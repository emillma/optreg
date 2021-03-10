A = [1  0.5;
     0  1  ];
B = [0.125;  0.5];

Q = diag([2 2]);
R = 2;

[K, P, e] = dlqr(A,B,Q/2,R/2);

I = eye(2);

eig(A-b*K);

abs(eig_cl)
