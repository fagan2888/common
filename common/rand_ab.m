
% generates a n1 by n2 matrix of uniform variates between a and b
function x=rand_ab(n1,n2,a,b);

y=rand(n1,n2);
x=a+(b-a).*y;
