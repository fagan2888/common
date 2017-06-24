function [k,w]=parzen(v,fixk);
[T,nreg]=size(v);
if fixk==-1;  % automatic bandwidth selection
bot=0;top=0;
for i=1:nreg;

rho(i)=v(1:T-1,i)\v(2:T,i);
e=v(2:T,i)-rho(i)*v(1:T-1,i);
sigma(i)=e'*e/(T-1);
top=top+4*(rho(i)^2)*sigma(i)^2/(1-rho(i))^8;
bot=bot+sigma(i)^2/((1-rho(i))^4);
end;

alpha=top/bot;
k=ceil(2.6614*(alpha*T)^(0.2));
if k > T/2; k = T/2;
end;
else;
k=fixk;   % we fix the bandwith
end;

if fixk==-1;disp('Automatic Parzen');end;
disp(sprintf('Bandwidth %f', k));

w=zeros(k,1);

for i=1:k;
x=i/k;
if abs(x)>= 0 & abs(x) <=.5;
w(i)=1-6*(abs(x))^2+6*abs(x)^3;
else;
w(i)=2*(1-abs(x))^3;
end;
end;
