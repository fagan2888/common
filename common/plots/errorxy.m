function H=errorxy(Data,Format,DotS,BarS,EB_End,GAxis,MarkerSize,MarkerFaceColor,LineWidth);
%--------------------------------------------------------------------
% errorxy function   plot two dimensinal graph with error bars
%                  on both axes.
% Input  : - Data matrix.
%          - Format vector, numbers of column to take as:
%            X axis ; Y axis ;
%            X error [left]; Y error [down]; <- (if 0 then take zeros)
%            X error [right], Y error [up] <- (if 0 then take as left/down).
%            Default = [1,2,3,4] or [1,2,3] if only three columns. 
%            The vector should have 2,3,4 or 6 cells.
%          - point symbol, {- : -. --}. default 'bo'
%                          {. o x + * s d v ^ > < p h}
%                          {y m c r g b w k}
%          - error bar symbol, {- : -. --} defualt 'b-'
%                              {y m c r g b w k}
%          - error-bar-end line, 'N' - no error-bar-end line (default).
%                                'Y' - error-bar-end, 
%                                      defult half length is 0.02
%                                      in units of axis length.
%                                #.# - manual half length in
%                                      units of axis length.
%                                      of axis scale.
%          - Grpah Axas type:  1 - normal plot, default.
%                              2 - semi log y
%                              3 - semi log x
%                              4 - log log
%          - Marker size, default is 6.0
%          - Marker Face Color, default is 'none'
%          - error bar line width, default is 0.5
% Output : - Handles for markers.
% Tested : Matlab 5.3
%     By : Eran O. Ofek           March 1999
%    URL : http://wise-obs.tau.ac.il/~eran/matlab.html
%--------------------------------------------------------------------
EB_EndRatio         = 0.02;

DataWidth = length(Data(1,:));

if (nargin==1),
   if (DataWidth==3),
      Format = [1,2,3];
   else
      Format = [1,2,3,4];
   end
   DotS   = 'bo';
   BarS   = 'b-';
   EB_End = 'N';
   GAxis  = 1;
   MarkerSize          = 6.0;
   MarkerFaceColor     = 'none';
   LineWidth           = 0.5;
elseif (nargin==2),
   DotS   = 'bo';
   BarS   = 'b-';
   EB_End = 'N';
   GAxis  = 1;
   MarkerSize          = 6.0;
   MarkerFaceColor     = 'none';
   LineWidth           = 0.5;
elseif (nargin==3),
   BarS   = 'b-';
   EB_End = 'N';
   GAxis  = 1;
   MarkerSize          = 6.0;
   MarkerFaceColor     = 'none';
   LineWidth           = 0.5;
elseif (nargin==4),
   EB_End = 'N';
   GAxis  = 1;
   MarkerSize          = 6.0;
   MarkerFaceColor     = 'none';
   LineWidth           = 0.5;
elseif (nargin==5),
   GAxis  = 1;
   MarkerSize          = 6.0;
   MarkerFaceColor     = 'none';
   LineWidth           = 0.5;
elseif (nargin==6),
   MarkerSize          = 6.0;
   MarkerFaceColor     = 'none';
   LineWidth           = 0.5;
elseif (nargin==7),
   MarkerFaceColor     = 'none';
   LineWidth           = 0.5;
elseif (nargin==8),
   LineWidth           = 0.5;
elseif (nargin==9),
   % do nothing
else
   error('Useage: Data [Format] [point symbol] [Bar symbol] [axis type]')
end
if (EB_End~='N' & EB_End~='Y'),
   EB_EndRatio = EB_End;
   EB_End      = 'Y';
end

if (isempty(BarS)==1),
   BarS = 'b-';
end
if (isempty(EB_End)==1),
   EB_End = 'N';
end




% number of points
N = length(Data(:,1));

% format size
Fl = length(Format);

if (Fl==2),
   X = Data(:,Format(1));
   Y = Data(:,Format(2));
elseif (Fl==3),
   X   = Data(:,Format(1));
   Y   = Data(:,Format(2));
   Xle = zeros(N,1);            % X left error
   Xre = zeros(N,1);            % X right error
   Yde = Data(:,Format(3));     % Y down error
   Yue = Yde;                   % Y up error
elseif (Fl==4),
   X   = Data(:,Format(1));
   Y   = Data(:,Format(2));
   Xle = Data(:,Format(3));     % X left error
   Xre = Xle;                   % X right error
   Yde = Data(:,Format(4));     % Y down error
   Yue = Yde;                   % Y up error
elseif (Fl==6),
   X   = Data(:,Format(1));
   Y   = Data(:,Format(2));
   Xle = Data(:,Format(3));     % X left error
   Xre = Data(:,Format(5));     % X right error
   Yde = Data(:,Format(4));     % Y down error
   Yue = Data(:,Format(6));     % Y up error
else
   error('Format should have 2,3,4 or 6 cells');
end


h_d=plot(X,Y,DotS);
%N = length(X);
%h_d=plot(X(1:N./2),Y(1:N./2),DotS);
%hold on;
%h_d=plot(X(N./2+1:N),Y(N./2+1:N),'^');

set(h_d,'MarkerSize',MarkerSize,'MarkerFaceColor',MarkerFaceColor);
H=h_d;

h_a = gca;
XLim = get(h_a,'XLim');
YLim = get(h_a,'YLim');
XRange = XLim(2) - XLim(1);
YRange = YLim(2) - YLim(1);


% ploting error bars
hold on;
for I=1:1:N,
   if (isfinite(X(I)) & isfinite(Y(I))),
      h_b = plot([X(I)-Xle(I);X(I)+Xre(I)],[Y(I);Y(I)],BarS);
      set(h_b,'LineWidth',LineWidth);
      h_b = plot([X(I);X(I)],[Y(I)-Yde(I);Y(I)+Yue(I)],BarS);
      set(h_b,'LineWidth',LineWidth);
      if (EB_End=='Y'),
         if (Yde(I)>0),
            h_b = plot([X(I)-XRange.*EB_EndRatio;X(I)+XRange.*EB_EndRatio],[Y(I)-Yde(I),Y(I)-Yde(I)],BarS);
            set(h_b,'LineWidth',LineWidth);
         end
         if (Yue(I)>0),
            h_b = plot([X(I)-XRange.*EB_EndRatio;X(I)+XRange.*EB_EndRatio],[Y(I)+Yue(I),Y(I)+Yue(I)],BarS);
            set(h_b,'LineWidth',LineWidth);
         end
         if (Xle(I)>0),
            h_b = plot([X(I)-Xle(I);X(I)-Xle(I)],[Y(I)-YRange.*EB_EndRatio;Y(I)+YRange.*EB_EndRatio],BarS);
            set(h_b,'LineWidth',LineWidth);
         end
         if (Xre(I)>0),
            h_b = plot([X(I)+Xre(I);X(I)+Xre(I)],[Y(I)-YRange.*EB_EndRatio;Y(I)+YRange.*EB_EndRatio],BarS);
            set(h_b,'LineWidth',LineWidth); 
        end
      end
   end
end


% set axis type
if (GAxis==1),
   % default
elseif (GAxis==2),
   set(h_a,'YScale','log');
elseif (GAxis==3),
   set(h_a,'XScale','log');
elseif (GAxis==4),
   set(h_a,'XScale','log');
   set(h_a,'YScale','log');
else
   error('Illigal axis type');
end



hold off;
