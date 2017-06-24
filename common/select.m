function S=select(y,mask);
SS= y ~= mask;
S= diag(SS);
bad=find(y==mask);
S(bad,:)=[];


