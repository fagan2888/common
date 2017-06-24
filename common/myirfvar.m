% evaluates h steps irf for a N variable VAR of order p


function [IRF]=myirfvar(A,SIGMA,p,N,h);



J=[eye(N,N) zeros(N,N*(p-1))];
IRF=reshape(J*A^0*J'*chol(SIGMA)',N^2,1);

for i=1:h
	IRF=([IRF reshape(J*A^i*J'*chol(SIGMA)',N^2,1)]);
end;

