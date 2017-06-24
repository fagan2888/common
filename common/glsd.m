function yt=glsd(y,p);
if p==0;cbar=-7;end;
if p==1;cbar=-13.5;end;
nt=length(y);
 [nrows,ncols]=size(y);
 if nrows ~=nt; y=y'; end;
z=ones(nt,1);
if p==1;z=[z (1:1:nt)'];end;
abar=1+cbar/nt;
ya=zeros(nt,1);
za=zeros(nt,cols(z));
ya(1:1,1)=y(1,1);
za(1,:)=z(1,:);
ya(2:nt,1)=y(2:nt,1)-abar*y(1:nt-1,1);
za(2:nt,:)=z(2:nt,:)-abar*z(1:nt-1,:);
bhat=za\ya;
yt=y-z*bhat;
 if nrows ~=nt; yt=yt'; end;


