function [beta,se]=twosls(y,X,Z);


P=Z*inv(Z'*Z)*Z';
beta=inv(X'*P*X)*X'*P*y;
T=rows(y);
ehat=y-X*beta;
s2=ehat'*ehat/T;
vcv= s2*inv(X'*P*X);
se=sqrt(diag(vcv));

