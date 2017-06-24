
function xx=mydiff(x,k)
[nt,nc]=size(x);
if (k==0) xx=x;
else
x1=trimr(x,k,0);
x2=trimr(lagn(x,k),k,0);
xx=[zeros(k,nc); x1-x2];

end
