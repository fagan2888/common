function [za,mza,msb,adf,krule,a1,ktild,pt,mpt,mzt] =mzgls(y,p,index,even)
%[za,mza,msb,adf,krule,a1,ktild,pt,mpt,mzt]= mzgls(y,p,index,even)
%do the MZGLS test in Ng-Perron (1997)

[nt,nc]=size(y);
if (p == 0)
 cbar1=-7.0;
 z=ones(nt,1);
end
if (p == 1)
 cbar1 = -13.5;
 trend=1:1:nt;
 z=[ones(nt,1); trend'];
end
if (index == 0)
 cbar2=cbar1;
else
 cbar2=0;
end

[yt,ssra]=glsd(y,z,cbar1);
[ahat,r]=olsqr(yt(2:nt,1),yt(1:nt-1,1));
s2u=r'*r/(nt-1);
sumyt2=sum(yt(1:nt-1,1).^2)/((nt-1)^2);
[sar,krule]=s2ar(y,z,p,cbar2,sumyt2,ahat,index,even);
bt=nt-1;
za=bt*(ahat-1)-(sar-s2u)/(2*sumyt2);
mza=(yt(nt,1)^2/bt-sar)/(2*sumyt2);
msb=sqrt(sumyt2/sar);
[ytf,ssr1]=glsd(y,z,0);
pt=(ssra-(1+cbar1/nt)*ssr1)/sar;
if (p==0)
 mpt=(cbar1*cbar1*sumyt2-cbar1*yt(nt,1)^2/nt)/sar;
end
if (p==1)
 mpt=(cbar1*cbar1*sumyt2+(1-cbar1)*yt(nt,1)^2/nt)/sar;
end
[sarf,ktild]=s2ar(y,z,p,cbar1,sumyt2,ahat,0,even);
[adf,a1]=adfp(yt,ktild);
mzt=mza*msb;
if p == 0
za = [za; -14.1];
mzt = [mzt; -1.95];
mza = [mza;-8.1];
msb = [msb; .19144];
adf = [adf; -1.95];
mpt = [mpt; 3.26];
pt = [pt; 3.26];
else
za = [z1; -21.0];
mzt = [mzt; -2.86];
mza = [mza;-16.3];
msb = [msb; .16449];
adf = [adf; -2.86];
mpt = [mpt; 5.62];
pt = [pt; 5.62];
end

function [adf,a1]=adfp(yt,kstar)
[nt,nc]=size(yt);
reg=lagn(yt,1);
dyt=diff(yt,1);
for i=1:kstar
 reg=[reg lagn(dyt,i)];
end
dyt=trimr(dyt,kstar,0);
reg=trimr(reg,kstar,0);
[rho,ee]=olsqr(dyt,reg);
[nef,nec]=size(ee);
s2e=ee'*ee/nef;
xx=inv(reg'*reg);
sre=xx(1,1)*s2e;
adf=rho(1,1)/sqrt(sre);
a1=rho(1,1)+1;

function [s2opt,kopt]=s2ar(y,z,p,cbar,sumyt2,ahat,index,even)
[nt,nc]=size(y);
min=9e+5;
kmax= round(12*(nt/100)^0.25);
s2vec=zeros(kmax+1,1);
[yts,ssr]=glsd(y,z,cbar);
dyts=diff(yts,1);
reg=lagn(yts,1);
for k=0:kmax
if k>0
dum=lagn(dyts,k);
reg=[reg dum];
end
 dyts=trimr(dyts,1,0);
 reg=trimr(reg,1,0);
[b,e]=olsqr(dyts,reg);
[nef,nec]=size(e);
s2e=e'*e/nef;
bic=nef*log(s2e)+k*log(nef);
if (bic < min)
  min=bic;
  kbic=k;
end
b1=0;
for j=1:k
b1=b1+b(j+1);
end
if k == 0
s2vec(k+1)=s2e;
else
s2vec(k+1)=s2e/((1-b1)^2);
end
end

ks = ceil(4*(nt/100)^(0.25));
msbar=sqrt(sumyt2/s2vec( ks,1));
gap=100*((ahat-1)^2)*msbar;

if p == 0 & index == 0
 kopt = kbic-2.58*log(1+gap)+3.68*log(1+gap*nt^0.25);
end;
if p == 0 & index == 1
kopt=kbic-1.77*log(1+gap)+3.14*log(1+gap*nt^.25);
end;
if p == 1 & index == 0
kopt=kbic-1.87*log(1+gap)+3.17*log(1+gap*nt^(1/6));
end;
if p == 1 & index == 1
kopt=kbic-2.50*log(1+gap)+3.13*log(1+gap*nt^(1/6));
end;
%display('kopt before truncation')
%display(kopt);
kopt=ceil(kopt);

if even==1;
if mod(kopt,2) ~=0
 kopt=kopt+1;
end;
%display(sprintf(' ahat %f gap %f kbic %f kopt %f',ahat,gap,kbic,kopt));
s2opt=s2vec(kopt+1,1);
end;




