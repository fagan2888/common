
function [A,SIGMA,U,C]=myvarc(y,p,d);
% VAR in companion matrix form
% p lags
% order of deterministic terms is d

[T,N]=size(y);
y=y';
Y=y(:,p:T);
for i=1:p-1
 	Y=[Y; y(:,p-i:T-i)];
end;

trends=ones(1,T-p);
if d==1;
trends=[trends; (p+1:1:T)];
end;

X=[trends; Y(:,1:T-p)];
Y=Y(:,2:T-p+1);

A=(Y*X')/(X*X');
U=Y-A*X;
SIGMA=U*U'/(T-p-p*N-1);
C=A(:,1:d+1);
A=A(:,d+2:N*p+d+1);



