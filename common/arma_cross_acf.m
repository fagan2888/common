% computes cross-autocovariace E(y(t),x(t-k))
% phi and theta have two rows, first row has coefficients of the first series
function acf=arma_cross_acf(psi,sigma,nlags);

M=rows(psi);
gam=zeros(nlags,1);


for k=1:nlags;
  gam(k)= 0;
  for j=0:M-k-1;
     gam(k)=gam(k)+psi(j+1,1)*psi(j+k+1,2);
  end;
end;  
gam0= sum(psi(:,1).*psi(:,2));
acf=[gam0;gam];
acf=acf*sigma(1)*sigma(2);


