function spreview(sel)
%SPREVIEW GUI application to preview styled text objects.
%	SPREVIEW will create a new figure which contains an edit box in
%	which styled text can be typed and an axes to display the resulting
%	styled text object.  This can be used to construct styled text
%	objects, especially complicated ones.
%
%	SPREVIEW(STYLEDTEXT) uses the styled text in STYLEDTEXT as the
%	initial contents of the edit box.
%
%	See also STEXT.

%	Requires functions STEXT and FIXSTEXT.
%	Requires MATLAB Version 4.2 or greater.

%	Version 3.2b, 10 March 1997
%	Part of the Styled Text Toolbox
%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%	schwarz@kodak.com

if nargin == 0
	sel = 0;
	s = '';
elseif nargin == 1
	if isstr(sel)
		s = sel;
		sel = 0;
	end
end

if sel == 0
	this = mfilename;
	fig = figure('Number','off','Name',this);
	set(fig,'Units','pixels')
	figpos = get(fig,'Position');
	
	framePos = [16,16,figpos(3)-32,68];
	editPos = [20,20,figpos(3)-40,40];
	textPos = [20,60,figpos(3)-40,20];
	makePos = [figpos(3)-150,62,40,20];
	clearPos = [figpos(3)-106,62,40,20];
	savePos = [figpos(3)-62,62,40,20];
	axPos = [17,92,figpos(3)-32,figpos(4)-98];
	
	hf = uicontrol('Style','frame',...
			'Units','pixels',...
			'Position',framePos);
	he = uicontrol('Style','edit',...
			'Units','pixels',...
			'Position',editPos,...
			'String',s,...
			'Horiz','left',...
			'CallBack',[this,'(1)']);
	ht = uicontrol('Style','text',...
			'Units','pixels',...
			'Position',textPos,...
			'String','Type styled text here and press Make or RETURN:',...
			'Horiz','left');
	hm = uicontrol('Style','pushbutton',...
			'Units','pixels',...
			'Position',makePos,...
			'String','Make',...
			'CallBack',[this,'(1)']);
	hc = uicontrol('Style','pushbutton',...
			'Units','pixels',...
			'Position',clearPos,...
			'String','Clear',...
			'CallBack','cla');
	hs = uicontrol('Style','pushbutton',...
			'Units','pixels',...
			'Position',savePos,...
			'String','Save',...
			'CallBack','get(findobj(gcf,''Style'',''edit''),''String'')');
	ax = axes('Units','pixels',...
			'Position',axPos,...
			'XTick',[],'YTick',[],...
			'Box','on',...
			'XLim',[0 1],'YLim',[0 1]);
	set(fig,'UserData',[hf he ht hm hc hs ax])
	eval(['set(fig,''ResizeFcn'',''',this,'(2)'')'],'')
	
% Pressed RETURN or Make, create new styled text.
elseif sel == 1
	fig = gcf;
	cla
	refresh
	h = get(fig,'UserData');
	str = get(h(2),'String');
	stext(.5,.5,str,'Horiz','center');

% Resizing the figure.
elseif sel == 2
	fig = gcf;
	figpos = get(fig,'Position');
	
	framePos = [16,16,figpos(3)-32,68];
	editPos = [20,20,figpos(3)-40,40];
	textPos = [20,60,figpos(3)-40,20];
	makePos = [figpos(3)-150,62,40,20];
	clearPos = [figpos(3)-106,62,40,20];
	savePos = [figpos(3)-62,62,40,20];
	axPos = [17,92,figpos(3)-32,figpos(4)-98];
	
	h = get(fig,'UserData');
	
	set(h(1),'Position',framePos)
	set(h(2),'Position',editPos)
	set(h(3),'Position',textPos)
	set(h(4),'Position',makePos)
	set(h(5),'Position',clearPos)
	set(h(6),'Position',savePos)
	set(h(7),'Position',axPos)
	
	fixstext
end
