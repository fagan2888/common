function yqtr = m2q(ymth,flag,freq)
% PURPOSE: converts monthly time-series to quarterly averages
%---------------------------------------------------
% USAGE:  yqtr = m2q(ymth)
% where:  ymth = monthly time series vector or matrix (nobs x k)
%         flag = 0 for averages (default) and 1 for sums 2 for point sampled
%          freq = 3 for quarterly
%               =12 for annual
%---------------------------------------------------
% RETURNS: yqtr = quarterly time-series vector or matrix
%                 [floor(nobs/freq) + 1] in length by k columns

%---------------------------------------------------
% NOTES:  the last observation is the actual month or
%         the average (sum) of the last freq-1 months in cases where
%         nobs/freq has a remainder               
%---------------------------------------------------


[nobs qvar] = size(ymth);

robs = rem(nobs,freq);
if nargin == 1
flag = 0;
end;


qobs=ceil(nobs/freq);
denom = ones(qobs,qvar)*freq;
if robs> 0;
  ymth=[ymth;zeros(robs,cols(ymth))];  % pad zeros;
  denom(qobs,:)=ones(1,qvar)*robs;
end;  




if flag ~=2;
yqtr = zeros(qobs,qvar);
for cnt=1:qobs;
  for i=1:freq;
    j=(cnt-1)*freq+i;
    yqtr(cnt,:)=yqtr(cnt,:)+ymth(j,:);
    end;
if flag == 0
yqtr(cnt,:) = yqtr(cnt,:)./denom(cnt,:);
end;
end;
end;

if flag ==2;
  pick=ceil((freq+1)/2);
  yqtr=zeros(qobs,qvar);
  for cnt=1:qobs;
    j=(cnt-1)*freq+pick;
    yqtr(cnt,:)=ymth(j,:);
  end;
  end;



