% computes autocovariace of an ARMA model
function [psi,acf]=arma_acf(phi,theta,sigma,nlags);


M=100;
shock=zeros(M,1);
shock(1)=sigma;
psi=filter([1 theta],[1 -phi],shock);

gam=zeros(nlags,1);

for k=0:nlags;
  gam(k+1)= 0;
  for j=0:M-k-1;
     gam(k+1)=gam(k+1)+psi(j+1)*psi(j+k+1);
  end;
end;  
%gam0= sum(psi.*psi);
%acf=[gam0;gam];
%acf=gam*sigma^2;
acf=gam;


