function irf=A2psi(Phi,n,p,N,G);
% compute N horizon impulse response for a n variable VAR with p lags
% input the p-dimensional cell array Phi, where
% y(t)=Phi(1) y(t-1)+ .. Phi(p) y(t-p)+e(t)
% eg, y1t = .2 y1(t-1) + .4 y2(t-1) + .4 y1(t-2) + .2y2(t-2) + e1t
%     y2t = .6 y1(t-1) + .4 y2(t-1) + .1 y1(t-2) + .1y2(t-2) + e2t
%  Phi{1}=[.2 .4; .6 .4]; Phi{2}=[.4 .2; .1 .1];




A=cell(N);
for i=1:p;
  A{i}= Phi{i};
end;  

for i=p+1:N;
  A{i}=zeros(n,n);
end;  

psi=cell(N);
psi{1}=eye(n);
for i=1:N;
  psi{i}=A{i};
  for j=1:i-1;
  psi{i}=psi{i}+A{j}*psi{i-j};
  end;
end;  

if rank(G)==n;
P=chol(inv(G));
for i=1:N;
  psi{i}=psi{i}*P;
end;  
end;

irf0=cell2mat(psi);


irf=irf0;
irf=zeros(N,n*n);
for i=1:N;
irf(i,:)=vec(irf0((i-1)*n+1:n*i,1:n))'; 
end;

%irf1=vec(irf0');
%irf=reshape( irf1,n*n,N)';

    

