function cv= findpinv(a,x);
% given x, what is the percentage point in the distribution given by a.
aa=abs(a(:,2)-x);
[j1,j2]=min(aa);
cv=a(j2,1);
