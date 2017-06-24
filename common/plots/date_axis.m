function date_axis(N,JDOffset,FontSize,Rotation);
%----------------------------------------------------------------------
% date_axis function       plot the date in the upper x axis by
%                        reading julian day x-axis labels. 
% Input  : - Number of dates to label (default is 6).
%          - JD Offset (i.e. If MJD are used then this should be 2400000.
%          - Font Size (default is 10).
%          - Rotation (default is 90).
% Example: plot(MJD,Mag); date_axis(10,2450000,12,45);
% See also: julday.m, julday1.m jd2date.m 
% Tested : Matlab 5.3
%     By : Eran O. Ofek        January 2000
%    URL : http://wise-obs.tau.ac.il/~eran/matlab.html
%----------------------------------------------------------------------
if (nargin==0),
   N = 6;
   JDOffset = 0;
   FontSize = 10;
   Rotation = 90;
elseif (nargin==1),
   JDOffset = 0;
   FontSize = 10;
   Rotation = 90;
elseif (nargin==2),
   FontSize = 10;
   Rotation = 90;
elseif (nargin==3),
   Rotation = 90;
elseif (nargin==4),
   % no default.
else
   error('Illigal number of input arguments');
end

TickLp = 0.007;

Hf = gcf;
Ha = gca;
hold on;

XLim = get(Ha,'XLim');
YLim = get(Ha,'YLim');
YDir = get(Ha,'YDir');
if (YDir(1)=='r'),
   YLim2 = YLim(1);
   YLim1 = YLim(2);
   Ts = -1;
else
   YLim1 = YLim(1);
   YLim2 = YLim(2);
   Ts = 1;
end

TickL = Ts.*TickLp.*(abs(YLim2 - YLim1));

Pos  = get(Ha,'Position');
Pos(4) = 0.9.*Pos(4);
set(Ha,'Position',Pos);


DX = (XLim(2) - XLim(1))./(N-1);
X = [XLim(1):DX:XLim(2)].';

Date = jd2date(X+JDOffset);

if (DX<20),
   for I=1:1:N,
      Ht(I) = text(1,1,[' ',num2str(Date(I,1)),'/',num2str(Date(I,2)),'/',num2str(Date(I,3))]);
      set(Ht(I),'FontSize',FontSize,'Rotation',Rotation,'Position',[X(I),YLim2]);
      plot([X(I);X(I)],[YLim2;YLim2-TickL],'k-');
   end
else
   for I=1:1:N,
      Ht(I) = text(1,1,[' ',num2str(Date(I,2)),'/',num2str(Date(I,3))]);
      set(Ht(I),'FontSize',FontSize,'Rotation',Rotation,'Position',[X(I),YLim2]);
      plot([X(I);X(I)],[YLim2;YLim2-TickL],'k-');
   end
end

axis([XLim, YLim]);
hold off;      
   
