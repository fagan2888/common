function graph(x,symb,c_e,c_x,c_y);
%--------------------------------------------------------------------
% graph function       simple plot function.
% Input  : - matrix.
%          - symb is the graph symbol: '.','o','*' etc.
%            default is solid line.
%          - Y error-bar column,. default is no error bar.
%          - X axis column, default is 1.
%          - Y axis column, default is 2.
% Output : graph.
% Tested : Matlab 3.5
%     By : Eran O. Ofek           December 1993
%    URL : http://wise-obs.tau.ac.il/~eran/matlab.html
%--------------------------------------------------------------------
if nargin==1,
   c_x = 1;
   c_y = 2;
   symb = '-';
elseif nargin==2,
   c_x = 1;
   c_y = 2;
elseif nargin==3,
   wid=length(x(1,:));
   if c_e>wid,
      error('error bar column, no such column');
   end
   c_x = 1;
   c_y = 2;
elseif nargin>5,
   error('1, 2, 3 or 5 args only');
elseif nargin==4,
   error('1, 2, 3 or 5 args only');
end
plot(x(:,c_x),x(:,c_y),symb);
if nargin>2,
   hold on;
   errorbar(x(:,c_x),x(:,c_y),x(:,c_e));
   hold off;
end
