function [Start,End,L_h]=draw_iline(LineType,LineWidth);
%------------------------------------------------------------
% draw_iline          draw line interactively.
%                   Click the mouse right bottom in start
%                   point and at end point.
%                   Click left mouse button
%                   to exit this program.
% Input  : - Line type and color (default is 'r-').
%          - Line width (default is 0.5).
% Output : - column vector of Start points [x,y].
%          - column vector of End points [x,y].
%          - vector of line handels.
% Tested : Matlab 5.1
%     By : Eran O. Ofek           October 1999
%    URL : http://wise-obs.tau.ac.il/~eran/matlab.html
%------------------------------------------------------------
if (nargin==0),
   LineType  = 'r-';
   LineWidth = 0.5;
elseif (nargin==1),
   LineWidth = 0.5;
elseif (nargin==2),
   % no default
else
   error('Illigal number of input parameters');
end

IStart = zeros(100,2);
IEnd   = zeros(100,2);
L_h    = zeros(100,1);

hold on;

I      = 0;
Button = 3;
while (Button==3),
   [X1,Y1,Button] = ginput(1);
   if (Button==3),
      [X2,Y2,Button] = ginput(1);
      I = I + 1;
      IStart(I,1) = X1;
      IStart(I,2) = Y1;
      IEnd(I,1)   = X2;
      IEnd(I,2)   = Y2;
      L_h(I)=plot([X1;X2],[Y1;Y2],LineType);
      set(L_h(I),'LineWidth',LineWidth);
   end
end


Start = IStart(1:I,:);
End = IEnd(1:I,:);
