function temp=myacf(x,nlags,flag);

temp=var(x);
T=rows(x);

for i=1:20;
	dum=cov(x(i+1:T,1),x(1:T-i,1));
		temp=[temp; dum(2,1)];
end;


if flag==1;
temp=temp./var(x);
end;

