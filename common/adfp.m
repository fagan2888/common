function [adf,kstar]=adfp(y,penalty,kmax,kmin,p);
yt=olsd(y,p);
reg=lagn(yt,1);
dyt=mydiff(yt,1);
kstar=s2ar(yt,penalty,kmax,kmin);
for i=1:kstar;
reg=[reg lagn(dyt,i)];
end;
dyt=trimr(dyt,kstar+1,0);
reg=trimr(reg,kstar+1,0);
rho=myols(dyt,reg);
e=dyt-reg*rho;
nef=size(dyt,1);
s2e=e'*e/nef;
xx=inv(reg'*reg);
sre=xx(1,1)*s2e;
adf=rho(1,1)/sqrt(sre);
rho1=rho(1,1)+1;
if kstar> 0;
sumb=sum(rho(2:kstar+1));
else;
sumb=0;
end;
s2vec=s2e/(1-sumb)^2;




