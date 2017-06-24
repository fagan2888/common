function H = plotpoly(Par,XRange,LineType,NumPoint);
%--------------------------------------------------------------------
% plotpoly function       plot polynomial curve from coef.
% Input  : - vector of polynomial parameters,
%            [a0,a1,...]
%          - X axis range, [X_min, X_max].
%          - Line Type, (default is 'r-').
%          - Number of points in line. (default is 100).
% Output : - plot handle.
% Plot   : - Plot polynomial line.
% See also : fitpoly.m
% Tested : Matlab 5.2
%     By : Eran O. Ofek           September 1999
%    URL : http://wise-obs.tau.ac.il/~eran/matlab.html
%--------------------------------------------------------------------
if (nargin==2),
   LineType = 'r-';
   NumPoint = 100;
elseif (nargin==3),
   NumPoint = 100;
elseif (nargin==4),
   % no default
else
   error('Illigal number of input parameters');
end

Npar = length(Par);

Span = XRange(2) - XRange(1);
X = [XRange(1):Span./NumPoint:XRange(2)]';
Y = polyval(rot90(Par,2),X);

H = plot(X,Y,LineType);



