function [L_h,F_h]=arrow1(Start,Stop,ALen,Base,SLen,Width,Color,BLineStyle);
%---------------------------------------------------------
% arrow1           plot a nice arrow
%                plot an arrow with the following properties:
%
%                A-D: SLen                    ^ A
%                A-C: ALen                   / \       
%                A  : Stop point            /   \
%                B  : Start point          /     \
%                E-F: Base                / ..D.. \
%                                       E/..  |C ..\F
%                                             |
%                                             |B
% Input  : - Start points. [X Y]
%          - Stop pouints. [X Y]
%          - Arrow length. (default is 0.05 of total length).
%          - Base length.  (default is 1/2 of arrow length).
%          - Short length. (default is like Arrow length).
%          - line width. (default is 0.5).
%          - color. (default is 'k').
%          - boundary line style. (default is 'none').
% Output : - Line handle.
%          - Arrow (filled) handle.
% Bugs   : Working only in linear scale with 1:1 scale.
% Tested : Matlab 5.1 
%     By : Eran O. Ofek         October 1999
%    URL : http://wise-obs.tau.ac.il/~eran/matlab.html
%---------------------------------------------------------

Length = sqrt((Stop(1)-Start(1)).^2+(Stop(2)-Start(2)).^2);

if (nargin==8),
   % no default.
elseif (nargin==7),
   BLineStyle = 'none';
elseif (nargin==6),
   Color      = 'k';
   BLineStyle = 'none';
elseif (nargin==5),
   Width      = 2.0;
   Color      = 'k';
   BLineStyle = 'none';
elseif (nargin==4),
   SLen       = ALen;
   Width      = 2.0;
   Color      = 'k';
   BLineStyle = 'none';
elseif (nargin==3),
   Base       = 0.5.*ALen;
   SLen       = ALen;
   Width      = 2.0;
   Color      = 'k';
   BLineStyle = 'none';
elseif (nargin==2),
   ALen       = 0.05.*Length;
   Base       = 0.5.*ALen;
   SLen       = ALen;
   Width      = 2.0;
   Color      = 'k';
   BLineStyle = 'none';
else
   error('illigal number of input arguments');
end


L_h=plot([Start(1),Stop(1)],[Start(2),Stop(2)],Color);
set(L_h,'LineWidth',Width);
hold on;
Theta  = atan2(Stop(2)-Start(2),Stop(1)-Start(1));


A(1) = Stop(1);
A(2) = Stop(2);
D(1) = A(1) - SLen.*cos(Theta);
D(2) = A(2) - SLen.*sin(Theta);

Phi  = atan(0.5.*Base./ALen);
BC   = sqrt(ALen.^2 + (0.5.*Base).^2);


E(1) = A(1) - BC.*cos(Theta  + Phi);
E(2) = A(2) - BC.*sin(Theta  + Phi);

F(1) = A(1) - BC.*cos(Theta  - Phi);
F(2) = A(2) - BC.*sin(Theta  - Phi);

F_h=fill([A(1);E(1);D(1);F(1)],[A(2);E(2);D(2);F(2)],Color);
set(F_h,'LineStyle',BLineStyle);
