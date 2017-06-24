% estimation by principal components
% X is observed
% r is the true number of true factors
% F is T by r matrix of true factors
% Lambda N by r is the true loading matrix
% C=F*Lambda' T by N is the true common component
% chat is the estimated common component

function [ehat,fhat,lambda]=pc(y,nfac);
[bigt,bign]=size(y);
[Fhat0,eigval,Fhat1]=svd(y'*y);
lambda=Fhat0(:,1:nfac)*sqrt(bign);
fhat=y*lambda/bign;
ehat=y-fhat*lambda';
