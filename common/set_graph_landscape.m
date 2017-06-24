set(fig,'PaperOrientation','landscape');
set(0,'defaultfigurepaperposition',[.15 .15 8 11]);
margin = .15; % may need to be larger depending on PaperUnits 
   pSize = get(gcf, 'PaperSize'); 
   ppos(1) = margin; 
   ppos(2) = margin; 
   ppos(3) = pSize(1) - margin; 
   ppos(4) = pSize(2) - margin; 
   %tell MATLAB where to place the figure on the page 
   set(fig, 'PaperPosition', ppos); 

  fp = fillPage(gcf, 'margins', [0 0 0 0]);
