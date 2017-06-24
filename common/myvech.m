% unique elements of symmetric matrix
function a=myvech(x);

[m,n]=size(x);
if abs(m-n) > 0; error('Error: matrix should be symmetric'); end;
a=x(:,1);
for j=2:m;
  a=[a; x(j:n,j)];
end;  
