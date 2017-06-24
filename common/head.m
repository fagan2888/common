function head(x,n);
if nargin == 1;
mymprint(x(1:10,:));
else;
mymprint(x(1:n,:));
end;