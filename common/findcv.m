function cv= findcv(a,x);
% a is matrix with percentage points in column 1, and p values on the second
% x is level of significance, and we want the corresponding critical value
aa=abs(a(:,2)-x);
[j1,j2]=min(aa);
cv=a(j2,1);
