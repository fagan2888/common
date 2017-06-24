function [S,yy]=select_notNan(y);
good= not(isnan(y));
bad=find(isnan(y));
S= diag(good);
S(bad,:)=[];
yy=y(good);


