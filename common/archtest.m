function [rnull,pval]=archtest(u,q,alpha);

T=rows(u);
right=ones(T,1);
u2=u.*u;
for i=1:q;
right=[right lagn(u2,i)];
end;
left=trimr(u2,q,0);
right=trimr(right,q,0);
res=nwest(left,right,0);
LM=T*res.rsqr;
pval=1-chi2cdf(LM,q);
rnull=pval < alpha;
