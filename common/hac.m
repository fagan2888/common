function [hac,k]=hac(u,fixk,prewhite,kernel);

% computes long run variance
% kernel =1 use Parzen
% kernel =2 use QS
% kernel =3 use NW
% fixk=-1 uses Andrews automatic bandwidth selection
% fixk > 0 uses the user specified bandwidth
% prewhite == 1 does prewhitening

[T,nreg]=size(u);
rho=zeros(nreg,1);
sigma=zeros(nreg,1);
d=zeros(nreg,nreg);
beta=zeros(nreg,nreg);

if prewhite ==1;
v=u;
reg=u(1:T-1,:);  % matrix of lagged variables
for i=1:nreg;
beta(:,i)=reg\u(2:T,i);  % this is the same as regessing y(t) on x;
v(2:T,i)=u(2:T,i)-reg*beta(:,i);  % these are the prewhitened residuals
end;
v=trimr(v,1,0);   % after AR(1) prewhitening we loose the first obs.
else;
v=u;
end;


T1=rows(v);

if kernel==1;
[k,w]=parzen(v,fixk);
end;
if kernel==2;
[k,w]=qs(v,fixk);
end;
if kernel==3;
[k,w]=nw(v,fixk);
end;


vcv=v'*v;
for i=1:size(w,1);
cov=v(i+1:T1,:)'*v(1:T1-i,:);
vcv=vcv+w(i)*cov;
cov=v(1:T1-i,:)'*v(i+1:T1,:);
vcv=vcv+w(i)*cov;
end;

vcv=vcv/(T1-nreg);

% recoloring
if prewhite == 1;
hac=inv(eye(nreg)-beta)*vcv*(inv(eye(nreg)-beta))';
else;
hac=vcv;
end;

