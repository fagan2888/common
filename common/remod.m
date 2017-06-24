function [ff,pp,xbar]=remod(func,ini,nd,nz,nk,rho,zbar);
nx=nd+nk;
options=optimset('fsolve');
options=optimset(options,'LargeScale','off');
xbar=fsolve('solvess',ini,options,zbar,func);
disp('Steady State');
disp(sprintf(' %10.4f ',xbar'));
xzbar = [xbar;xbar;zbar;zbar];
gra  = grad(func,xzbar,0);
aa = gra(:,1:nx);
bb = gra(:,nx+1:2*nx);
cc = gra(:,2*nx+1:2*nx+nz);
dd = gra(:,2*nx+nz+1:2*nx+2*nz);
[ff,pp] = solve(aa,bb,cc,dd,rho,nk);
ff=real(ff);
pp=real(pp);


