function tail(x,n);
if nargin == 1;
mymprint(x(end-10:end,:));
else;
mymprint(x(end-n:end,:));
end;