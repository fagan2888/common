function [r,t,p]=spear(x,y)
%Syntax: [r,t,p]=spear(x,y)
%__________________________
%
% Spearman's rank correalation coefficient.
%
% r is the Spearman's rank correlation coefficient.
% t is the t-ratio of r.
% p is the corresponding p-value.
% x is the first data series (column).
% y is the second data series (column), which can contain multiple columns.
%
%
% Reference:
% Press W. H., Teukolsky S. A., Vetterling W. T., Flannery B. P.(1996):
% Numerical Recipes in C, Cambridge University Press. Page 641.
%
%
% Alexandros Leontitsis
% Department of Education
% University of Ioannina
% 45110- Dourouti
% Ioannina
% Greece
% 
% University e-mail: me00743@cc.uoi.gr
% Lifetime e-mail: leoaleq@yahoo.com
% Homepage: http://www.geocities.com/CapeCanaveral/Lab/1421
% 
% 3 Feb 2002.


% x and y myst have equal number of raws
if size(x,1)~=size(y,1)
    error('x and y myst have equal number of raws.');
end


% Get the ranks of x
R=crank(x)';


% Remove their mean
R=R-mean(R);

for i=1:size(y,2)
    
    % Get the ranks of y
    S=crank(y(:,i))';
    
    % Remove their mean
    S=S-mean(S);
    
    % Calculate the correlation coefficient
    r(i)=sum(R.*S)/sqrt(sum(R.^2)*sum(S.^2));
    
end

% Find the data length
N=length(x);

% Calculate the t statistic
t=r.*sqrt((N-2)./(1-r.^2));

% Handle the NANs
t(find(isnan(t)==1))=0;

% Calculate the p-values
p=2*(1-tcdf(abs(t),N-2));





