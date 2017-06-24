function pval= findpval(a,x);
% a matrix with  the percentiles in the first column and p-values in the second
% x is the statistic whose p-value we seek

aa=abs(a(:,1)-x);
[j1,j2]=min(aa);
pval=a(j2,2);
