function [vr,z0,z1] = VRTest(y,q)
% VRATIO: variance ratio test for random walks
% syntax: [vr,z0,z1] = vratio(y,q)
%     y: column vector of data to test for random walk
%     q: lag intervals to test (column vector of integers greater than 1)
%     vr: variance ratios for each lag intervals
%     z0: test statistics under homoskedasticity
%     z1: test statistics under heteroskedasticity
% Note: z0, z1 are unit normal under the null of a random walk
% Reference: Lo & MacKinlay (1988) "Stock Market Prices do Not Follow Random 
%    Walks: Evidence from a Simple Specification Test," Review of Financial 
%    Studies, 1, 1, 41-66.

% set size of indivdual test
alpha = 0.05;
out = 1;             % dummy to display output

% error checking
if nargin < 2
   error('You must specify the lag interval to test.');
elseif q~=ceil(q) | any(q<2)
   error('Lag intervals must be integers greater than 1.')
end

obs = length(y);

if obs<=max(q)
   error('Insufficient number of obs for largest lag interval.')   
end

% compute 1st differences
dx1 = zeros(obs,1);
dx1(2:obs,:) = y(2:obs,:) - y(1:obs-1,:);

% compute mean of dx1 (8a) in Lo-Mac
mu = (y(obs,:)-y(1,:))/(obs-1);

% compute var(dx1) (12a) in Lo-Mac
dmx1 = dx1 - mu;
va = dmx1(2:obs,:)'*dmx1(2:obs,:)/(obs-2);

% declare result containers
nq = length(q);
vr = zeros(nq,1);
z0 = zeros(nq,1);
z1 = zeros(nq,1);

% loop through each lag interval
for i=1:nq
   p = q(i);                     % lag interval
   
   % compute q-th differences
   dxq = zeros(obs,1);
   dxq(p+1:obs,:) = y(p+1:obs,:) - y(1:obs-p,:);
   
   % compute var(dxq) (12b) in Lo-Mac
   dmxq = dxq - p*mu;
   m = p*(obs-p)*(1-p/(obs-1));
   vc = dmxq(p+1:obs,:)'*dmxq(p+1:obs,:)/m;
   
   % compute z-stat under homoskedasticity (14b) in Lo-Mac
   vr(i) = vc/va;
   se0 = sqrt(2*(2*p-1)*(p-1)/3/p);
   z0(i) = sqrt(obs-1)*(vr(i)-1.0)/se0;
   
   % heteroskedasticity case
   % compute asymptotic variance (19) & (20) in Lo-Mac  
   nmr = 0.0;
   for j=1:p-1
      nmr = nmr + 4*((p-j)/p)^2*(obs-1)*(dmx1(2:obs-j,:).^2)'*(dmx1(j+2:obs,:).^2);
   end
   se1 = sqrt(nmr)/va/(obs-2);
   
   % compute z-stat for hetero
   z1(i) = sqrt(obs-1)*(vr(i)-1.0)/se1;
end
out=0;
if (out>0)
   % display output
   disp('------------------------------------------------');
   disp('     lags     vratio      z0      z1');
   disp([q,vr,z0,z1]);
   
   % multiple variance ratio test
   ap = 1-(1-alpha)^(1/nq);
   cv = norminv(1-ap/2);
   disp('------------------------------------------------');
   disp(' 5% critical value (Bonferroni corrected): ');
   disp(cv);
end
