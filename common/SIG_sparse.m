function SIGMA = SIG_sparse(N,n,sigma);
%SIGMA is NxN sparse symmetric p.d. matrix with diag=sigma, and n*N*N non-zero elements
% proceed in two steps:
% first, a sparse p.d. correlation matrix is generated
% second, the corresponding covariance matrix is obtained using the vector
% of variances in sigma

warning off all

% STEP 1. 
dummy   = sprandsym(N,n,.8,2);      % use dummy to get pattern of sparse symmetric matrix with non-zero diagonal 
d       = find(dummy);              % indices of the non-zero elements of dummy
S       = sprand(N,N,n);            % sparse uniformly distributed random matrix
SS     = S*S' - diag(diag(S*S'))...
        + speye(N);                 % correlation matrix, has more non-zeros than S
dd      = SS(d);                   
SIGMA   = dummy;                    % give SIGMA he dimensions and pattern of dummy
SIGMA(d) = dd;                      % replace non-zero elements of dummy with those from SSS

SIGMA = full(SIGMA);                % declare SIGMA as a regular matrix

% check for positive definiteness
pd = 1 - any(eig(SIGMA)<=0);        % 1 if SIGMA is p.d.
while pd==0
    SIGMA = SIGMA + .01*eye(N);
    d = diag(SIGMA);                % this and the next line makes SIGMA a correlation matrix (1s on the diag)
    SIGMA = SIGMA ./ sqrt(d*d');
    pd = 1 - any(eig(SIGMA)<=0);
end

% STEP 2. transform SIGMA from correlation into covariance matrix
SIGMA = SIGMA .* sqrt(sigma*sigma');

warning on all
