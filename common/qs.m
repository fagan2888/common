function [k,w]=ps(v,fixk);

% quadratic spectral
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
k=(1.3221*(alpha*T)^(0.2));
else;
k=fixk;   % we fix the bandwith
end;


if fixk==-1;disp('Automatic QS');
disp(sprintf('Bandwidth %f', k));
end;

w=zeros(T-1,1);

for i=1:T-1;
x=i/k;
del=6*pi*x/5;
w(i)=3*(sin(del)/del-cos(del))/(del*del);
end;

