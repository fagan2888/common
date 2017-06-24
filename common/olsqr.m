function [b,e]=olsqr(y,x)
b=x\y;
e=y-x*b;


