function b = grplassoShooting(X, Y, G, lambda, maxIt),

% Shooting algorithm for the group lasso in the penalized form.
% minimize .5*||Y-X*beta||_2^2 + lambda*sum(sqrt(p_g)*||beta_g||_2)
% where p_g is the dimension of the subspace g, for g in G.
% Ref: 
% - Yuan and Lin (2005) Model selection and estimation in regression
% with grouped variables. JRSSB.
% - Fu (1998) Penalized regression: the bridge versus the lasso. J. Comput.
% Graph. Stats.

if nargin < 5, maxIt = 1e4; end

nG = length(unique(G)); % Number of groups
[n,p] = size(X);
for g = 1:nG,
    X(:,g==G) = orth(X(:,g==G));    % Caution: orth may flip signs
    p_g(g) = sum(g==G); % Dimension for each subspace, assuming full column ranks
end
Y = Y-mean(Y);
tol = 1e-10;

% Initialization
if p > n,
    b = zeros(p,1); % From the null model, if p > n
else
    b = X \ Y;  % From the OLS estimate, if p <= n
end
b_old = b;
i = 0;

% Precompute X'X and X'Y
XTX = X'*X;
XTY = X'*Y;

% Shooting loop
while i < maxIt,
    i = i+1;
    for g = 1:nG,
        S0 = XTY(g==G) - XTX(g==G,g~=G)*b(g~=G);
        if (lambda*sqrt(p_g(g))) < norm(S0,2),
            b(g==G) = (1-lambda*sqrt(p_g(g))/norm(S0,2))*S0;
        else
            b(g==G) = zeros(p_g(g),1);
        end
    end
    delta = norm(b-b_old,2);    % Norm change during successive iterations
    if delta < tol, break; end
    b_old = b;
end
if i == maxIt,
    fprintf('%s\n', 'Maximum number of iteration reached, shooting may not converge.');
end


% Normalize columns of X to have mean zero and length one.
function sX = normalize(X)

[n,p] = size(X);
sX = X-repmat(mean(X),n,1);
sX = sX*diag(1./sqrt(ones(1,n)*sX.^2));
