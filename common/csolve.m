function [x,rc] = csolve(FUN,x,xp,tune)
%function [x,rc] = csolve(FUN,x,xp,tune)
%FUN should be written so that any parametric arguments are packed in to xp,
% and so that if presented with a matrix x, it produces a return value of
% same dimension of x.  The number of rows in x and FUN(x) are always the
% same.  The number of columns is the number of different input arguments
% at which FUN is to be evaluated.
% tune is an optional vector to control the algorithm:[itmax,crit,delta,alpha]
if nargin<4
   tune=zeros(4,1);
end
itmax=tune(1);crit=tune(2);delta=tune(3);alpha=tune(4);
%---------- crit  --------------------
% sum of abs. values small enough to be a solution
if crit==0
   crit = 1e-8;
end
%---------- delta --------------------
% differencing interval for numerical gradient
if delta==0
   delta = 1e-6;
end
%-------------------------------------
%------------ alpha ------------------
% tolerance on rate of descent
if alpha==0
   alpha=1e-3;
end
%---------------------------------------
%------------ itmax ---------------------
% max no. of iterations
if itmax==0
   itmax=100;
end
%---------------------------------------
nv=length(x);
tvec=delta*eye(nv);
done=0;
f0=feval(FUN,x,xp);
af0=sum(abs(f0));
af00=af0;
itct=0;
while ~done
   if itct>3 & af00-af0<crit*max(1,af0) & rem(itct,2)==1
      randomize=1;
   else
      grad = (feval(FUN,x*ones(1,nv)+tvec,xp)-f0*ones(1,nv))/delta;
      if isreal(grad)
         if rcond(grad)<1e-12
            grad=grad+tvec;
         end
         dx0=-grad\f0;
         randomize=0;
      else
         disp('imaginary gradient')
         randomize=1;
      end
   end
   if randomize
      fprintf(1,'\n Random Search')
      dx0=norm(x)./randn(size(x));
   end
   lambda=1;
   lambdamin=1;
   fmin=f0;
   xmin=x;
   afmin=af0;
   dxSize=norm(dx0);
   factor=.6;
   shrink=1;
   subDone=0;
   while ~subDone
      dx=lambda*dx0;
      f=feval(FUN,x+dx,xp);
      af=sum(abs(f));
      if af<afmin
         afmin=af;
         fmin=f;
         lambdamin=lambda;
         xmin=x+dx;
      end
      if ((lambda >0) & (af0-af < alpha*lambda*af0)) | ((lambda<0) & (af0-af < 0) )
         if ~shrink
            factor=factor^.6;
            shrink=1;
         end
         if abs(lambda*(1-factor))*dxSize > .1*delta;
            lambda = factor*lambda;
         elseif (lambda > 0) & (factor==.6) %i.e., we've only been shrinking
            lambda=-.3;
         else %
            subDone=1;
            if lambda > 0
               if factor==.6
                  rc = 2;
               else
                  rc = 1;
               end
            else
               rc=3;
            end
         end
      elseif (lambda >0) & (af-af0 > (1-alpha)*lambda*af0)
         if shrink
            factor=factor^.6;
            shrink=0;
         end
         lambda=lambda/factor;
      else % good value found
         subDone=1;
         rc=0;
      end
   end % while ~subDone
   itct=itct+1;
   fprintf(1,'\nitct %d, af %g, lambda %g, rc %g',itct,afmin,lambdamin,rc);
   fprintf(1,'\n   x  %10g %10g %10g %10g',xmin);
   fprintf(1,'\n   f  %10g %10g %10g %10g',fmin);
   x=xmin;
   f0=fmin;
   af00=af0;
   af0=afmin;
   if itct >= itmax
      done=1;
      rc=4;
   elseif af0<crit;
      done=1;
      rc=0;
   end
end








