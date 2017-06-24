function fit=graphfit(x,symb,n,sy_p,c_e,c_x,c_y);
%--------------------------------------------------------------------
% graphfit function    graph ploting and polynomial fiting to the
%                    data. 
% input  : - matrix to plot column wise.
%          - symb is the graph symbol: '.','o','*' etc.
%            default is solid line.
%          - polynomial fiting degree. 0 is no fiting. default is 1.
%          - symbol of polynomial fiting. 0 if not fiting.
%            default is '-r'.
%          - c_e, the column of error bar. default is no error bar.
%          - c_x, the column of time. default is 1.
%          - c_y, the column of magnitudes. default is 2.
% output : - graph.
% Tested : Matlab 4.2
%     By : Eran O. Ofek           January 1994
%    URL : http://wise-obs.tau.ac.il/~eran/matlab.html
%--------------------------------------------------------------------
if nargin==1,
   c_x = 1;
   c_y = 2;
   symb = '-';
   n = 1;
   sy_p = '-r';
elseif nargin==2,
   c_x = 1;
   c_y = 2;
   n = 1;
   sy_p = '-r';
elseif nargin==3,
   c_x = 1;
   c_y = 2;
   sy_p = '-r';
elseif nargin==4,
   c_x = 1;
   c_y = 2;
elseif nargin==5,
   wid=length(x(1,:));
   if c_e>wid,
      error('error bar column, no such column');
   end
   c_x = 1;
   c_y = 2;
elseif nargin>7,
   error('1, 2, 3 or 5 args only');
elseif nargin==6,
   error('1, 2, 3 or 5 args only');
end
fit = polyfit(x(:,c_x),x(:,c_y),n);
len = length(x(:,c_x));
min = x(1,c_x);
max = x(len,c_x);
range = [min:(max-min)/200:max];
sol = polyval(fit,range);
plot(x(:,c_x),x(:,c_y),symb,range,sol,sy_p);
if nargin>4,
   hold on;
   errorbar(x(:,c_x),x(:,c_y),x(:,c_e));
   hold off;
end
