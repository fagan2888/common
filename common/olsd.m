function [e]=olsd(y,p);
 T=length(y);
 [nrows,ncols]=size(y);
 if nrows ~=T; y=y';
end;
if p==-1; e=y; end;
  if p>=0;
reg=ones(T,1);
trend=seqa(1,1,T);
for i=1:p;
reg=[reg trend.^i];
end;
beta=myols(y,reg);
e=y-reg*beta;
  end;
  if nrows ~=T; e=e'; end;
