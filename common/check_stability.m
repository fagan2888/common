function ev=check_stability(A,n,p);
bigA=[A; eye(n*(p-1)) zeros(n*(p-1),n)];
ev=max(abs(eig(bigA)));
