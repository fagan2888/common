function subplot1c(Mat,Head,varargin);
%-------------------------------------------------------------------------
% subplot1c function      An improved subplot function, for graphical
%                       display of correlations matrix.
% Input  : - If multi-column matrix is given, then for each pairs of
%            columns (i,j), plot a graph in position i,j in the
%            subplot1 area.
%            If single parameter is given, then this is the
%            subplot-number for which to move focus.
%          - Cell array of columns header. If empty matrix then no
%            labels are plotted.
%          * variable number of parameters
%            (in pairs: ...,Keywoard, Value,...)
%            - 'Min'    : X, Y lower position of lowest subplot,
%                        default is [0.10 0.10].
%            - 'Min'    : X, Y largest position of highest subplot,
%                        default is [0.95 0.95].
%            - 'Gap'    : X,Y gaps between subplots,
%                        default is [0.01 0.01].
%            - 'XTickL' : x ticks labels option,
%                        'Margin' : plot only XTickLabels in the
%                                   subplot of the lowest axes (defailt).
%                        'All'    : plot XTickLabels in all subplots.
%                        'None'   : don't plot XTickLabels in subplots.
%            - 'YTickL' : y ticks labels option,
%                        'Margin' : plot only YTickLabels in the
%                                   subplot of the single-left axes (defailt).
%                        'All'    : plot YTickLabels in all subplots.
%                        'None'   : don't plot YTickLabels in subplots.
%            - 'FontS'  : axis font size, default is 10.
%            - 'Symbol' : plot symbol, default is '.'
%            - 'MarkerFaceC' : marker face colr, default is [0 0 0].
  % See also : subplot1.m
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
SymbolDef   = '.';
MarkerFaceCDef = [0 0 0];

% set default parameters
Min    = MinDef;
Max    = MaxDef;
Gap    = GapDef;
XTickL = XTickLDef;
YTickL = YTickLDef;
FontS  = FontSDef;
Symbol = SymbolDef;
MarkerFaceC = MarkerFaceCDef;



N      = size(Mat,2);
M      = N;

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
          case 'Symbol'
 	     Symbold = varargin{I+1};
          case 'MarkerFaceC'
 	     MarkerFaceC = varargin{I+1};
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

       if (Row>Col),
          % do not plot
       else
          Xstart = Xmin + Xsize.*(Col - 1);
          Ystart = Ymax - Ysize.*Row;
    
          subplot(M,N,Pi);
          hold on;
          set(gca,'position',[Xstart,Ystart,Xbox,Ybox]);
          set(gca,'FontSize',FontS); 

          box on;

          plot(Mat(:,Row),Mat(:,Col),Symbol,'MarkerFaceColor',MarkerFaceC,'MarkerEdgeColor',MarkerFaceC);



          if (isempty(Head)==0),
	     if (Row==Col),
	        H = xlabel(Head{Row});
                set(H,'FontSize',FontS);
	        H = ylabel(Head{Row});
                set(H,'FontSize',FontS);
             end
          end


          switch XTickL
           case 'Margin'
              if (Row~=Col),
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
              if (Col~=Row),
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
       end
    end

 otherwise
    error('Unknown MoveFoc option');
end
