set(0,'PaperOrientation','portrait');
set(0,'defaultfigurepaperposition',[.25 .25 8 10]);
set(0,'defaultfigurepapertytpe','A3');
margin = .1; % may need to be larger depending on PaperUnits 
   pSize = get(gcf, 'PaperSize'); 
   ppos(1) = margin; 
   ppos(2) = margin; 
   ppos(3) = pSize(1) - margin; 
   ppos(4) = pSize(2) - margin; 
   %tell MATLAB where to place the figure on the page 
   set(0, 'PaperPosition', ppos); 
