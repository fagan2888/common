function xx=arlag(x,k);

if k==0;
   xx=[];
else;
	xx=[];
  	for i=1:k;
   xx=[xx lagn(x,i)];
end;
end;
