function x=detrend(X);

[T,N]=size(X);
Q=[ones(T,1) (1:1:T)'];
P=Q*inv(Q'*Q)*Q';
x=X-P*X;
