function subplot1(M,N,varargin);
%-------------------------------------------------------------------------
% subplot1 function         An mproved subplot function
% Input  : - If more than one input argumenst are given,
%            then the first parameter is the number of rows.
%            If single input argument is given, then this is the
%            subplot-number for which to set focus.
%          - Number of columns.
%          * variable number of parameters
%            (in pairs: ...,Keywoard, Value,...)
%           - 'Min'    : X, Y lower position of lowest subplot,
%                        default is [0.10 0.10].
%           - 'Max'    : X, Y largest position of highest subplot,
%                        default is [0.95 0.95].
%           - 'Gap'    : X,Y gaps between subplots,
%                        default is [0.01 0.01].
%           - 'XTickL' : x ticks labels option,
%                        'Margin' : plot only XTickLabels in the
%                                   subplot of the lowest  row (defailt).
%                        'All'    : plot XTickLabels in all subplots.
%                        'None'   : don't plot XTickLabels in subplots.
%           - 'YTickL' : y ticks labels option,
%                        'Margin' : plot only YTickLabels in the
%                                   subplot of the lowest  row (defailt).
%                        'All'    : plot YTickLabels in all subplots.
%                        'None'   : don't plot YTickLabels in subplots.
%           -  'FontS'  : axis font size, default is 10.
%             'XScale' : scale of x axis:
%                        'linear', default.
%                        'log'
%           -  'YScale' : scale of y axis:
%                        'linear', default.
%                        'log'
% Example: subplot1(2,2,'Gap',[0.02 0.02]);
%          subplot1(2,3,'Gap',[0.02 0.02],'XTickL','None','YTickL','All','FontS',16);
% See also : subplot1c.m
% Tested : Matlab 5.3
%     By : Eran O. Ofek           June 2002
%    URL : http://wise-obs.tau.ac.il/~eran/matlab.html
%-------------------------------------------------------------------------
MinDef      = [0.10 0.10];
MaxDef      = [0.95 0.95];
GapDef      = [0.01 0.01];
XTickLDef   = 'Margin';  
YTickLDef   = 'Margin';  
FontSDef    = 10;
XScaleDef   = 'linear';
YScaleDef   = 'linear';

% set default parameters
Min    = MinDef;
Max    = MaxDef;
Gap    = GapDef;
XTickL = XTickLDef;
YTickL = YTickLDef;
FontS  = FontSDef;
XScale = XScaleDef;
YScale = YScaleDef;


MoveFoc = 0;
if (nargin==1),
   %--- move focus to subplot # ---
   MoveFoc = 1;
elseif (nargin==2),
   % do nothing
elseif (nargin>2),
   Narg = length(varargin);
   if (0.5.*Narg==floor(0.5.*Narg)),

      for I=1:2:Narg-1,
         switch varargin{I},
          case 'Min'
 	     Min = varargin{I+1};
          case 'Max'
 	     Max = varargin{I+1};
          case 'Gap'
 	     Gap = varargin{I+1};
          case 'XTickL'
 	     XTickL = varargin{I+1};
          case 'YTickL'
 	     YTickL = varargin{I+1};
          case 'FontS'
 	     FontS = varargin{I+1};
          case 'XScale'
 	     XScale = varargin{I+1};
          case 'YScale'
 	     YScale = varargin{I+1};
          otherwise
	     error('Unknown keyword');
         end
      end
   else
      error('Optional arguments should given as keyword, value');
   end
else
   error('Illegal number of input arguments');
end








switch MoveFoc
 case 1
    %--- move focus to subplot # ---
    H    = get(gcf,'Children');
    Ptot = length(H);
    M    = Ptot - M + 1; 
    set(gcf,'CurrentAxes',H(M));

 case 0
    %--- open subplots ---

    Xmin   = Min(1);
    Ymin   = Min(2);
    Xmax   = Max(1);
    Ymax   = Max(2);
    Xgap   = Gap(1);
    Ygap   = Gap(2);
    
    
    Xsize  = (Xmax - Xmin)./N;
    Ysize  = (Ymax - Ymin)./M;
    
    Xbox   = Xsize - Xgap;
    Ybox   = Ysize - Ygap;
    
    
    Ptot = M.*N;
    
    for Pi=1:1:Ptot,
       Row = ceil(Pi./N);
       Col = Pi - (Row - 1)*N;
    
       Xstart = Xmin + Xsize.*(Col - 1);
       Ystart = Ymax - Ysize.*Row;
    
       subplot(M,N,Pi);
       hold on;
       set(gca,'position',[Xstart,Ystart,Xbox,Ybox]);
       set(gca,'FontSize',FontS); 

       box on;

       switch XTickL
        case 'Margin'
           if (Row~=M),
              %--- erase XTickLabel ---
              set(gca,'XTickLabel',[]);
           end
        case 'All'
           % do nothing
        case 'None'
           set(gca,'XTickLabel',[]);
        otherwise
           error('Unknown XTickL option');
       end

       switch YTickL
        case 'Margin'
           if (Col~=1),
              %--- erase YTickLabel ---
              set(gca,'YTickLabel',[]);
           end    
        case 'All'
           % do nothing
        case 'None'
           set(gca,'YTickLabel',[]);
        otherwise
           error('Unknown XTickL option');
       end

       switch XScale
        case 'linear'
           set(gca,'XScale','linear');
        case 'log'
           set(gca,'XScale','log');
        otherwise
  	   error('Unknown XScale option');
       end

       switch YScale
        case 'linear'
           set(gca,'YScale','linear');
        case 'log'
           set(gca,'YScale','log');
        otherwise
  	   error('Unknown YScale option');
       end

    end

 otherwise
    error('Unknown MoveFoc option');
end
