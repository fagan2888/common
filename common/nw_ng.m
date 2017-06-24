function [k,w]=nw(v,fixk);
[T,nreg]=size(v);
if fixk==0;  % automatic bandwidth selection
bot=0;top=0;

for i=1:nreg;

rho(i)=v(1:T-1,i)\v(2:T,i);
e=v(2:T,i)-rho(i)*v(1:T-1,i);
sigma(i)=e'*e/(T-1);
top=top+4*(rho(i)^2)*sigma(i)^2/(((1-rho(i))^6)*(1+rho(i))^2);
bot=bot+sigma(i)^2/((1-rho(i))^4);
end;

alpha=top/bot;
k=ceil(1.1447*(alpha*T)^(1/3));
else;
k=fixk;   % we fix the bandwith
end;


%if fixk==0;disp('Automatic NW');end;
%disp(sprintf('Bandwidth %f %f', k ,alpha));


w=zeros(k,1);

for i=1:k;
x=i/k;
w(i)=1-i/(k+1);
end;
