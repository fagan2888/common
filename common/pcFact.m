function [fact,lambda] = pcFact(y,r,opt);
% r - number of factors
% opt(1) - whether to demean/standardize
% opt(2) - to use TxT or NxN covariance for computing the factors

[T,N] = size(y);

switch opt(1)
    case 0 % do not change
        yy = y;
    case 1 % demean only
        yy = (y - repmat(mean(y),T,1));
    case 2 % standardise
        yy = (y - repmat(mean(y),T,1))./repmat(std(y,1),T,1);
end

%[F1,d1,F2]     = eigs(yy*yy',r); 
switch opt(2)
    case 1 
%        [F,d,F1]   = svds(yy*yy',r); % more convenient than svd, produces the r largest sv
%        fact       = F*sqrt(T);
         [F,d,F1]=svd(yy*yy');
	 fact=F(:,1:r);
        lambda     = yy'*fact/T;
    case 2
%        [L,d,L1]   = svds(yy'*yy,r);
%        lambda     = sqrt(N)*L;
        [L,d,L1]=svd(yy'*yy);
	lambda=L(:,1:r);
        fact       = yy*lambda/N;
end
        
        
