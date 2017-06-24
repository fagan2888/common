function psi=irf(alpha,theta,steps);
e=zeros(steps,1);
e(1)=1;
psi=filter([1 theta'],[1 -alpha'],e);
psi=psi';

