function grdd = grad(f,x0,para);
%
% Purpose: To calculate the gradient of the function f at the point x0
%
% Format: 
%
% If f takes parameters, then the format is
%
% gradient = grad('f',x0,para)
%
% If not, the format is
%
% gradient = grad('f',x0)
%
% where f is a function and f(x) is an mxn matrix
%
% x0 is a kx1 vector
%
% Output: the gradient, an mnxk matrix defined as in Magnus & Neudecker (1988).
%
%

if ~isreal(x0);
   if abs(imag(x0))>eps;
      error('Not implemented for complex matrices');
   else
      x0 = real(x0);
   end
end
if nargin>2;
   f0 = vec(feval(f,x0,para));
else
   f0 = vec(feval(f,x0));
end
n = size(f0,1);
k = size(x0,1);
grdd = zeros(n,k);

ax0 = abs(x0);
if ~(x0==0);
   dax0 = x0./ax0;
else
   dax0 = 1;
end
dh = 10^(-8)*max([ax0,(1e-2)*ones(k,1)]')'.*dax0;
xdh = x0+dh;
dh = xdh-x0;
res = x0*ones(1,k);
arg = diag(xdh) + res - diag(diag(res));
for i = 1:k;
   if nargin>2
      grdd(:,i)=vec(feval(f,arg(:,i),para));
   else
      grdd(:,i)=vec(feval(f,arg(:,i)));
   end
end
grdd = (grdd-f0*ones(1,k))./(ones(n,1)*dh');