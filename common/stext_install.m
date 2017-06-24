% Installer: "stext_install.m"
% Created: 04-Oct-2001 15:52:58.

function bund_driver

% bund_driver -- Driver for "bund" bundles.
%  bund_driver (no arguments) contains Matlab commands
%   to inflate the instructions and files that are
%   encoded into the "bund_data" function of this package.
 
% Copyright (C) 2001 Dr. Charles R. Denham, ZYDECO.
%  All Rights Reserved.
%   Disclosure without explicit written consent from the
%    copyright owner does not constitute publication.
 
% Version of 14-Jun-2001 10:54:16.
% Updated    03-Aug-2001 13:43:17.

help(mfilename)

BINARY_TAG = '?';

CR = char(13);
LF = char(10);

comp = upper(computer);
if any(findstr(comp, 'PCWIN'))   % Windows.
	NL = [CR LF];
elseif any(findstr(comp, 'MAC2'))   % Macintosh.
	NL = CR;
else   % Unix.
	NL = LF;
end

c = zeros(1, 256);
c(abs('0'):abs('9')) = 0:9;
c(abs('a'):abs('f')) = 10:15;

disp([' '])
disp([' ## This installer is ready to expand its contents,'])
disp([' ## starting in the present directory: "' pwd '"'])
disp([' ## To abort, execute an interruption now.'])
disp([' ## Otherwise, to continue, press any key.'])
disp([' '])

try
	pause
catch
	disp([' ## Installation interrupted.'])
	disp([' '])
	return
end

tic

w = which(mfilename);

fin = fopen(w, 'r');
if fin < 0, return, end

found = ~~0;
while ~found
	s = fgetl(fin);
	if isequal(s, -1)
		fclose(fin);
		return
	end
	s = strrep(s, LF, '');  % Not necessary?
	s = strrep(s, CR, '');  % Not necessary?
	if isequal(s, 'function bund_data')
		found = ~~1;
	end
end

fout = -1;

done = ~~0;
while ~done
	s = fgetl(fin);
	if isequal(s, -1)
		fclose(fin);
		return
	end
	if length(s) > 0
		if s(1) ~= '%'
			f = findstr(s, 'bund_setdir');
			if any(f)
				theDir = eval(strrep(s, 'bund_setdir', ''));
				status = mkdir(theDir);
				switch status
				case 1
					disp([' ## Directory created: "' theDir '"'])
				case 2
					disp([' ## Directory exists: "' theDir '"'])
				otherwise
					error([' ## Error while making new directory.'])
				end
				
				try
					cd(theDir)
				catch
					error([' ## Unable to go to directory: "' theDir '"'])
				end
			else
				try
					eval(s);
				catch
					error([' ## Unable to evaluate: "' s '"'])
				end
			end
		elseif length(s) > 1 & s(2) == BINARY_TAG
			hx = double(s(3:end));   % Assume hex data.
			bin = 16*c(hx(1:2:end)) + c(hx(2:2:end));
			fwrite(fout, bin, 'uchar');
		else
			fprintf(fout, '%s', s(2:end));
			fprintf(fout, NL);
		end
	end
end

fclose(fin);

disp([' ## Elapsed time: ' num2str(fix(10*toc)/10) ' s.'])

function bund_data
bund_setdir('stext')

disp(' ## Installing: "changes.txt" (text)')
fout = fopen('changes.txt', 'w');
%Styled Text Toolbox
%Version 3.1, 10 June 1996
%Copyright 1995-1996 by Douglas M. Schwarz.  All rights reserved.
%schwarz@kodak.com
%
%
%Changes in Version 3.2
%
%
%1. MATLAB 5 Compatibility
%
%The Styled Text Toolbox is now compatible with both MATLAB 5 and MATLAB 4.
%Even though MATLAB 5 has a built-in capability which is similar, I have
%chosen to continue development of my toolbox as it has several features
%not included in the built-in functions:
%
%* FontSize and Color can be changed mid-string
%* Simulated italic (slanted) Greek letters possible
%* Additional characters available
%* Diacritics above any character
%* Fractions, roots, summations and products
%* Kerned output using kern pairs from Adobe Font Metric files
%* Styled text text boxes
%* Fine adjustment of character positions possible
%
%The same m-files should work in both versions of MATLAB and on any platform
%except for the stfm.mat file (which is created the first time stext is run)
%which contains some platform-specific information.
%
%
%2. STFIXPS fixed
%
%STFIXPS did not work properly in some situations involving rotated or
%colored text.  This has been fixed.  Also, the new version is somewhat
%faster than the old one.  For even greater speed, I am distibuting a MEX
%version contributed by Erik Johnson (source and Macintosh binaries).
%Thank-you Erik!
%
%
%3.  Simulated Symbol-Bold
%
%Bold Symbol characters are now produced by placing multiple, slightly
%shifted copies of the character (sort of a "poor man's bold").  This is
%because there is no bold version of the Symbol font.
%
%
%4.  New commands
%
%I have changed the definition of \slash.  Previously, it just produced
%a slash symbol.  Now it takes two arguments and can be used to make
%nice fractions with a slightly raised numerator and with both numerator
%and denominator somewhat smaller than normal.  For example, \slash{1}{2}
%makes a nice version of 1/2.  I have also added the command \parallel
%which is the same as \Vert.
%
%
%5.  New version of stfm.txt.
%
%The font metrics file has changed again, slightly.  I have added some
%data which will improve the VerticalAlignment.  Be sure to delete the
%old stfm.mat file before using this new version.
%
%
%6.  New function
%
%I am including an m-file version of strncmp for use with MATLAB 4.  I
%needed the built-in strncmp in MATLAB 5 and to make the same m-file
%work in version 4 I had to provide this function.
%
%
%
%Changes in Version 3.1
%
%
%1. Bug Fixes
%
%I fixed several bugs which could leave the screen in a messy state if an
%error was made in specifying the styled text.  Also, on some platforms there
%was the possibility of a visible extra character when italic Symbol font was
%used.  This character has a special purpose and it has been replaced with
%one that does not show up on screen.  Several other minor bugs have been
%eliminated.
%
%
%2. SLEGEND and STEXTBOX modified
%
%Based on some user feedback, I have modified SLEGEND and STEXTBOX so that
%some of the internal parameters can be changed without modifying the
%m-files.  It is now possible to specify property/value pairs just like with
%other objects.  I have also improved the method for calculating the line
%spacing.
%
%
%3. Font metrics
%
%The font metric information is now contained in a single text file for all
%platforms: stfm.txt.  This one file now has the character widths and
%kerning data for all of the supported PostScript fonts.  It also contains
%the three Roman font encoding vectors I know about: MacEncoding,
%WindowsLatin1Encoding (new), and ISOLatin1Encoding.  Previously, I had been
%led to believe that the encoding used by Windows was a superset of
%ISOLatin1Encoding, but I have recently learned that this is not quite the
%case.  As a result, Windows users would not have been able to use accents
%correctly.  This new encoding vector fixes this except that the accents
%\breve, \dot and \check and the \ii character (dotless i) are not included
%in the encoding and cannot be used.  If any other encoding vectors are
%discovered to be in use the new system will allow them to be added and used
%fairly easily; contact me for details.
%
%
%4. New function readstfm and new procedure for saving stfm.mat
%
%The procedure for extracting the font metric information and encodings from
%stfm.txt is complicated enough that I put it in a separate m-file.  This
%function is called by stext the first time stext is run.  The font metrics
%are then saved in a MAT-file (stfm.mat) for quicker access in the future.
%If you don't have write permission in the stextfun directory then the file
%is saved in the current directory and a message is displayed suggesting
%that you have your system administrator move that file to the stextfun
%directory.
%
%
%
%
%Changes in Version 3.0
%
%
%1. Command Parsing
%
%Parsing of commands is more robust and more LaTeX-like.  There are now three
%categories of commands: those with all letters (e.g., \alpha), those with
%all numbers (e.g., \12) and those consisting of a single special character
%(e.g., \+).  Commands are terminated by any character that can be determined
%not to be part of the command itself.  If the next character is in the same
%category as the command characters then a single space should be inserted as
%the termination character.  This space will not appear in the output.
%Examples:
%
%'\alpha a' will produce no space between the alpha and the a.  The space is
%necessary to terminate the \alpha command, but it gets swallowed.  Another
%way to achieve the same result is with '\alpha{}a'.
%
%'\alpha  a' will produce a single space between the alpha and the a.  The
%first space gets swallowed as above, but the second one will appear. Another
%way to get the same result is with '\alpha\ a', where the '\ ' is a standard
%space command.
%
%'\alpha1' will be parsed without error and there will be no space between
%the alpha and the 1.  Of course, this can also be done with '\alpha{}1'.
%	
%'\alpha 1' will have a single space between the alpha and the 1.
%
%'\+=' will be parsed without error and there will be no space between the
%'+' (which will be made with the Symbol font) and the '=' (in the current
%font).
%
%
%2. Commands with two arguments
%
%Commands with two arguments have a different syntax.  Previously you would
%use '\int{a,b}' to make an integral with lower limit 'a' and upper limit
%'b'.  The new syntax is '\int{a}{b}'.  Commands affected: \int, \sum, \prod.
%
%
%3. New commands
%
%\frac{x}{y} to make the fraction x over y
%
%\sqrt{x} to make square root of x
%
%\root{n}{x} to make nth root of x
%
%\AA to make angstrom symbol ('A' with little circle above it)
%
%\ii to make a dotless 'i'
%
%\pushx will push the current x-position onto a stack
%
%\popx will pop the stack so the next character position will revert to a
%    previous location
%
%\swapx will swap the top two stack items
%
%ASCII codes can be inserted with the \# command, e.g., 'a\#{65}b' is
%identical to 'a{}Ab' since the ASCII code for 'A' is 65 (decimal).
%
%'\/'  italic correction
%'\,'  thin space
%'\:'  medium space
%'\;'  thick space
%'\ '  word space
%
%
%4. New functions
%
%slegend      - Styled text legends.
%stextbox     - Styled text multi-line box.
%stfixps      - Modifies PS files to simulate Symbol-Oblique font.
%spreview     - GUI application to help build styled text objects.
%
%
%5. Font metrics
%
%The font metric information is now distributed as text files eliminating the
%need to download them in binary mode.  The first time stext is run they are
%loaded in and then saved as MAT-files for quicker access in the future.
%
%
%6. Rotation
%
%Rotation of styled text is no longer restricted to integral multiples of 90
%degrees.
%
%
%7. Printing
%
%The printsto function has been upgraded to handle axes with a fixed aspect
%ratio (such as result from "axis square").
fclose(fout);

disp(' ## Installing: "cmdmatch.m" (text)')
fout = fopen('cmdmatch.m', 'w');
%function m = cmdmatch(a,b)
%%CMDMATCH String matching.
%%	CMDMATCH(A,B) returns 1 if B matches the first length(B) characters
%%	of A and 0 otherwise.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%nb = length(b);
%
%if length(a) >= nb
%	m = all(a(1:nb) == b);
%else
%	m = 0;
%end
fclose(fout);

disp(' ## Installing: "Contents.m" (text)')
fout = fopen('Contents.m', 'w');
%% Styled Text Toolbox.
%% Version 3.2b, 10 March 1997
%%
%% General.
%%   stext        - Add styled text to the current plot.
%%   setstext     - Set styled text object properties.
%%   getstext     - Get styled text object properties.
%%   delstext     - Delete a styled text object.
%%   fixstext     - Fix position of styled text objects.
%%   printsto     - Print or save graph containing styled text objects.
%%   stitle       - Styled text plot titles.
%%   sxlabel      - X-axis styled text labels.
%%   sylabel      - Y-axis styled text labels.
%%   szlabel      - Z-axis styled text labels for 3-D plots.
%%   slegend      - Styled text legends.
%%   stextbox     - Styled text multi-line box.
%%   stfixps      - Modifies PS files to simulate Symbol-Oblique font.
%%   addlatin     - UNIX script to add ISOLatin1Encoding to PostScript files.
%%
%% Demo.
%%   stodemo      - Demonstrates some of the capabilities of stext.
%%   spreview     - GUI application to help build styled text objects.
%%
%% Utility functions (used internally).
%%   cmdmatch     - String matching for commands.
%%   move1sto     - Move one styled text object.
%%   getcargs     - Get command arguments.
%%   readstfm     - Read styled text font metrics data file.
%%   strncmp      - String comparison, used only in MATLAB 4.
%%
%% Font Metric data.
%%   stfm.txt     - Font metric and encoding information.
%
%% Copyright 1995-1997 by Douglas M. Schwarz.
%% schwarz@kodak.com
fclose(fout);

disp(' ## Installing: "delstext.m" (text)')
fout = fopen('delstext.m', 'w');
%function delstext(hh)
%%DELSTEXT Delete styled text objects.
%%	DELSTEXT(H) deletes the styled text object with handle H.  Nothing
%%	is deleted if H is not a valid handle to a styled text object. H
%%	can also be a vector of handles.
%%
%%	See also STEXT.
%
%%	Requires function CMDMATCH.
%%	Requires MATLAB Version 4.2 or greater.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%for h = hh(:)'
%	% First, check to see if value is a valid handle.
%	if eval('isstr(get(h,''Type''))','0')
%		% Check to see if handle is a styled text object.
%		if cmdmatch(get(h,'Tag'),'stext')
%			% Get handles to text objects and delete them.
%			userData = get(h,'UserData');
%			objList = userData(4:length(userData));
%			delete(objList)
%			delete(h)
%		end
%	end
%end
fclose(fout);

disp(' ## Installing: "fixstext.m" (text)')
fout = fopen('fixstext.m', 'w');
%function fixstext
%%FIXSTEXT Reposition styled text objects after axes modification.
%%	FIXSTEXT repositions all styled text objects in the current figure.
%%	
%%	See also STEXT, SXLABEL, SYLABEL, SZLABEL, STITLE, DELSTEXT,
%%	PRINTSTO, SETSTEXT.
%
%%	Requires function MOVE1STO.
%%	Requires MATLAB Version 4.2 or greater.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%% Determine current figure and axes.
%fig = get(0,'CurrentFigure');
%figUnits = get(fig,'Units');
%set(fig,'Units','points')
%figPosPts = get(fig,'Position');
%set(fig,'Units',figUnits)
%ax = get(fig,'CurrentAxes');
%
%% Find all stext objects.
%anchors = findobj(fig,'Tag','stext');
%n = length(anchors);
%
%% Adjust each stext object.
%for i = 1:n
%	move1sto(anchors(i))
%end
%
%
%% Adjust title.
%stitleH = findobj(fig,'Tag','stext title');
%n = length(stitleH);
%for i = 1:n
%	move1sto(stitleH(i))
%end
%
%
%% Fix all styled text labels by regenerating them.
%xlabelH = findobj(fig,'Tag','stext xlabel');
%n = length(xlabelH);
%for i = 1:n
%	set(fig,'CurrentAxes',get(xlabelH(i),'Parent'))
%	str = get(xlabelH(i),'String');
%	sxlabel(str)
%end
%
%ylabelH = findobj(fig,'Tag','stext ylabel');
%n = length(ylabelH);
%for i = 1:n
%	set(fig,'CurrentAxes',get(ylabelH(i),'Parent'))
%	str = get(ylabelH(i),'String');
%	sylabel(str)
%end
%
%zlabelH = findobj(fig,'Tag','stext zlabel');
%n = length(zlabelH);
%for i = 1:n
%	set(fig,'CurrentAxes',get(zlabelH(i),'Parent'))
%	str = get(zlabelH(i),'String');
%	szlabel(str)
%end
%
%
%% Find all slegend and stextbox objects.
%legends = [findobj(fig,'Tag','slegend');...
%		findobj(fig,'Tag','slegend movable')];
%nleg = length(legends);
%
%% Shift the legends so they will print correctly.
%for i = 1:nleg
%	newPos = get(legends(i),'Position');
%	origLegPos = newPos;
%	userData = get(legends(i),'UserData');
%	xy = userData(1:2);
%	ref = userData(3:4);
%	newPos(1:2) = figPosPts(3:4).*xy - ref.*origLegPos(3:4);
%	set(legends(i),'Position',newPos)
%end
%
%
%% Return to original current axes.
%set(fig,'CurrentAxes',ax)
fclose(fout);

disp(' ## Installing: "getcargs.m" (text)')
fout = fopen('getcargs.m', 'w');
%function [arg,str] = getcargs(str)
%%GETCARGS Get arguments for stext commands.
%%	[ARG,STROUT] = GETCARGS(STR) parses STR to extract a part enclosed
%%	in curly braces and the remainder of the string.
%%		Example:
%%			>>STR = '{hello}there'
%%			>>[A,STROUT] = GETCARGS(STR)
%%			A =
%%			hello
%%			STROUT =
%%			there
%%
%%	See also STEXT.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%i = cumsum( (str == '{') - (str == '}') );
%if i(1) ~= 1 | ~any(i == 0)
%	error('Command argument not found.')
%end
%firstZero = min(find(i == 0));
%arg = str(2:(firstZero - 1));
%str(1:firstZero) = [];
fclose(fout);

disp(' ## Installing: "getstext.m" (text)')
fout = fopen('getstext.m', 'w');
%function value = getstext(anchor,property)
%%GETSTEXT Get property values for styled text objects.
%%	GETSTEXT(H,PROPERTY) returns the value of the named property for the
%%	styled text object with handle H.
%%	
%%	GETSTEXT(H) displays all property names and values for the styled
%%	text object with handle H.
%%
%%	See also STEXT, GET.
%
%%	Requires function CMDMATCH.
%%	Requires MATLAB Version 4.2 or greater.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%if ~cmdmatch(get(anchor,'Tag'),'stext')
%	error('Not a styled text object.')
%end
%
%if nargin == 2
%	property = lower(property);
%	
%	if cmdmatch('color',property)
%		error('Invalid object property.')
%	
%	elseif cmdmatch('fontangle',property)
%		error('Invalid object property.')
%	
%	elseif cmdmatch('fontname',property)
%		error('Invalid object property.')
%	
%	elseif cmdmatch('fontsize',property)
%		error('Invalid object property.')
%	
%	elseif cmdmatch('fontweight',property)
%		error('Invalid object property.')
%	
%	elseif cmdmatch('visible',property)
%		objList = get(anchor,'UserData');
%		value = get(objList(4),'Visible');
%	
%	elseif cmdmatch('extent',property)
%		objList = get(anchor,'UserData');
%		objList(1:3) = [];
%		numObjects = length(objList);
%		extents = zeros(numObjects,4);
%		anchorUnits = get(anchor,'Units');
%		for i = 1:numObjects
%			objUnits = get(objList(i),'Units');
%			objPos = get(objList(i),'Position');
%			set(objList(i),'Units',anchorUnits)
%			extents(i,:) = get(objList(i),'Extent');
%			set(objList(i),'Units',objUnits,'Position',objPos)
%		end
%		lbrt = [extents(:,1:2),extents(:,1:2) + extents(:,3:4)];
%		lbrtAll = [min(lbrt(:,1)),min(lbrt(:,2)),max(lbrt(:,3)),max(lbrt(:,4))];
%		value = [lbrtAll(1:2),lbrtAll(3:4) - lbrtAll(1:2)];
%	
%	else
%		value = get(anchor,property);
%	end
%else
%	fprintf(1,'\tEraseMode = %s\n',get(anchor,'EraseMode'))
%	fprintf(1,'\tExtent = [%g %g %g %g]\n',getstext(anchor,'Extent'))
%	fprintf(1,'\tHorizontalAlignment = %s\n',get(anchor,'HorizontalAlignment'))
%	fprintf(1,'\tPosition = [%g %g %g]\n',get(anchor,'Position'))
%	fprintf(1,'\tRotation = [%g]\n',get(anchor,'Rotation'))
%	fprintf(1,'\tString = %s\n',get(anchor,'String'))
%	fprintf(1,'\tUnits = %s\n',get(anchor,'Units'))
%	fprintf(1,'\tVerticalAlignment = %s\n',get(anchor,'VerticalAlignment'))
%	fprintf(1,'\n')
%	fprintf(1,'\tButtonDownFcn = %s\n',get(anchor,'ButtonDownFcn'))
%	fprintf(1,'\tChildren = []\n')
%	fprintf(1,'\tClipping = %s\n',get(anchor,'Clipping'))
%	fprintf(1,'\tInterruptible = %s\n',get(anchor,'Interruptible'))
%	fprintf(1,'\tParent = [%g]\n',get(anchor,'Parent'))
%	objList = get(anchor,'UserData');
%	fprintf(1,'\tVisible = %s\n',get(objList(4),'Visible'))
%end
fclose(fout);

disp(' ## Installing: "move1sto.m" (text)')
fout = fopen('move1sto.m', 'w');
%function move1sto(anchor,delta)
%%MOVE1STO Move one styled text object.
%%	MOVE1STO(H,DXY) moves the styled text object H by DXY(1) and DXY(2)
%%	points in the X and Y directions respectively.
%%	
%%	MOVE1STO(H) moves the styled text object H to its correct location.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%userData = get(anchor,'UserData');
%objList = userData(4:length(userData));
%
%% Determine correct location based on location of anchor.
%if nargin == 1
%	anchorUnits = get(anchor,'Units');
%	anchorPos = get(anchor,'Position');
%	x0 = userData(2);
%	y0 = userData(3);
%	
%	set(anchor,'Units','points')
%	newPos = get(anchor,'Position');
%	x1 = newPos(1);
%	y1 = newPos(2);
%	delta = [x1 - x0,y1 - y0];
%	userData(2) = x1;
%	userData(3) = y1;
%	set(anchor,'Units',anchorUnits,'Position',anchorPos,...
%			'UserData',userData,'Visible','off')
%end
%
%% Set new positions.
%for obj = objList
%	set(obj,'Units','points')
%	pos = get(obj,'Position');
%	pos(1:length(delta)) = pos(1:length(delta)) + delta;
%	set(obj,'Position',pos)
%end
fclose(fout);

disp(' ## Installing: "printsto.m" (text)')
fout = fopen('printsto.m', 'w');
%function printsto(arg1,arg2,arg3,arg4,arg5)
%%PRINTSTO Print or save graph containing styled text objects.
%%	PRINTSTO has exactly the same syntax as PRINT.  It is required for
%%	printing or saving figures which contain styled text objects.
%%
%%	See also PRINT, STEXT, SXLABEL, SYLABEL, SZLABEL, STITLE, SLEGEND,
%%	STEXTBOX, DELSTEXT, SETSTEXT, FIXSTEXT.
%
%%	Requires function MOVE1STO.
%%	Requires MATLAB Version 4.2 or greater.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%% Check arguments.
%if nargin > 5
%	error('Too many input arguments.')
%end
%
%% Determine which figure we want.
%curFig = gcf;
%curAxes = get(curFig,'CurrentAxes');
%thisFig = curFig;
%for i = 1:nargin
%	arg = eval(sprintf('arg%d',i));
%	[tempFig,count] = sscanf(arg,'-f%d');
%	if count
%		thisFig = tempFig;
%		break
%	end
%end
%thisAxes = get(thisFig,'CurrentAxes');
%
%% Compute magnification in X and Y directions for each axes.
%% Fudge factors of 1.00217 and 1.00333 were determined by trial and error.
%axesList = findobj(thisFig,'Type','axes');
%allAnchors = [];
%allDeltas = [];
%allLabelAnchors = [];
%allLabelDeltas = [];
%
%paperUnits = get(thisFig,'PaperUnits');
%paperPosOrig = get(thisFig,'PaperPosition');
%set(thisFig,'PaperUnits','points')
%paperPos = get(thisFig,'PaperPosition');
%set(thisFig,'PaperUnits',paperUnits,'PaperPosition',paperPosOrig)
%ver5 = cmdmatch(version,'5');
%
%for thisAxes = axesList'
%	if ver5
%		if strcmp(get(thisAxes,'PlotBoxAspectRatioMode'),'auto') & ...
%				strcmp(get(thisAxes,'DataAspectRatioMode'),'auto') & ...
%				strcmp(get(thisAxes,'CameraViewAngleMode'),'auto')
%			aspect = nan;
%		else
%			aspect = get(thisAxes,'PlotBoxAspectRatio');
%			aspect = aspect(1)/aspect(2);
%		end
%	else
%		aspect = get(thisAxes,'AspectRatio');
%		aspect = aspect(1);
%	end
%
%	% Compute magnification factors.
%	axUnits = get(thisAxes,'Units');
%	axPosOrig = get(thisAxes,'Position');
%	set(thisAxes,'Units','points');
%	axPos = get(thisAxes,'Position');
%	set(thisAxes,'Units',axUnits,'Position',axPosOrig)
%	ws = axPos(3);
%	hs = axPos(4);
%	if strcmp(axUnits,'normalized')
%		axPosNorm = get(thisAxes,'Position');
%		wp = paperPos(3)*axPosNorm(3);
%		hp = paperPos(4)*axPosNorm(4);
%		if ~isnan(aspect)
%			if aspect > ws/hs
%				hs = ws/aspect;
%			else
%				ws = hs*aspect;
%			end
%			if aspect > wp/hp
%				hp = wp/aspect;
%			else
%				wp = hp*aspect;
%			end
%		end
%		magX = 1.00217*wp/ws;
%		magY = 1.00333*hp/hs;
%	else
%		magX = 1;
%		magY = 1;
%	end
%
%	% Find all plain and title stext objects defined in relative units.
%	anchors = [findobj(thisAxes,'Tag','stext','Units','normalized');...
%			findobj(thisAxes,'Tag','stext','Units','data');...
%			findobj(thisAxes,'Tag','stext title','Units','normalized');...
%			findobj(thisAxes,'Tag','stext title','Units','data')];
%	n = length(anchors);
%	delta = zeros(n,2);
%	
%	% Shift the objects so they will print correctly.
%	for i = 1:n
%		userData = get(anchors(i),'UserData');
%		origPos = userData(2:3);
%		if strcmp(get(anchors(i),'Units'),'data')
%			printPos = origPos.*[magX,magY] + [0.471 0.477];
%		else
%			printPos = origPos.*[magX,magY];
%		end
%		delta(i,:) = printPos - origPos;
%		move1sto(anchors(i),delta(i,:))
%	end
%	allAnchors = [allAnchors;anchors];
%	allDeltas = [allDeltas;delta];
%
%	% Find all label stext objects.
%	labelAnchors = [findobj(thisAxes,'Tag','stext xlabel');...
%			findobj(thisAxes,'Tag','stext ylabel');...
%			findobj(thisAxes,'Tag','stext zlabel')];
%	nl = length(labelAnchors);
%	labelDelta = zeros(nl,2);
%	
%	% Shift all label stext objects so they will print correctly.
%	tickDirFactor = 10*strcmp(get(thisAxes,'TickDir'),'out');
%	for i = 1:nl
%		userData = get(labelAnchors(i),'UserData');
%		origPos = userData(2:3);
%		printPos = origPos.*[magX,magY] + [0.471 0.477];
%		
%		id = userData(1);
%		labH = get(thisAxes,['W'+id,'Label']);
%		hor = get(labH,'HorizontalAlignment');
%		if strcmp(hor,'center')
%			rot = get(labH,'Rotation');
%			labU = get(labH,'Units');
%			set(labH,'Units','points')
%			labpos = get(labH,'Position');
%			set(labH,'Units',labU)
%			if rot == 0
%				beyond = labpos(2) + tickDirFactor;
%				printPos(2) = (origPos(2) - beyond)*magY + beyond;
%			elseif rot == 90
%				beyond = labpos(1) + tickDirFactor;
%				printPos(1) = (origPos(1) - beyond)*magX + beyond;
%			elseif rot == -90
%				beyond = labpos(1) - axPos(3) - tickDirFactor;
%				printPos(1) = (origPos(1) - beyond)*magX + beyond;
%			end
%		end
%	
%		labelDelta(i,:) = printPos - origPos;
%		move1sto(labelAnchors(i),labelDelta(i,:))
%	end
%	allLabelAnchors = [allLabelAnchors;labelAnchors];
%	allLabelDeltas = [allLabelDeltas;labelDelta];
%
%end
%
%
%% Find all slegend objects.
%legends = [findobj(thisFig,'Tag','slegend');...
%		findobj(thisFig,'Tag','slegend movable')];
%nleg = length(legends);
%origLegPos = zeros(nleg,4);
%
%
%% Shift the legends so they will print correctly.
%for i = 1:nleg
%	newPos = get(legends(i),'Position');
%	origLegPos(i,:) = newPos;
%	userData = get(legends(i),'UserData');
%	xy = userData(1:2);
%	ref = userData(3:4);
%	newPos(1:2) = paperPos(3:4).*xy - ref.*origLegPos(i,3:4);
%	set(legends(i),'Position',newPos)
%	set(thisFig,'CurrentAxes',legends(i))
%end
%
%drawnow discard
%
%
%% Execute print command.
%if nargin == 0
%	print
%elseif nargin == 1
%	print(arg1)
%elseif nargin == 2
%	print(arg1,arg2)
%elseif nargin == 3
%	print(arg1,arg2,arg3)
%elseif nargin == 4
%	print(arg1,arg2,arg3,arg4)
%elseif nargin == 5
%	print(arg1,arg2,arg3,arg4,arg5)
%end
%
%
%% Shift all stext objects back to where they were.
%for i = 1:length(allAnchors)
%	move1sto(allAnchors(i),-allDeltas(i,:))
%end
%for i = 1:length(allLabelAnchors)
%	move1sto(allLabelAnchors(i),-allLabelDeltas(i,:))
%end
%for i = 1:nleg
%	set(legends(i),'Position',origLegPos(i,:))
%end
%drawnow discard
%
%set(thisFig,'CurrentAxes',thisAxes)
%set(curFig,'CurrentAxes',curAxes)
fclose(fout);

disp(' ## Installing: "README.txt" (text)')
fout = fopen('README.txt', 'w');
%Styled Text Toolbox
%Version 3.2b, 10 March 1997
%Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%schwarz@kodak.com
%
%___________________________________________________________________________
%
%The most recent version of the Styled Text Toolbox should be available from
%
%    <ftp://ftp.mathworks.com/pub/contrib/graphics/stextfun>
%
%___________________________________________________________________________
%
%Introduction.
%
%The Styled Text Toolbox is a collection of tools which enables the user to
%mix fonts, text styles and mathematical constructs (superscripts,
%subscripts, integrals, special math characters, etc.) in a single styled
%text object.
%
%Features:
%
%* Internal "command language" similar to LaTeX
%* Text properties applicable on a per character basis:  FontName, FontSize,
%      FontWeight, FontAngle, Color
%* Text properties applicable to entire styled text object:  EraseMode,
%      HorizontalAlignment, Position, Rotation, Units, VerticalAlignment,
%      ButtonDownFcn, Clipping, Interruptible, Visible
%* Superscripts and subscripts
%* Greek letters using LaTeX names
%* Simulated italic (slanted) Greek letters possible
%* Many other characters from Symbol font available using LaTeX names
%* Some non-LaTeX characters available
%* Diacritics above any character
%* Fractions, roots, integrals, summations and products
%* Kerned output using kern pairs from Adobe Font Metric files
%* All 35 standard fonts supported (the ones built-in to most PostScript
%      printers), except on Student Edition where New Helvetica Narrow is
%      not supported so as not to exceed 8192 element limit.
%* Styled text xlabels, ylabels, zlabels and titles
%* Styled text legends and text boxes
%* Positions specifiable in 2-D or 3-D coordinates
%* Does not require WYSIWYG mode for correct printing
%* Fine adjustment of character positions possible
%* Syntax nearly the same as that of the built-in text function
%* No hard-coded defaults or assumptions
%* Platform independent
%
%
%The Styled Text Toolbox consists of several m-files which are analogous to
%the MATLAB commands text, set, get, delete, print, title, xlabel, ylabel
%and zlabel.
%
%    stext        - Add styled text to the current plot
%    setstext     - Set styled text object properties
%    getstext     - Get styled text object properties
%    delstext     - Delete a styled text object
%    printsto     - Print or save graph containing styled text objects
%    stitle       - Styled text plot titles
%    sxlabel      - X-axis styled text labels
%    sylabel      - Y-axis styled text labels
%    szlabel      - Z-axis styled text labels for 3-D plots
%
%They are designed to have, as nearly as possible, the same features and
%syntax as their counterparts.  Also included are functions to create
%legends and text boxes, a function to modify PostScript files to slant
%Greek letters, a function to correct the position of styled text objects
%after axes modifications, a demo, a styled text previewer, four utility
%functions (used internally), a UNIX shell script, and a file containing
%font metric information.
%
%    slegend      - Styled text legends
%    stextbox     - Styled text multi-line box
%    stfixps      - Modifies PS files to simulate Symbol-Oblique font
%    fixstext     - Fix position of styled text objects
%    stodemo      - Demonstrates some of the capabilities of stext
%    spreview     - GUI application to help build styled text objects
%
%    cmdmatch     - String matching for commands
%    move1sto     - Move one styled text object
%    getcargs     - Get command arguments
%    readstfm     - Read styled text font metrics data file
%
%    addlatin     - UNIX script to add ISOLatin1Encoding to PostScript files
%
%    stfm.txt     - Font metric information
%
%The Styled Text Toolbox requires at least version 4.2 of MATLAB.
%The Styled Text Toolbox is free, but please read the Important Information
%section at the end of this document.
%
%___________________________________________________________________________
%
%Installation instructions.
%
%The Styled Text Toolbox may be installed anywhere on your search path.  I
%suggest using a directory name of "stextfun".  The font metric information
%file must be located in the same directory as "stext.m".  The first time
%stext is run, a platform-specific MAT-file version of the font metrics is
%created.  If you move the toolbox to a different platform, do not copy this
%file.  By default, the file will be created in the stextfun directory.  If
%you are using a multi-user operating system and you don't have write
%permission in that directory, it will be created in the current directory
%and a message will be displayed suggesting that you should get your system
%administrator to move the file to the stextfun directory.
%
%___________________________________________________________________________
%
%How to use the Styled Text Toolbox.
%
%The basic idea is that commands are embedded in the string you wish to
%display (somewhat like LaTeX).  For example, to create a text object at
%(x,y) with the text "MATLAB is great!" displayed in 18-point Times, you
%could use the command
%
%    text(x,y,'MATLAB is great!','FontName','times','FontSize',18).
%
%Using stext, this becomes
%
%    stext(x,y,'\18\times MATLAB is great!').
%
%However, with stext, you could also put "great" in bold:
%
%    stext(x,y,'\18\times MATLAB is {\bold great}!').
%
%It is possible to change the font size "on-the-fly" and make slightly
%smaller uppercase letters:
%
%    stext(x,y,'\18\times M\16ATLAB\18 is {\bold great}!')
%
%or, better yet,
%
%    stext(x,y,'\18\times M{\16ATLAB} is {\bold great}!').
%
%The curly braces signify a temporary style change (and may be nested).
%
%We can also display a simple mathematical equation with a Greek letter and
%a superscript:
%
%    stext(x,y,'\12\times The equation for alpha is \alpha = r^2'),
%
%where the alpha is produced with the Symbol font.  Note that the font size
%of the superscript is automatically reduced by a factor of sqrt(2).
%Subscripts are created similarly with '_'.  Normally, subscripts and
%superscripts must be enclosed in braces:
%
%    stext(x,y,'\12\times y = x_{index}^{exponent}'),
%
%but if the subscript or superscript is a single character the braces may be
%omitted:
%
%    stext(x,y,'\12\times y = x_1^2').
%
%It is also possible to use the normal text positioning properties
%HorizontalAlignment and VerticalAlignment.  For example,
%
%    stext(x,y,'\12\times Hello','HorizontalAlignment','center',...
%            'VerticalAlignment','middle'),
%
%will center the text at (x,y).  These properties and values can be
%abbreviated and mixed-case, pretty much the same as with the text command.
%So, we can also use
%
%    stext(x,y,'\12\times Hello','horiz','center','vert','mid').
%
%Experiment and see what works.
%
%Please note that it is also possible to use styled text in labels and
%titles using sxlabel, sylabel, szlabel and stitle.
%
%Because of the way that styled text objects are created, it is necessary to
%print them using printsto.  This m-file temporarily repositions the
%individual text objects so that when the figure dimensions are adjusted for
%printing the objects appear in the correct place.  The syntax of printsto
%is exactly the same as print (in fact, all the arguments are passed to
%print) so it is still possible to create PostScript files or set printing
%options.
%
%If the figure size is changed (or view in 3-D), the styled text objects
%will not be in the correct locations.  Use fixstext to reposition them.
%
%Please refer to the Command Reference below, read the help information in
%the various m-files and study the demo (stodemo.m) for further explanation.
%
%___________________________________________________________________________
%
%Command Reference.
%
%
%Parsing of Commands.
%
%It is important to understand how commands are parsed so you will know how
%spaces are treated.  There are three categories of commands: those with all
%letters (e.g., \alpha), those with all numbers (e.g., \12) and those
%consisting of a single special character (e.g., \+).  Commands are
%terminated by the first character that can be determined not to be part of
%the command itself.  For instance, if the command is all letters then the
%first non-letter will mark the end of the command.  If the next character
%is in the same category as the command characters then a single space
%should be inserted as the termination character.  This space will not
%appear in the output.  A few examples should make this clear:
%
%'\alpha a' will produce no space between the alpha and the a.  The space is
%necessary to terminate the \alpha command, but it gets swallowed.  Another
%way to achieve the same result is with '\alpha{}a'.
%
%'\alpha  a' will produce a single space between the alpha and the a.  The
%first space gets swallowed as above, but the second one will appear.
%Another way to get the same result is with '\alpha\ a', where the '\ ' is a
%standard space command.
%
%'\alpha1' will be parsed without error and there will be no space between
%the alpha and the 1.  Of course, this can also be done with '\alpha{}1',
%
%'\alpha 1' will have a single space between the alpha and the 1.
%
%'\+=' will be parsed without error and there will be no space between the
%'+' (which will be made with the Symbol font) and the '=' (in the current
%font).
%
%
%
%Grouping.
%
%Use curly braces, {}, to group characters and to effect temporary style
%changes.  For example,
%
%    stext(x,y,'\times Normal, {\i italic, {\b bold-italic}}, normal')
%
%will produce the indicated styles.  Braces can be nested as deeply as
%necessary.  See also the section on subscripts and superscripts below.
%
%
%
%Subscripts and Superscripts.
%
%Subscripts and superscripts can be produced with '_' and '^'.  The actual
%script must be enclosed in braces unless it is a single character in which
%case the braces may be omitted.  The scripts may be typed in either order.
%Some examples:
%
%    stext(x,y,'y = x^2')
%
%    stext(x,y,'y = x_1^2') which is equivalent to stext(x,y,'y = x^2_1')
%
%    stext(x,y,'y = e^{x^{\pi}}')
%
%    stext(x,y,'y = e^{t_{max}^2}')
%
%The font size of scripts is automatically reduced by a factor of sqrt(2).
%This process continues indefinitely so that in
%
%    stext(x,y,'\24x^{y^2}')
%
%the 'y' will be 17-point and the '2' will be 12-point type.
%
%
%
%Font size.
%
%The font size is set with \<n>, where <n> is the desired font size in
%points.  For example, \18 will set the font size to 18 points.  When
%different font sizes are used, the characters are aligned at their
%baselines.  The VerticalAlignment is set by the first displayed character.
%For example,
%
%    stext(x,y,'\12A\96A','VerticalAlignment','middle'),
%
%will produce a small A followed by a huge A with the middle of the small
%A at y and the baseline of the huge A aligned with the baseline of the
%small A.
%
%The font size can also be changed by:
%
%    \bigger     Increases font size by a factor of sqrt(2).
%    \larger     Increases font size by a factor of sqrt(2).
%    \smaller    Decreases font size by a factor of sqrt(2).
%
%
%
%Font angle and weight commands.
%
%    \light      Sets font weight to 'light'.
%    \demi       Sets font weight to 'demi'.
%    \bold       Sets font weight to 'bold'.
%
%    \italic     Sets font angle to 'italic'.
%    \oblique    Sets font angle to 'oblique'.
%
%    \normal     Sets both font angle and font weight to 'normal'.
%
%
%
%Fonts.
%
%To set or change the font used, use \<font name>.  The following are the
%fonts which can be used:
%
%Command               Font
%\times                Times
%\helvetica            Helvetica
%\courier              Courier
%\symbol               Symbol
%\avantgarde           Avant Garde
%\bookman              Bookman
%\newcenturyschlbk     New Century Schoolbook
%\palatino             Palatino
%\zapfdingbats         Zapf Dingbats
%\zapfchancery         Zapf Chancery
%\narrow               New Helvetica Narrow (not supported in Student Edition)
%
%
%
%Special Characters.
%
%The characters '\{}^_' have special meanings in command strings.  To get
%them to display and print use '\\', '\{', '\}', '\^' and '\_' instead.
%
%Arbitrary ASCII characters can be inserted with the \#{<a>} command, where
%<a> is the ASCII code of the character.  For example, since the ASCII code
%in most encodings for the copyright symbol is 169, it can be inserted with
%'\#{169}'.
%
%
%
%Colors.
%
%\black, \white, \red, \green, \blue, \cyan, \magenta, \yellow or \gray will
%set the text color appropriately.
%
%\color{<R>,<G>,<B>} sets text color to the specified RGB values.  For
%example, \color{.5,.5,.5} sets the text color to a medium gray (the same as
%\gray).
%
%
%
%Positioning, units = points.
%
%\left{<p>}, \right{<p>}, \up{<p>} and \down{<p>} move the subsequent print
%position left, right, up and down respectively (relative to the text) by
%<p> points.  Negative values for p are allowed.
%
%
%
%Positioning, units = current font size.
%
%\rleft{<r>}, \rright{<r>}, \rup{<r>} and \rdown{<r>} move the subsequent
%print position left, right, up and down respectively (relative to the text)
%by r*(current font size) points.  Negative values for r are allowed.
%
%
%
%Integrals, summations and products.
%
%\int{<a>}{<b>}, \sum{<a>}{<b>} and \prod{<a>}{<b>} produce a definite
%integral, summation and product, respectively, with lower limit <a> and
%upper limit <b> where <a> and <b> are valid stext constructs.  One or both
%of the limits may be blank, e.g.,
%
%    stext(x,y,'\int{x}{} f(x) dx')
%
%will produce the notation meaning "integrate over all x".  On the Macintosh
%(and perhaps on other platforms) the integral, summation and product
%symbols look too low on the screen, but print correctly.
%
%
%
%Fractions.
%
%\frac{<a>}{<b>} will produce a fraction of <a> over <b>, where <a> and <b>
%are valid stext constructs.
%
%
%
%Roots.
%
%\sqrt{<a>} will produce the square root of <a> and \root{<n>}{<x>} will
%produce the <n>th root of <x>.  The appearance on the screen may not match
%the print exactly.
%
%
%
%Lowercase Greek letters.
%
%These are produced using the same names as used by LaTeX. The following
%table lists the lowercase Greek letters:
%
%\alpha             \iota              \sigma
%\beta              \kappa             \varsigma
%\gamma             \lambda            \tau
%\delta             \mu                \upsilon
%\epsilon           \nu                \phi
%\varepsilon        \xi                \varphi
%\zeta              \pi                \chi
%\eta               \varpi             \psi
%\theta             \rho               \omega
%\vartheta          \varrho
%
%Two of these characters don't exist in the Symbol font but are included for
%completeness.  In particular, \varrho produces a TeX \rho and \epsilon
%produces a TeX \varepsilon (yes, that's right, it's the \epsilon character
%which is missing).
%
%
%
%Uppercase Greek letters.
%
%These are produced exactly like the lowercase ones.
%
%\Gamma             \Xi                \varUpsilon
%\Delta             \Pi                \Phi
%\Theta             \Sigma             \Psi
%\Lambda            \Upsilon           \Omega
%
%I made up the \varUpsilon name since the character is in the Symbol font,
%but it looks almost exactly like a Y in Times; I wouldn't recommend using
%it.  The other uppercase Greek letters look just like characters in the
%Roman alphabet and so are not included.
%
%
%
%Other LaTeX characters.
%
%Many other characters are available in the Symbol font:
%
%\forall            \approx            \angle
%\exists            \dots              \nabla
%\cong              \vert              \surd
%\perp              \Vert              \cdot
%\bot               \aleph             \neg
%\leq               \Im                \lnot
%\infty             \Re                \land
%\leftrightarrow    \wp                \lor
%\leftarrow         \otimes            \Leftrightarrow
%\uparrow           \oplus             \Leftarrow
%\rightarrow        \emptyset          \Uparrow
%\downarrow         \cap               \Rightarrow
%\degrees           \cup               \Downarrow
%\pm                \supset            \diamond
%\geq               \supseteq          \langle
%\propto            \notsubset         \lceil
%\partial           \subset            \lfloor
%\bullet            \subseteq          \rangle
%\div               \in                \rceil
%\neq               \notin             \rfloor
%\equiv             \AA
%
%If you don't know what some of these look like just try them out.
%
%
%
%Non-LaTeX characters.
%
%\+, \-, \=, \>, \< and \| use the appropriate characters from the Symbol
%font instead of whatever font you are using at the time.  The results may
%be somewhat better, especially \- since it produces a minus sign which is
%the same width as \+.  A hyphen is too narrow.
%
%\therefore produces the three-dot symbol.
%
%\prime produces a prime symbol.
%
%\dprime produces a double prime symbol.
%
%\slash produces a sharply angled slash from the Symbol font.
%
%\mult produces the x-shaped multiplication symbol.  In LaTeX this is called
%\times, but I had to change it since \times refers to the Times font.
%
%\horiz produces a fairly long horizontal line which matches up with
%\leftarrow and \rightarrow.
%
%\ii produces a dotless "i" for use under accents.  (Not available with the
%Windows encoding.)
%
%
%
%Diacritics.
%
%(See important note below.)
%It is possible to produce accented characters, however, the syntax is not
%the same as LaTeX.  Consider
%
%    stext(x,y,'y\hat \= x\tilde').
%
%The accent will be centered over the most recently produced character.  The
%accents which are available are:
%
%\grave     \Grave    (slanted line down to right)
%\acute     \Acute    (slanted line up to right)
%\ddot      \Ddot     (double dots)
%\hat       \Hat      ('^')
%\tilde     \Tilde    (squiggly line)
%\bar       \Bar      (short horizontal line or macron)
%\breve     \Breve    (semicircle open at top)           (N/A with Windows)
%\dot       \Dot      (single dot)                       (N/A with Windows)
%\check     \Check    (upside down '^')                  (N/A with Windows)
%
%The capitalized versions are a little higher and suitable for use over tall
%characters like 'b' or capitals.
%
%Note:  The accent characters are encoded in the upper half of the ASCII
%code range and in different places depending on the character encoding.
%There are three encoding schemes in use (that I know of): MacEncoding
%(used only on the Macintosh), WindowsLatin1Encoding (used only on Windows)
%and ISOLatin1Encoding (used by everything else).  The correct ASCII codes
%for your platform are computed from the encoding information contained in
%the font metric file, stfm.mat via stfm.txt, so you don't have to worry
%about this.
%
%There is, however, another problem which some people may encounter.
%Apparently, some PostScript printers (and software rasterizers) do not
%recognize the ISOLatin1Encoding keyword and use a default encoding which
%does not include some of the accent characters.  In this case, the accent
%characters will simply not print, but everything else will be ok.  There is
%a workaround.  It is possible to insert the ISOLatin1Encoding definition
%into the PostScript file before sending it to the printer.  I have included
%a UNIX script, addlatin, to perform the insertion.  So, instead of typing
%
%  >>printsto
%
%you must now type something like
%
%  >>printsto -dps myfig.ps  (or use -deps, -dpsc, etc.)
%  >>!addlatin myfig.ps
%  >>!lpr myfig.ps           (substitute 'lp' for 'lpr' if necessary)
%
%to print figures which contain accented characters.  Please note that if
%you are using a Macintosh (which uses MacEncoding), Windows (which uses
%WindowsLatin1Encoding) or your PostScript printer already recognizes the
%ISOLatin1Encoding keyword you don't have to worry about any of this.  Also
%note that the accents may not appear on the screen, but they should print
%correctly.
%
%
%
%Slanted Symbol Characters.
%
%As mentioned below, scalar variables should be in italics.  This poses a
%problem when the variable is represented by a Greek letter because there is
%no Symbol-Italic or Symbol-Oblique font.  Whenever you have seen a slanted
%version of one of the Symbol characters it has been produced by appropriate
%PostScript code which slants the character.  Unfortunately, MATLAB does not
%do this and italic or oblique Symbol characters are rendered unslanted.
%There is now a way around this problem.  The function stfixps will modify a
%PostScript file by inserting the character-slanting code.  The PostScript
%file must have been made from a figure containing styled text objects which
%include italic or oblique Symbol characters.  So, as above, printing becomes
%a little more complicated.  You must type something like
%
%  >>printsto -dps myfig.ps  (or use -deps, -dpsc, etc.)
%  >>stfixps myfig.ps
%  >>!lpr myfig.ps           (substitute 'lp' for 'lpr' if necessary)
%
%to print figures containing slanted Greek letters.  This creates a problem
%for Mac users since there is no built-in equivalent to lpr.  I recommend
%obtaining Drop¥PS from Bare Bones Software which is a drag-and-drop
%application to send PostScript files to a printer.  You can either drop
%myfig.ps on Drop¥PS or type
%
%  >>!Drop¥PS myfig.ps
%
%at the MATLAB prompt.  Drop¥PS is free and is available from
%
%  http://www.barebones.com/freeware/DropPS-113.hqx
%
%I don't have access to a Windows machine so I don't know how to do this
%there, but I assume some kind of utility exists to send PostScript files
%to a printer.
%
%
%___________________________________________________________________________
%
%Tips and Style Comments
%
%1)  Abbreviation of Commands.
%
%There are two kinds of commands:  those that produce a character and those
%that merely change the appearance of subsequent characters.  It is
%permissible to abbreviate the latter but not the former.  The rules for
%determining a valid abbreviation are somewhat complicated.  It has to do
%with the order of the tests to determine the command.  Basically, just make
%sure the abbreviation is unambiguous.  For example, \i is a valid
%abbreviation for \italic since no other commands begin with 'i' except for
%\int, \iota, \infty and \in and those are all character producing commands.
%Other valid abbreviations for \italic are \itali, \ital, \ita and \it.
%
%Minimal abbreviations:
%\n     = \normal                       \sm   = \smaller
%\i     = \italic                       \bl   = \black
%\o     = \oblique                      \w    = \white
%\l     = \light                        \r    = \red
%\d     = \demi                         \g    = \green
%\b     = \bold                         \blu  = \blue
%\t     = \times                        \cy   = \cyan
%\h     = \helvetica                    \m    = \magenta
%\c     = \courier                      \y    = \yellow
%\s     = \symbol                       \gra  = \gray
%\a     = \avantgarde                   \co   = \color
%\boo   = \bookman                      \le   = \left
%\ne    = \newcenturyschlbk             \ri   = \right
%\p     = \palatino                     \u    = \up
%\z     = \zapfdingbats                 \do   = \down
%\zapfc = \zapfchancery                 \rl   = \rleft
%\na    = \narrow                       \rr   = \rright
%\bi    = \bigger                       \ru   = \rup
%\la    = \larger                       \rd   = \rdown
%
%
%
%2)  Braces.
%
%Use braces liberally.  They can be nested as deeply as necessary and they
%make the expressions easier to read.  For example,
%
%    stext(x,y,'\12\times The word {\i italic} is in italics.')
%
%is clearer than
%
%    stext(x,y,'\12\times The word \i italic \norm is in italics.').
%
%
%
%3)  Mathematical Formulas.
%
%For a professional look, use italics for scalar variables.  It can make the
%command string look pretty messy, but is worth it.  Compare
%
%    stext(x,y,'\18\times r^2 \= x^2 \+ y^2')
%
%with
%
%    stext(x,y,'\18\times{\i r}^2 \= {\i x}^2 \+ {\i y}^2').
%
%When using accents over italicized characters, make the accents in italics
%also.  For example,
%
%    stext(x,y,'{\i y\hat}')
%
%looks better than
%
%    stext(x,y,'{\i y}\hat').
%
%
%
%4)  Tweaking.
%
%If you are fussy, you can tweak the appearance of your styled text objects
%using the positioning commands (\left, \right, etc.).  It is usually better
%to use the ones which are in units of current font size (\rleft, \rright,
%etc.) since you can design and preview the object on-screen at a large size
%and then scale it down just by changing the font size.  The individual
%elements will maintain their relationships to each other.
%
%The positioning commands can be used to produce some very complicated
%mathematical formulas, but it will require some trial-and-error (try using
%spreview).
%
%An example of this is to move the axis labels away from the axes:
%
%    sxlabel('\down{5}This label will be 5 points lower than normal.')
%    sylabel('\up{5}This label will be 5 points to the left of normal.')
%
%A number of spacing commands are available.  In order, they are:
%
%'\/'    italic correction
%'\,'    thin space
%'\:'    medium space
%'\;'    thick space
%'\ '    word space
%
%The italic correction can be used to add just a little bit of space when
%there is a transition from italic to normal letters.  The other spaces can
%be useful in various situations.
%
%___________________________________________________________________________
%
%Other features.
%
%Ordinary text strings are kerned using the kern pairs defined in the Adobe
%Font Metric files for the supported fonts.
%
%Printing does *not* require that the figure 'Position' be set to the same
%dimensions as the 'PaperPosition' (WYSIWYG mode).  This means that printing
%works correctly even if you have a small monitor (where it is not possible
%to use WYSIWYG mode since the monitor is not as tall as a piece of paper).
%If you do use WYSIWYG mode it is not necessary to print using printsto;
%print will work just fine.
%
%The Styled Text Toolbox was designed to be platform-independent.  I have
%taken into account the different character encodings in use.  Also, to
%accommodate the PC users, the file names have no more than eight
%characters.
%
%The Styled Text Toolbox was designed to be user-preference-independent.
%There are no built-in defaults or assumptions such as text color or font
%choice.
%
%___________________________________________________________________________
%
%What are its limitations?
%
%The mathematical formulas which can be created easily with the Styled Text
%Toolbox are somewhat limited.  You can make Greek letters, italics,
%superscripts, subscripts, integrals, etc., but other more complicated
%constructs are possible only with some difficulty and creativity.  It was
%never my intention to make this thing an equation typesetting tool (though
%it seems to be moving in that direction), but just a way of including Greek
%letters and simple formulas in MATLAB figures.
%
%___________________________________________________________________________
%
%Important Information.
%
%The Styled Text Toolbox was written by me, Douglas M. Schwarz.  Although I
%am an employee of the Eastman Kodak Company, this tool was written entirely
%on my own time and is not supported in any way by Kodak.  If you have a
%problem with it please bring it to my attention, but there may be a day or
%two delay before I can get around to looking at it.  The Styled Text
%Toolbox is free, but not in the public domain and I retain all rights.  You
%are free to modify your own copy, of course, but please do not distribute a
%modified version.  I am open to any suggestions of ways to improve this
%tool.
%
%
%Styled Text Toolbox
%Version 3.2b, 10 March 1997
%Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%schwarz@kodak.com
fclose(fout);

disp(' ## Installing: "readstfm.m" (text)')
fout = fopen('readstfm.m', 'w');
%function [fm,kds,encs,accents,encsel,verts] = readstfm(filename)
%%READSTFM Read Styled Text Toolbox font metrics file.
%%	[FM,KD,ENCODING,ACCENTS,ENCSEL,VERTALIGN] = READSTFM(FILENAME) reads
%%	the file specified by FILENAME which must be the text version of the
%%	font metrics.  The character widths, kerning data, encoding vectors,
%%	accent characters, encoding selector and vertical alignment positions
%%	are returned.
%%
%%	If FILENAME is omitted then the file "stfm.txt" in the Styled
%%	Text Toolbox directory is assumed.
%
%%	Requires function CMDMATCH and file STFM.TXT.
%%	Requires MATLAB Version 4.2 or greater.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%if nargin == 0
%	stextfun = which('stext');
%	stextfun((length(stextfun) - 6):length(stextfun)) = [];
%	filename = [stextfun,'stfm.txt'];
%end
%
%fid = fopen(filename);
%
%% Read the character widths of the Roman fonts.
%while 1
%	line = fgetl(fid);
%	if cmdmatch(line,'BeginRomanCharWidths'), break, end
%end
%dims = sscanf(line,'%*s %d %d');
%numChars = dims(1);
%if isstudent
%	nrmFnts = dims(2) - 4;
%	fmt = ['%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d',...
%			'%d%d%d%d%d%d%d%d%d%*d%*d%*d%*d%d'];
%else
%	nrmFnts = dims(2);
%	fmt = '%d';
%end
%widths = fscanf(fid,fmt,[nrmFnts,numChars])';
%
%% Read the character widths of the Symbol font.
%while 1
%	line = fgetl(fid);
%	if cmdmatch(line,'BeginSymbolCharWidths'), break, end
%end
%nsymch = sscanf(line,'%*s %d');
%symwidths = fscanf(fid,'%d',nsymch);
%
%% Read the character widths of the ZapfDingbats font.
%while 1
%	line = fgetl(fid);
%	if cmdmatch(line,'BeginZapfDingbatsCharWidths'), break, end
%end
%nzdch = sscanf(line,'%*s %d');
%zdwidths = fscanf(fid,'%d',nzdch);
%
%% Read the kerning data information.
%while 1
%	line = fgetl(fid);
%	if cmdmatch(line,'BeginKernData'), break, end
%end
%nkd = sscanf(line,'%*s %d')';
%if isstudent
%	pos = ftell(fid);
%	kernData1 = fscanf(fid,'%d%*d%*d%*d',nkd);
%	fseek(fid,pos,'bof');
%	kernData2 = fscanf(fid,'%*d%d%*d%*d',nkd);
%	fseek(fid,pos,'bof');
%	kernData3 = fscanf(fid,'%*d%*d%d%*d',nkd);
%	fseek(fid,pos,'bof');
%	kernData4 = fscanf(fid,'%*d%*d%*d%d',nkd);
%else
%	kernData = fscanf(fid,'%d',[4,nkd])';
%end
%
%% Read the encoding vectors.
%while 1
%	line = fgetl(fid);
%	if cmdmatch(line,'BeginEncodings'), break, end
%end
%data = sscanf(line,'%*s %d %d');
%encsel = data(1);
%nenc = data(2);
%encs = fscanf(fid,'%d',[nenc,256])';
%
%% Read the vertical alignment metrics.
%while 1
%	line = fgetl(fid);
%	if cmdmatch(line,'BeginVertAlign'), break, end
%end
%numFonts = sscanf(line,'%*s %d');
%verts = fscanf(fid,'%f%f%f%f%f',[5,numFonts])';
%
%fclose(fid);
%
%% Put all the character widths in one matrix.
%n = max([nsymch,nzdch,numChars]);
%fm = zeros(n,nrmFnts+2);
%fm(1:nsymch,1) = symwidths;
%fm(1:nzdch,2) = zdwidths;
%fm(1:numChars,3:nrmFnts+2) = widths;
%
%% Store the kerning data as a sparse matrix.
%if isstudent
%	i = 1000*kernData1 + kernData2;
%	kds = sparse(i,kernData3,kernData4,34000,260);
%else
%	i = 1000*kernData(:,1) + kernData(:,2);
%	kds = sparse(i,kernData(:,3),kernData(:,4),34000,260);
%end
%
%% These are the accent characters (PostScript name in parentheses if
%% different): grave, acute, ddot (dieresis), hat (circumflex), tilde,
%% bar (macron), breve, dot (dotaccent), check (caron), AA (Aring),
%% and ii (dotlessi).
%accents = [124 125 131 126 127 128 129 130 136 205 145];
fclose(fout);

disp(' ## Installing: "setstext.m" (text)')
fout = fopen('setstext.m', 'w');
%function setstext(anchor,p1,v1,p2,v2,p3,v3,p4,v4,p5,v5,...
%		p6,v6,p7,v7,p8,v8,p9,v9,p10,v10,p11,v11,p12,v12)
%%SETSTEXT Set styled text object properties.
%%	SETSTEXT has the same syntax as SET except that only one styled text
%%	handle can be specified and SETSTEXT(H) does not display all the
%%	property names and possible values.
%%
%%	See also SET, STEXT, SXLABEL, SYLABEL, SZLABEL, STITLE, DELSTEXT
%%	PRINTSTO, FIXSTEXT.
%
%%	Requires functions STEXT, CMDMATCH and GETCARGS and MAT-file STFM.MAT.
%%	Requires MATLAB Version 4.2 or greater.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%% Define gFONT_METRICS, gKERNING_DATA, gENCODING, gACCENTS, gENC_SEL
%% and gVAL as global variables so we only have to load them if they
%% weren't loaded by stext or have been cleared.
%global gFONT_METRICS gKERNING_DATA gENCODING gACCENTS gENC_SEL gVAL
%if length(gFONT_METRICS) == 0
%	temp = stext;
%	delstext(temp)
%end
%% Determine encoding selector, es, depending on platform.
%if gENC_SEL == 0
%	comp = computer;
%	if cmdmatch(comp,'MAC')
%		es = 3;
%	elseif cmdmatch(comp,'PC')
%		es = 4;
%	else
%		es = 5;
%	end
%else
%	es = gENC_SEL;
%end
%nacc = length(gACCENTS);
%accents = 32*ones(1,nacc);
%for i = 1:nacc
%	loc = find(gENCODING(:,es) == gACCENTS(i));
%	if ~isempty(loc)
%		accents(i) = max(loc) - 1;
%	end
%end
%
%% Check to see if handle is a valid stext object.
%tag = get(anchor,'Tag');
%if ~strcmp(tag(1:min(length(tag),5)),'stext')
%	error('Not an stext object.')
%end
%ver5 = cmdmatch(version,'5');
%
%% Make sure current axes are parent of anchor.
%fig = get(0,'CurrentFigure');
%currentAxes = get(fig,'CurrentAxes');
%set(fig,'CurrentAxes',get(anchor,'Parent'))
%
%% Get default values.
%str           = setstr(rem(get(anchor,'String'),256));
%anchorPos     = get(anchor,'Position');
%horizAlign    = get(anchor,'HorizontalAlignment');
%vertAlign     = get(anchor,'VerticalAlignment');
%anchorUnits   = get(anchor,'Units');
%rotation      = get(anchor,'Rotation');
%eraseMode     = get(anchor,'EraseMode');
%buttonDownFcn = get(anchor,'ButtonDownFcn');
%clipping      = get(anchor,'Clipping');
%interruptible = get(anchor,'Interruptible');
%fontSize      = get(0,'DefaultTextFontSize');
%fontName      = lower(get(0,'DefaultTextFontName'));
%color         = get(0,'DefaultTextColor');
%
%set(anchor,'Rotation',0,'Visible','off')
%userData = get(anchor,'UserData');
%oldObjList = userData(4:length(userData));
%if length(oldObjList) > 0
%	visible = get(oldObjList(1),'Visible');
%else
%	visible = 'on';
%end
%
%% Look for and set some properties
%numOptions = (nargin - 1)/2;
%for i = 1:numOptions
%	property = eval(['p',num2str(i)]);
%	value = eval(['v',num2str(i)]);
%	
%	% Convert property and value (if it's a string) to lower case.
%	% This code is significantly simpler and faster than lower.m, but
%	% sufficient for our purposes.
%	upperCase = property >= 'A' & property <= 'Z';
%	property(upperCase) = setstr(property(upperCase) + ('a' - 'A'));
%	if isstr(value) & ~cmdmatch('string',property)
%		upperCase = value >= 'A' & value <= 'Z';
%		value(upperCase) = setstr(value(upperCase) + ('a' - 'A'));
%	end
%	
%	% HorizontalAlignment: [ {left} | center | right ]
%	if cmdmatch('horizontalalignment',property)
%		horizAlign = value;
%		set(anchor,'HorizontalAlignment',value)
%	
%	% VerticalAlignment: [ top | cap | {middle} | baseline | bottom ]
%	elseif cmdmatch('verticalalignment',property)
%		vertAlign = value;
%		set(anchor,'VerticalAlignment',value)
%	
%	% Units: [ inches | centimeters | normalized | points | pixels | {data} ]
%	elseif cmdmatch('units',property)
%		anchorUnits = value;
%		set(anchor,'Units',value)
%		anchorPos = get(anchor,'Position');
%	
%	% Position
%	elseif cmdmatch('position',property)
%		anchorPos = value;
%		set(anchor,'Position',value)
%		xin = value(1);
%		yin = value(2);
%	
%	% Rotation
%	elseif cmdmatch('rotation',property)
%		rotation = value;
%		rotation = rotation - floor(rotation/360)*360;
%	
%	% String
%	elseif cmdmatch('string',property)
%		str = value;
%		set(anchor,'String',value)
%	
%	% EraseMode
%	elseif cmdmatch('erasemode',property)
%		eraseMode = value;
%		set(anchor,'EraseMode',value)
%	
%	% ButtonDownFcn
%	elseif cmdmatch('buttondownfcn',property)
%		buttonDownFcn = value;
%		set(anchor,'ButtonDownFcn',value)
%	
%	% Clipping
%	elseif cmdmatch('clipping',property)
%		clipping = value;
%		set(anchor,'Clipping',value)
%	
%	% Interruptible
%	elseif cmdmatch('interruptible',property)
%		interruptible = value;
%		set(anchor,'Interruptible',value)
%	
%	% Visible
%	elseif cmdmatch('visible',property)
%		visible = value;
%		set(anchor,'Visible',value)
%	
%	else
%		error('Invalid object property.')
%	end
%end
%
%% Determine exact starting point.
%if cmdmatch('points',anchorUnits)
%	pos = get(anchor,'Position');
%else
%	posu0 = get(anchor,'Position');
%	set(anchor,'Units','points')
%	pos1 = get(anchor,'Position');
%	set(anchor,'Units',anchorUnits)
%	posu1 = get(anchor,'Position');
%	set(anchor,'Units','points','Position',pos1 + 1,'Units',anchorUnits)
%	posu2 = get(anchor,'Position');
%	pos = (posu0(1:2) - posu1(1:2))./(posu2(1:2) - posu1(1:2)) + pos1(1:2);
%	set(anchor,'Units','points','Position',pos,'Units',anchorUnits)
%end
%x0 = pos(1);
%y0 = pos(2);
%
%% Initialize some data.
%objList = [];
%heightList = [];
%xDistance = [];
%first = 1;
%slantTagged = 0;
%termNoDigits = setstr(1:255);
%termNoDigits(real('0'):real('9')) = [];
%termNoAlpha = setstr(1:255);
%termNoAlpha([real('A'):real('Z'),real('a'):real('z')]) = [];
%xstack = [];
%colLut = [1 1 3 3;2 2 4 4;2 2 4 4];
%if isstudent
%	fm = [1 1 1 1 ; 2 2 2 2 ; 3:6 ; 7:10 ; 11:14 ; 15:18 ; 19:22 ;...
%			23:26 ; 27:30 ; 7:10 ; 31 31 31 31];
%else
%	fm = [1 1 1 1 ; 2 2 2 2 ; 3:6 ; 7:10 ; 11:14 ; 15:18 ; 19:22 ;...
%			23:26 ; 27:30 ; 31:34 ; 35 35 35 35];
%end
%
%fontanglelist = str2mat('normal','italic','oblique');
%fontnamelist = str2mat('symbol','zapfdingbats','times','helvetica',...
%		'palatino','courier','avantgarde','bookman',...
%		'newcenturyschlbk','n helvetica narrow','zapfchancery');
%fontweightlist = str2mat('light','normal','demi','bold');
%
%% Initialize indexing parameters for "params" array.  fa = font angle,
%% fn = font name, fs = font size, fw = font weight, cr,cg,cb = color rgb,
%% x = x location, y = y location, mode is used for super- and subscripts,
%% nextX = x location of next object.
%fa = 1; fn = 2; fs = 3; fw = 4; cr = 5; cg = 6; cb = 7; x = 8; y = 9;
%mode = 10; nextX = 11;
%
%% params is a parameter stack.  The contents are indices into string
%% matrices for font angle, name and weight and actual values for
%% the others.
%
%% Initialize params: font angle = normal, font name = default font,
%% font size = default text font size, font weight = normal,
%% color = default text color, x = 0, y = 0, mode = 0, nextX = 0.
%params = [1;4;fontSize;2;get(0,'DefaultTextColor')';0;0;0;0];
%for fontIndex = 1:11
%	if cmdmatch(fontnamelist(fontIndex,:),fontName)
%		params(fn) = fontIndex;
%		break
%	end
%end
%
%% Parse str looking for commands.
%while ~isempty(str)
%	if str(1) == '{'
%		% Push a copy of the current parameters on the parameter stack.
%		params = [params(:,1),params];
%		params(mode) = 0;
%		str(1) = [];
%	elseif str(1) == '}'
%		% Pop the parameter stack except for adjustments to the x values.
%		if size(params,2) == 1
%			delete(objList)
%			delete(anchor)
%			error('Unmatched braces.')
%		end
%		str(1) = [];
%		params(nextX,2) = max(params(nextX),params(nextX,2));
%		if params(mode,2) == 0
%			params(x,2) = params(x);
%		end
%		if isempty(str)
%			params(x,2) = params(x);
%		else
%			if str(1) ~= '^' & str(1) ~= '_'
%				params(x,2) = params(x);
%				params(mode,2) = 0;
%			end
%		end
%		params(:,1) = [];
%	elseif str(1) == '^'
%		% Superscript
%		params(mode) = params(mode) + 1;
%		params = [params(:,1),params];
%		params(mode) = 0;
%		params(nextX) = params(x);
%		params(y) = params(y) + params(fs)/3;
%		params(fs) = params(fs)/sqrt(2);
%		if str(2) == '{'
%			str(1:2) = [];
%		else
%			str(1:2) = [str(2),'}'];
%		end
%	elseif str(1) == '_'
%		% Subscript
%		params(mode) = params(mode) + 2;
%		params = [params(:,1),params];
%		params(mode) = 0;
%		params(nextX) = params(x);
%		params(y) = params(y) - params(fs)/4;
%		params(fs) = params(fs)/sqrt(2);
%		if str(2) == '{'
%			str(1:2) = [];
%		else
%			str(1:2) = [str(2),'}'];
%		end
%	elseif str(1) == '\'
%		% Extract command.
%		if all(str(2) ~= termNoAlpha)
%			[cmd,str] = strtok(str,termNoAlpha);
%			if length(str) > 1
%				if str(1) == ' '
%					nonSpace = min(find(str ~= ' '));
%					if ~isempty(nonSpace)
%						if all(str(nonSpace) ~= termNoAlpha)
%							str(1) = [];
%						end
%					end
%				end
%			end
%		elseif all(str(2) ~= termNoDigits)
%			[cmd,str] = strtok(str,termNoDigits);
%			if length(str) > 1
%				if str(1) == ' '
%					nonSpace = min(find(str ~= ' '));
%					if ~isempty(nonSpace)
%						if all(str(nonSpace) ~= termNoDigits)
%							str(1) = [];
%						end
%					end
%				end
%			end
%		else
%			cmd = str(2);
%			str(1:2) = [];
%		end
%		
%		% Command is a space.
%		if strcmp(' ',cmd)
%			str = [' ',str];
%		
%		% Font size specified in points.
%		elseif all(cmd >= '0' & cmd <= '9')
%			params(fs) = sscanf(cmd,'%d');
%			if params(fs) > 255
%				delete(objList)
%				delete(anchor)
%				error('Font size too large.')
%			end
%				
%		% Font angle and weight commands.
%		elseif cmdmatch('normal',cmd),  params(fa) = 1; params(fw) = 2;
%		elseif cmdmatch('italic',cmd),  params(fa) = 2;
%		elseif cmdmatch('oblique',cmd), params(fa) = 3;
%		elseif cmdmatch('light',cmd),   params(fw) = 1;
%		elseif cmdmatch('demi',cmd),    params(fw) = 3;
%		elseif cmdmatch('bold',cmd),    params(fw) = 4;
%		
%		% Font names.
%		elseif cmdmatch('symbol',cmd),           params(fn) = 1;
%		elseif cmdmatch('zapfdingbats',cmd),     params(fn) = 2;
%		elseif cmdmatch('times',cmd),            params(fn) = 3;
%		elseif cmdmatch('helvetica',cmd),        params(fn) = 4;
%		elseif cmdmatch('palatino',cmd),         params(fn) = 5;
%		elseif cmdmatch('courier',cmd),          params(fn) = 6;
%		elseif cmdmatch('avantgarde',cmd),       params(fn) = 7;
%		elseif cmdmatch('bookman',cmd),          params(fn) = 8;
%		elseif cmdmatch('newcenturyschlbk',cmd), params(fn) = 9;
%		elseif cmdmatch('narrow',cmd),           params(fn) = 10;
%		elseif cmdmatch('zapfchancery',cmd),     params(fn) = 11;
%		
%		% Font size in sqrt(2) increments.
%		elseif cmdmatch('bigger',cmd),  params(fs) = params(fs)*sqrt(2);
%		elseif cmdmatch('larger',cmd),  params(fs) = params(fs)*sqrt(2);
%		elseif cmdmatch('smaller',cmd), params(fs) = params(fs)/sqrt(2);
%		
%		% Colors.
%		elseif cmdmatch('black',cmd),   params(cr:cb) = [0;0;0];
%		elseif cmdmatch('white',cmd),   params(cr:cb) = [1;1;1];
%		elseif cmdmatch('red',cmd),     params(cr:cb) = [1;0;0];
%		elseif cmdmatch('green',cmd),   params(cr:cb) = [0;1;0];
%		elseif cmdmatch('blue',cmd),    params(cr:cb) = [0;0;1];
%		elseif cmdmatch('cyan',cmd),    params(cr:cb) = [0;1;1];
%		elseif cmdmatch('magenta',cmd), params(cr:cb) = [1;0;1];
%		elseif cmdmatch('yellow',cmd),  params(cr:cb) = [1;1;0];
%		elseif cmdmatch('gray',cmd),    params(cr:cb) = [0.5;0.5;0.5];
%		elseif cmdmatch('color',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			params(cr:cb) = sscanf(arg,'%f,%f,%f');
%		
%		% Absolute positioning in points.
%		elseif cmdmatch('left',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params([x,nextX]) = params([x,nextX]) - arg;
%		elseif cmdmatch('right',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params([x,nextX]) = params([x,nextX]) + arg;
%		elseif cmdmatch('up',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params(y) = params(y) + arg;
%		elseif cmdmatch('down',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params(y) = params(y) - arg;
%		
%		% Relative positioning in units of current font size.
%		elseif cmdmatch('rleft',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params([x,nextX]) = params([x,nextX]) - arg*round(params(fs));
%		elseif cmdmatch('rright',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params([x,nextX]) = params([x,nextX]) + arg*round(params(fs));
%		elseif cmdmatch('rup',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params(y) = params(y) + arg*round(params(fs));
%		elseif cmdmatch('rdown',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params(y) = params(y) - arg*round(params(fs));
%		
%		% Integral.
%		elseif strcmp('int',cmd)
%			[arg1,str] = getcargs(str);
%			[arg2,str] = getcargs(str);
%			str = ['{\rdown{.25}\larger\sym',242,...
%					'}_{\rleft{.1}\rdown{.3}{',arg1,...
%					'}}^{\rright{.2}\rup{.6}{',arg2,'}}',str];
%		
%		% Summation.
%		elseif strcmp('sum',cmd)
%			[arg1,str] = getcargs(str);
%			[arg2,str] = getcargs(str);
%			str = ['{\rdown{.2}\larger\sym',229,'}_{\rdown{.1}{',arg1,...
%					'}}^{\rup{.2}{',arg2,'}}',str];
%		
%		% Product.
%		elseif strcmp('prod',cmd)
%			[arg1,str] = getcargs(str);
%			[arg2,str] = getcargs(str);
%			str = ['{\rdown{.2}\larger\sym',213,'}_{\rdown{.1}{',arg1,...
%					'}}^{\rup{.2}{',arg2,'}}',str];
%		
%		% Square root.
%		elseif strcmp('sqrt',cmd)
%			[arg1,str] = getcargs(str);
%			pfs = round(params(fs));
%			nfs = sprintf('%d',pfs);
%			nfn = deblank(fontnamelist(params(fn),:));
%			if params(fn) == 11
%				nfn = 'n helvetica narrow';
%			end
%			narg1 = ['\',nfs,'\',nfn,'{}',arg1];
%			h1 = eval(['stext(0,0,narg1,''Units'',''points'',',...
%					'''vert'',''base'')'],'-1');
%			if h1 == -1
%				delete(objList)
%				delete(anchor)
%				error(lasterr)
%			end
%			e1 = getstext(h1,'Extent');
%			delstext(h1)
%			rfs = ceil(e1(4)/0.955);
%			ofs = 0.038*rfs + e1(2);
%			exr = 0.2;
%			sqrtwid = e1(3) + 2*exr*pfs;
%			numex = sqrtwid/(rfs*0.5);
%			numex1 = ceil(numex) - 1;
%			jog = 0.5*rfs - (sqrtwid - numex1*0.5*rfs);
%			exs = setstr(96*ones(1,numex1));
%			x1 = e1(3) + exr*pfs - 0.5*rfs;
%			x2 = exr*pfs;
%			str = ['{\',num2str(rfs),'\up{',num2str(ofs),...
%					'}\nor\sym',214,'\rleft{0.549}',exs,...
%					'\left{',num2str(jog),'}',96,...
%					'\left{',num2str(x1),'}}{',arg1,...
%					'}\right{',num2str(x2),'}',str];
%			
%		% Root.
%		elseif strcmp('root',cmd)
%			[arg1,str] = getcargs(str);
%			[arg2,str] = getcargs(str);
%			pfs = round(params(fs));
%			nfs = sprintf('%d',pfs);
%			nfn = deblank(fontnamelist(params(fn),:));
%			if params(fn) == 11
%				nfn = 'n helvetica narrow';
%			end
%			narg2 = ['\',nfs,'\',nfn,'{}',arg2];
%			h1 = eval(['stext(0,0,narg2,''Units'',''points'',',...
%					'''vert'',''base'')'],'-1');
%			if h1 == -1
%				delete(objList)
%				delete(anchor)
%				error(lasterr)
%			end
%			e1 = getstext(h1,'Extent');
%			delstext(h1)
%			rfs = ceil(e1(4)/0.955);
%			ofs = 0.038*rfs + e1(2);
%			exr = 0.2;
%			sqrtwid = e1(3) + 2*exr*pfs;
%			numex = sqrtwid/(rfs*0.5);
%			numex1 = ceil(numex) - 1;
%			jog = 0.5*rfs - (sqrtwid - numex1*0.5*rfs);
%			exs = setstr(96*ones(1,numex1));
%			x1 = e1(3) + exr*pfs - 0.5*rfs;
%			x2 = exr*pfs;
%			pfs2 = round(pfs/2);
%			str = ['{\',num2str(rfs),'\up{',num2str(ofs),...
%					'}{\pushx\rup{0.56}\rright{0.17}\',...
%					num2str(pfs2),'{}',arg1,...
%					'\popx}\norm\sym',214,'\rleft{0.549}',...
%					exs,'\left{',num2str(jog),'}',96,...
%					'\left{',num2str(x1),'}}{',arg2,...
%					'}\right{',num2str(x2),'}',str];
%			
%		% Fraction.
%		elseif strcmp('frac',cmd)
%			[arg1,str] = getcargs(str);
%			[arg2,str] = getcargs(str);
%			pfs = round(params(fs));
%			nfs = sprintf('%d',pfs);
%			nfn = deblank(fontnamelist(params(fn),:));
%			if params(fn) == 11
%				nfn = 'n helvetica narrow';
%			end
%			narg1 = ['\',nfs,'\',nfn,'{}',arg1];
%			narg2 = ['\',nfs,'\',nfn,'{}',arg2];
%			h1 = eval(['stext(0,0,narg1,''Units'',''points'',',...
%					'''vert'',''base'')'],'-1');
%			if h1 == -1
%				delete(objList)
%				delete(anchor)
%				error(lasterr)
%			end
%			e1 = getstext(h1,'Extent');
%			delstext(h1)
%			h2 = eval(['stext(0,0,narg2,''Units'',''points'',',...
%					'''vert'',''base'')'],'-1');
%			if h2 == -1
%				delete(objList)
%				delete(anchor)
%				error(lasterr)
%			end
%			e2 = getstext(h2,'Extent');
%			delstext(h2)
%			
%			if e2(3) > e1(3)
%				x1 = (e2(3) - e1(3))/2;
%				x2 = -(x1 + e1(3));
%				x3 = 0;
%			else
%				x1 = 0;
%				x2 = -(e1(3) + e2(3))/2;
%				x3 = (e1(3) - e2(3))/2;
%			end
%			y1 = pfs/3 - e1(2);
%			y2 = -y1 - (e2(4) + e2(2)) + pfs/6;
%			y3 = -(y1 + y2);
%			
%			exr = 0.1;
%			fracwid = max(e1(3),e2(3)) + 2*exr*pfs;
%			numu = fracwid/(pfs*0.5);
%			numu1 = ceil(numu) - 1;
%			jog = 0.5*pfs - (fracwid - numu1*0.5*pfs);
%			unds = ('\_')';
%			unds = unds(:,ones(numu1,1));
%			unds = unds(:)';
%			str = ['{\up{',num2str(y1),'}\right{',num2str(x1+exr*pfs),...
%					'}{',arg1,'}\up{',num2str(y2),...
%					'}\right{',num2str(x2),'}{',arg2,...
%					'}\right{',num2str(x3),'}}{\left{',...
%					num2str(fracwid-exr*pfs),'}\up{',...
%					num2str(pfs*0.4385),'}\sym',unds,...
%					'\left{',num2str(jog),'}\_}',str];
%			
%		% Slashed fraction.
%		elseif strcmp('slash',cmd)
%			[arg1,str] = getcargs(str);
%			[arg2,str] = getcargs(str);
%			pfs = round(params(fs));
%			ffs = round(pfs*0.625);
%			ffss = sprintf('%d',ffs);
%			str = ['{\rup{0.256}\',ffss,'{',arg1,...
%					'}}{\sym',164,'}{\',ffss,'{',arg2,'}}',str];
%		
%		% Lowercase Greek letters.
%		elseif strcmp('alpha',cmd),      str = ['{\sym a}',str];
%		elseif strcmp('beta',cmd),       str = ['{\sym b}',str];
%		elseif strcmp('gamma',cmd),      str = ['{\sym g}',str];
%		elseif strcmp('delta',cmd),      str = ['{\sym d}',str];
%		elseif strcmp('epsilon',cmd),    str = ['{\sym e}',str];
%		elseif strcmp('varepsilon',cmd), str = ['{\sym e}',str];
%		elseif strcmp('zeta',cmd),       str = ['{\sym z}',str];
%		elseif strcmp('eta',cmd),        str = ['{\sym h}',str];
%		elseif strcmp('theta',cmd),      str = ['{\sym q}',str];
%		elseif strcmp('vartheta',cmd),   str = ['{\sym J}',str];
%		elseif strcmp('iota',cmd),       str = ['{\sym i}',str];
%		elseif strcmp('kappa',cmd),      str = ['{\sym k}',str];
%		elseif strcmp('lambda',cmd),     str = ['{\sym l}',str];
%		elseif strcmp('mu',cmd),         str = ['{\sym m}',str];
%		elseif strcmp('nu',cmd),         str = ['{\sym n}',str];
%		elseif strcmp('xi',cmd),         str = ['{\sym x}',str];
%		elseif strcmp('pi',cmd),         str = ['{\sym p}',str];
%		elseif strcmp('varpi',cmd),      str = ['{\sym v}',str];
%		elseif strcmp('rho',cmd),        str = ['{\sym r}',str];
%		elseif strcmp('varrho',cmd),     str = ['{\sym r}',str];
%		elseif strcmp('sigma',cmd),      str = ['{\sym s}',str];
%		elseif strcmp('varsigma',cmd),   str = ['{\sym V}',str];
%		elseif strcmp('tau',cmd),        str = ['{\sym t}',str];
%		elseif strcmp('upsilon',cmd),    str = ['{\sym u}',str];
%		elseif strcmp('phi',cmd),        str = ['{\sym f}',str];
%		elseif strcmp('varphi',cmd),     str = ['{\sym j}',str];
%		elseif strcmp('chi',cmd),        str = ['{\sym c}',str];
%		elseif strcmp('psi',cmd),        str = ['{\sym y}',str];
%		elseif strcmp('omega',cmd),      str = ['{\sym w}',str];
%		
%		% Uppercase Greek letters.
%		elseif strcmp('Gamma',cmd),      str = ['{\sym G}',str];
%		elseif strcmp('Delta',cmd),      str = ['{\sym D}',str];
%		elseif strcmp('Theta',cmd),      str = ['{\sym Q}',str];
%		elseif strcmp('Lambda',cmd),     str = ['{\sym L}',str];
%		elseif strcmp('Xi',cmd),         str = ['{\sym X}',str];
%		elseif strcmp('Pi',cmd),         str = ['{\sym P}',str];
%		elseif strcmp('Sigma',cmd),      str = ['{\sym S}',str];
%		elseif strcmp('Upsilon',cmd),    str = ['{\sym',161,'}',str];
%		elseif strcmp('varUpsilon',cmd), str = ['{\sym U}',str];
%		elseif strcmp('Phi',cmd),        str = ['{\sym F}',str];
%		elseif strcmp('Psi',cmd),        str = ['{\sym Y}',str];
%		elseif strcmp('Omega',cmd),      str = ['{\sym W}',str];
%		
%		% Other LaTeX characters.
%		elseif strcmp('forall',cmd),         str = ['{\sym',34,'}',str];
%		elseif strcmp('exists',cmd),         str = ['{\sym',36,'}',str];
%		elseif strcmp('cong',cmd),           str = ['{\sym',64,'}',str];
%		elseif strcmp('perp',cmd),           str = ['{\sym\^}',str];
%		elseif strcmp('bot',cmd),            str = ['{\sym\^}',str];
%		elseif strcmp('leq',cmd),            str = ['{\sym',163,'}',str];
%		elseif strcmp('infty',cmd),          str = ['{\sym',165,'}',str];
%		elseif strcmp('leftrightarrow',cmd), str = ['{\sym',171,'}',str];
%		elseif strcmp('leftarrow',cmd),      str = ['{\sym',172,'}',str];
%		elseif strcmp('uparrow',cmd),        str = ['{\sym',173,'}',str];
%		elseif strcmp('rightarrow',cmd),     str = ['{\sym',174,'}',str];
%		elseif strcmp('downarrow',cmd),      str = ['{\sym',175,'}',str];
%		elseif strcmp('degrees',cmd),        str = ['{\sym',176,'}',str];
%		elseif strcmp('pm',cmd),             str = ['{\sym',177,'}',str];
%		elseif strcmp('geq',cmd),            str = ['{\sym',179,'}',str];
%		elseif strcmp('propto',cmd),         str = ['{\sym',181,'}',str];
%		elseif strcmp('partial',cmd),        str = ['{\sym',182,'}',str];
%		elseif strcmp('bullet',cmd),         str = ['{\sym',183,'}',str];
%		elseif strcmp('div',cmd),            str = ['{\sym',184,'}',str];
%		elseif strcmp('neq',cmd),            str = ['{\sym',185,'}',str];
%		elseif strcmp('equiv',cmd),          str = ['{\sym',186,'}',str];
%		elseif strcmp('approx',cmd),         str = ['{\sym',187,'}',str];
%		elseif strcmp('dots',cmd),           str = ['{\sym',188,'}',str];
%		elseif strcmp('aleph',cmd),          str = ['{\sym',192,'}',str];
%		elseif strcmp('Im',cmd),             str = ['{\sym',193,'}',str];
%		elseif strcmp('Re',cmd),             str = ['{\sym',194,'}',str];
%		elseif strcmp('wp',cmd),             str = ['{\sym',195,'}',str];
%		elseif strcmp('otimes',cmd),         str = ['{\sym',196,'}',str];
%		elseif strcmp('oplus',cmd),          str = ['{\sym',197,'}',str];
%		elseif strcmp('emptyset',cmd),       str = ['{\sym',198,'}',str];
%		elseif strcmp('cap',cmd),            str = ['{\sym',199,'}',str];
%		elseif strcmp('cup',cmd),            str = ['{\sym',200,'}',str];
%		elseif strcmp('supset',cmd),         str = ['{\sym',201,'}',str];
%		elseif strcmp('supseteq',cmd),       str = ['{\sym',202,'}',str];
%		elseif strcmp('notsubset',cmd),      str = ['{\sym',203,'}',str];
%		elseif strcmp('subset',cmd),         str = ['{\sym',204,'}',str];
%		elseif strcmp('subseteq',cmd),       str = ['{\sym',205,'}',str];
%		elseif strcmp('in',cmd),             str = ['{\sym',206,'}',str];
%		elseif strcmp('notin',cmd),          str = ['{\sym',207,'}',str];
%		elseif strcmp('angle',cmd),          str = ['{\sym',208,'}',str];
%		elseif strcmp('nabla',cmd),          str = ['{\sym',209,'}',str];
%		elseif strcmp('surd',cmd),           str = ['{\sym',214,'}',str];
%		elseif strcmp('cdot',cmd),           str = ['{\sym',215,'}',str];
%		elseif strcmp('neg',cmd),            str = ['{\sym',216,'}',str];
%		elseif strcmp('lnot',cmd),           str = ['{\sym',216,'}',str];
%		elseif strcmp('land',cmd),           str = ['{\sym',217,'}',str];
%		elseif strcmp('lor',cmd),            str = ['{\sym',218,'}',str];
%		elseif strcmp('Leftrightarrow',cmd), str = ['{\sym',219,'}',str];
%		elseif strcmp('Leftarrow',cmd),      str = ['{\sym',220,'}',str];
%		elseif strcmp('Uparrow',cmd),        str = ['{\sym',221,'}',str];
%		elseif strcmp('Rightarrow',cmd),     str = ['{\sym',222,'}',str];
%		elseif strcmp('Downarrow',cmd),      str = ['{\sym',223,'}',str];
%		elseif strcmp('diamond',cmd),        str = ['{\sym',224,'}',str];
%		elseif strcmp('langle',cmd),         str = ['{\sym',225,'}',str];
%		elseif strcmp('lceil',cmd),          str = ['{\sym',233,'}',str];
%		elseif strcmp('lfloor',cmd),         str = ['{\sym',235,'}',str];
%		elseif strcmp('vert',cmd),           str = ['{\sym',239,'}',str];
%		elseif strcmp('rangle',cmd),         str = ['{\sym',241,'}',str];
%		elseif strcmp('rceil',cmd),          str = ['{\sym',249,'}',str];
%		elseif strcmp('rfloor',cmd),         str = ['{\sym',251,'}',str];
%		elseif strcmp('AA',cmd),             str = [accents(10),str];
%		elseif strcmp('ii',cmd),             str = [accents(11),str];
%		
%		elseif strcmp('Vert',cmd),     str = ['{\sym',[247,231],'}',str];
%		
%		elseif strcmp('{',cmd),              str = ['{' + 256,str];
%		elseif strcmp('}',cmd),              str = ['}' + 256,str];
%		elseif strcmp('\',cmd),              str = ['\' + 256,str];
%		elseif strcmp('^',cmd),              str = ['^' + 256,str];
%		elseif strcmp('_',cmd),              str = ['_' + 256,str];
%		
%		% Non-LaTeX characters and LaTeX-like constructs that don't work
%		% quite like they do in LaTeX.
%		elseif strcmp('+',cmd),         str = ['{\sym+}',str];
%		elseif strcmp('-',cmd),         str = ['{\sym-}',str];
%		elseif strcmp('=',cmd),         str = ['{\sym=}',str];
%		elseif strcmp('>',cmd),         str = ['{\sym>}',str];
%		elseif strcmp('<',cmd),         str = ['{\sym<}',str];
%		elseif strcmp('|',cmd),         str = ['{\sym|}',str];
%		elseif strcmp('therefore',cmd), str = ['{\sym\\}',str];
%		elseif strcmp('prime',cmd),     str = ['{\sym',162,'}',str];
%		elseif strcmp('dprime',cmd),    str = ['{\sym',178,'}',str];
%		elseif strcmp('mult',cmd),      str = ['{\sym',180,'}',str];
%		elseif strcmp('horiz',cmd),     str = ['{\sym',190,'}',str];
%		
%		% Spaces.
%		elseif strcmp('/',cmd),         str = ['\rright{0.07}',str];
%		elseif strcmp(',',cmd),         str = ['\rright{0.125}',str];
%		elseif strcmp(':',cmd),         str = ['\rright{0.1667}',str];
%		elseif strcmp(';',cmd),         str = ['\rright{0.2083}',str];
%		
%		% ASCII code.
%		elseif strcmp('#',cmd)
%			[arg1,str] = getcargs(str);
%			str = [setstr(sscanf(arg1,'%d')),str];
%		
%		% Diacritics.
%		elseif strcmp('grave',cmd)
%			accent = accents(1);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('acute',cmd)
%			accent = accents(2);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('ddot',cmd)
%			accent = accents(3);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('hat',cmd)
%			accent = accents(4);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('tilde',cmd)
%			accent = accents(5);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('bar',cmd)
%			accent = accents(6);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('breve',cmd)
%			accent = accents(7);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('dot',cmd)
%			accent = accents(8);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('check',cmd)
%			accent = accents(9);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Grave',cmd)
%			accent = accents(1);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Acute',cmd)
%			accent = accents(2);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Ddot',cmd)
%			accent = accents(3);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Hat',cmd)
%			accent = accents(4);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Tilde',cmd)
%			accent = accents(5);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Bar',cmd)
%			accent = accents(6);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Breve',cmd)
%			accent = accents(7);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Dot',cmd)
%			accent = accents(8);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Check',cmd)
%			accent = accents(9);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('pushx',cmd)
%			xstack = [params([x;nextX]),xstack];
%		
%		elseif strcmp('popx',cmd)
%			if size(xstack,2) < 1
%				delete(objList)
%				delete(anchor)
%				error('Stack empty.')
%			end
%			params(x) = xstack(1);
%			params(nextX) = xstack(2);
%			xstack(:,1) = [];
%		
%		elseif strcmp('swapx',cmd)
%			if size(xstack,2) < 2
%				delete(objList)
%				delete(anchor)
%				error('Stack does not contain at least two items.')
%			end
%			temp = xstack(:,1);
%			xstack(:,[1,2]) = xstack(:,[2,1]);
%		
%		else
%			% Command is unknown.
%			delete(objList)
%			delete(anchor)
%			error(['Unrecognized command: ',cmd])
%		
%		end
%	else
%		% str(1) is not one of '{}^_\' so it must be the beginning of text.
%		params(x) = params(nextX);
%		params(mode) = 0;
%		[newStr,str] = strtok(str,'\{}^_');
%		newStr = setstr(rem(newStr,256));
%		newStr1 = newStr + 1;
%		
%		% Compute character widths.
%		strLen = length(newStr);
%		fmSel = fm(params(fn),colLut(params(fa),params(fw)));
%		if fmSel > 2
%			encSel = es;
%		else
%			encSel = fmSel;
%		end
%		fontOffset = 1000*(fmSel - 2);
%		widths = gFONT_METRICS(gENCODING(newStr1,encSel),fmSel) * ...
%				round(params(fs))/1000;
%		
%		% Increase widths by 4.5% if Symbol-Bold.
%		if params(fn) == 1 & params(fw) == 4
%			widths = 1.045*widths;
%		end
%		
%		lastWidth = widths(length(widths));
%		
%		% Compute kern correction, kc.
%		kc = zeros(strLen-1,1);
%		if fmSel > 2
%			for k = 1:strLen-1
%				kc(k) = gKERNING_DATA(fontOffset + gENCODING(newStr1(k),...
%						encSel),gENCODING(newStr1(k+1),encSel));
%			end
%			kc = kc*round(params(fs))/1000;
%		end
%		
%		xx = params(x) + cumsum([0;widths((1:strLen-1)') + kc]);
%		yy = params(y(ones(strLen,1)));
%		lastxx = xx(strLen);
%		
%		% Add shifted versions of the characters if they are Symbol-Bold.
%		% Total width increase is 4.5%.
%		if params(fn) == 1 & params(fw) == 4
%			xsh = 0.015*round(params(fs));
%			xx = [xx;xx + xsh;xx + 2*xsh;xx + 3*xsh];
%			yy = [yy;yy;yy;yy];
%			newStr = [newStr,newStr,newStr,newStr];
%			strLen = length(newStr);
%			params(fw) = 2;
%		end
%		
%		% Prepend invisible characters if Symbol italic or oblique.  This
%		% can be detected in the PostScript file so that it can be modified
%		% to produce slanted Symbol characters.
%		if params(fn) == 1 & params(fa) > 1
%			if ~slantTagged
%				xx = [0;0;0;xx];
%				yy = [0;0;0;yy];
%				newStr = setstr([9,9,9,newStr]);
%				strLen = length(newStr);
%				slantTagged = 1;
%			end
%		else
%			slantTagged = 0;
%		end
%		
%		if strLen == 1
%			newObj = text('Position',  [xx,yy],...
%					'String',              newStr,...
%					'FontAngle',           fontanglelist(params(fa),:),...
%					'FontName',            deblank(fontnamelist(params(fn),:)),...
%					'FontSize',            round(params(fs)),...
%					'FontWeight',          fontweightlist(params(fw),:),...
%					'Units',               'points',...
%					'Rotation',            0,...
%					'HorizontalAlignment', 'left',...
%					'VerticalAlignment',   'baseline',...
%					'Color',               params(cr:cb),...
%					'EraseMode',           eraseMode,...
%					'ButtonDownFcn',       buttonDownFcn,...
%					'Clipping',            clipping,...
%					'Interruptible',       interruptible,...
%					'Visible',             visible);
%		else
%			newObj = text(xx,yy,newStr',...
%					'FontAngle',           fontanglelist(params(fa),:),...
%					'FontName',            deblank(fontnamelist(params(fn),:)),...
%					'FontSize',            round(params(fs)),...
%					'FontWeight',          fontweightlist(params(fw),:),...
%					'Units',               'points',...
%					'Rotation',            0,...
%					'HorizontalAlignment', 'left',...
%					'VerticalAlignment',   'baseline',...
%					'Color',               params(cr:cb),...
%					'EraseMode',           eraseMode,...
%					'ButtonDownFcn',       buttonDownFcn,...
%					'Clipping',            clipping,...
%					'Interruptible',       interruptible,...
%					'Visible',             visible);
%		end
%		if ver5, set(newObj,'Interpreter','none'), end
%		objList = [objList,newObj'];
%		heightList = [heightList,yy'];
%		xDistance = [xDistance,xx'];
%		params(nextX) = lastxx + lastWidth;
%		params(x) = params(nextX);
%		
%		% The vertical position of the styled text is based on the first
%		% character of the text.
%		if first
%			if cmdmatch('top',vertAlign)
%				va = 1;
%			elseif cmdmatch('cap',vertAlign)
%				va = 2;
%			elseif cmdmatch('middle',vertAlign)
%				va = 3;
%			elseif cmdmatch('baseline',vertAlign)
%				va = 4;
%			elseif cmdmatch('bottom',vertAlign)
%				va = 5;
%			end
%			hOffset = -gVAL(fmSel,va)*round(params(fs));
%			first = 0;
%		end
%	end
%end
%totalWidth = params(nextX);
%numSegments = length(objList);
%
%% Compute new x and y locations for each text object based on
%% justification and rotation.
%r = rotation*pi/180;
%if cmdmatch('left',horizAlign)
%	t = 0;
%elseif cmdmatch('center',horizAlign)
%	t = totalWidth/2;
%elseif cmdmatch('right',horizAlign)
%	t = totalWidth;
%end
%xList = x0 + (xDistance - t)*cos(r) - (heightList + hOffset)*sin(r);
%yList = y0 + (xDistance - t)*sin(r) + (heightList + hOffset)*cos(r);
%
%for i = 1:numSegments
%	set(objList(i),'Position',[xList(i),yList(i)],'Rotation',rotation);
%end
%
%% Anchor text object is invisible, but by setting the rotation we can
%% use get(stext object handle).  UserData contains a type flag (0 =
%% normal, 1 = x-label, 2 = y-label, 3 = z-label, 4 = title), the
%% location of the anchor object in points and a list of the handles
%% to the text objects that make up the styled text object.
%
%set(anchor,'Rotation',rotation,'UserData',[0,x0,y0,objList])
%delete(oldObjList)
%
%% Restore current axes.
%set(fig,'CurrentAxes',currentAxes)
fclose(fout);

disp(' ## Installing: "slegend.m" (text)')
fout = fopen('slegend.m', 'w');
%function [leg,hl,h] = slegend(xy,specs,strs,p1,v1,p2,v2,...
%		p3,v3,p4,v4,p5,v5,p6,v6,p7,v7)
%%SLEGEND Styled text legend.
%%	SLEGEND(XY,SMPLSPEC,LEGENDTEXT) places a legend centered at XY =
%%	[X,Y] on the current figure, where X and Y are in normalized figure
%%	units.  LEGENDTEXT is a string matrix (see STR2MAT) which specifies
%%	the text of the legend.  The legend text is produced with STEXT and
%%	so each row of LEGENDTEXT must be valid styled text.  SMPLSPEC can be
%%	a string matrix of plot symbols and colors as with PLOT.  An additional
%%	plot symbol is '#' which specifies a sample patch.  Valid values for
%%	the rows of SMPLSPEC are '-', '--r', 'c+', '#y', etc.  SMPLSPEC can
%%	also be a vector of handles to line or patch objects, in which case
%%	the characteristics of the line or patch samples are copied from
%%	those objects.
%%	
%%	XY = 'mouse' allows dragging the slegend to the desired location with
%%	the mouse.  The slegend can be locked in position by pressing the
%%	space bar while holding down the mouse button.  SLEGEND('move') or
%%	SLEGEND('mouse') will make all slegends and stextboxes in the current
%%	figure movable.
%%
%%	XY, SMPLSPEC and LEGENDTEXT can be followed by property/value pairs
%%	to specify additional properties of the slegend:
%%	
%%	Property = 'Color', value = [ {none} ] -or- a ColorSpec
%%		allows you to specify the background color of the slegend.  If
%%		the color is 'none', the box will be transparent.  When printed,
%%		slegends are placed on top of other axes and opaque slegends will
%%		obscure whatever is behind them.
%%	
%%	Property = 'HorizontalAlignment', value = [ left | {center} | right ]
%%		controls the horizontal alignment of the slegend with respect to XY.
%%
%%	Property = 'VerticalAlignment', value = [ top | {middle} | bottom ]
%%		controls the vertical alignment of the slegend with respect to XY.
%%
%%	Property = 'Box', value = [ {on} | off ]
%%		allows you to control whether the enclosing box is visible.
%%	
%%	Property = 'BorderFactor', value = [ {0.25} | <any positive number> ]
%%		sets the amount of space between the slegend and the enclosing
%%		box as a fraction of the height of the tallest line of text.
%%	
%%	Property = 'SampleWidth', value = [ {30} | <any positive number> ]
%%		sets the width in points of the line samples.
%%
%%	Property = 'Spacing', value = [ tight | {loose} | <any positive number>]
%%		controls the line spacing of the text.  Tight spacing moves the
%%		lines as close together as possible, loose spacing makes all
%%		lines equally spaced and equal to the height of the tallest line.
%%		Setting this to a number specifies tight spacing scaled by the
%%		amount specified.  For example, 1 => normal tight spacing,
%%		0.5 => lines compressed to 50% of normal.
%%	
%%	
%%	[H,HLINES,HTEXT] = SLEGEND(...) returns a handle to the legend axes
%%	object, handles to the line samples and handles to the legend text.
%%	Since a legend is an axes object it is possible to make changes to
%%	its properties, e.g., changing the 'LineWidth' of the border.
%%
%%	A figure containing an SLEGEND must be printed with PRINTSTO.
%%
%%	See also STEXT, STEXTBOX, PRINTSTO, STR2MAT and PLOT.
%
%%	Requires functions STEXT, GETSTEXT and MOVE1STO.
%%	Requires MATLAB Version 4.2 or greater.
%
%%	Version 3.2b, 2 July 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%if nargin > 1
%	% Set defaults.
%	mouse = 0;
%	legColor = 'none';
%	horiz = 0.5;
%	vert = 0.5;
%	ref = [0.5,0.5];
%	box = 'on';
%	borderFactor = 0.25;
%	sampleWid = 30;
%	tightSpacing = 0;
%	numOptions = (nargin - 3)/2;
%	baseAxes = gca;
%	ver5 = cmdmatch(version,'5');
%	
%	if isstr(xy)
%		if strcmp(lower(xy),'mouse')
%			mouse = 1;
%			xy = [0.5,0.5];
%		else
%			error('Unknown position option.')
%		end
%	else
%		if length(xy) ~= 2
%			error('The position must be a 2-element vector')
%		end
%	end
%	
%	for i = 1:numOptions
%		property = lower(eval(sprintf('p%d',i)));
%		value = lower(eval(sprintf('v%d',i)));
%		
%		if cmdmatch('color',property)
%			legColor = value;
%		
%		elseif cmdmatch('horizontalalignment',property)
%			horiz = value;
%		
%		elseif cmdmatch('verticalalignment',property)
%			vert = value;
%		
%		elseif cmdmatch('box',property)
%			box = value;
%		
%		elseif cmdmatch('borderfactor',property)
%			borderFactor = value;
%		
%		elseif cmdmatch('samplewidth',property)
%			sampleWid = value;
%		
%		elseif cmdmatch('spacing',property)
%			if isstr(value)
%				if cmdmatch('tight',value)
%					tightSpacing = 1;
%				elseif cmdmatch('loose',value)
%					tightSpacing = 0;
%				else
%					error('Invalid data for slegend parameter "Spacing".')
%				end
%			else
%				tightSpacing = value;
%			end
%		
%		else
%			error('Unknown property.')
%		end
%	end
%	
%	if isstr(horiz)
%		if cmdmatch('left',horiz)
%			ref(1) = 0;
%		elseif cmdmatch('right',horiz)
%			ref(1) = 1;
%		elseif cmdmatch('center',horiz)
%			ref(1) = 0.5;
%		else
%			error('Invalid data for slegend parameter "HorizontalAlignment".')
%		end
%	else
%		ref(1) = horiz;
%	end
%	
%	if isstr(vert)
%		if cmdmatch('bottom',vert)
%			ref(2) = 0;
%		elseif cmdmatch('top',vert)
%			ref(2) = 1;
%		elseif cmdmatch('middle',vert)
%			ref(2) = 0.5;
%		else
%			error('Invalid data for slegend parameter "VerticalAlignment".')
%		end
%	else
%		ref(2) = vert;
%	end
%	
%	% Create the legend axes and contents.
%	ax = axes('Units','norm','Position',[xy,0.5,0.5],...
%			'XTick',[],'YTick',[],'Box','on','Color',legColor);
%	if strcmp(box,'off')
%		if strcmp(legColor,'none')
%			set(ax,'Visible','off')
%		else
%			set(ax,'XColor',legColor,'YColor',legColor,'ZColor',legColor)
%		end
%	end
%	
%	set(ax,'Units','points')
%	xy2 = get(ax,'Position');
%	xy2(3:4) = [];
%	n = min(size(specs,1),size(strs,1));
%	h = zeros(n,1);
%	exts = zeros(n,4);
%	for i = 1:n
%		cmd = ['stext(0,0,deblank(strs(i,:)),''units'',''points'',',...
%				'''hor'',''left'',''vert'',''mid'')'];
%		h(i) = eval(cmd,'-1');
%		if h(i) == -1
%			delete(ax)
%			error(lasterr)
%		end
%		exts(i,:) = getstext(h(i),'Extent');
%	end
%	
%	% Compute the size of the axes based on the contents.
%	maxht = max(exts(:,4));
%	maxdrop = min(exts(:,2));
%	border = maxht*borderFactor;
%	hgap = 0.25*maxht;
%	if tightSpacing
%		yvals = flipud([0;cumsum(exts(n:-1:2,4))])*tightSpacing ...
%				- exts(:,2) + border;
%		top = yvals(1) + exts(1,4) + exts(1,2) + border + 1;
%	else
%		yvals = flipud(maxht*(0:(n-1))') - min(exts(:,2)) + border;
%		top = yvals(1) + maxht + maxdrop + border + 1;
%	end
%	left = sampleWid + 2*border + hgap;
%	right = left + max(exts(:,3)) + 2*border;
%	
%	% Move the contents to their final positions and set the new size
%	% for the legend axes.
%	for i = 1:n
%		delta = yvals(i);
%		userData = get(h(i),'UserData');
%		userData(3) = userData(3) + delta;
%		set(h(i),'Position',[0,delta])
%		set(h(i),'UserData',userData)
%		move1sto(h(i),[left,delta])
%	end
%	pos = get(ax,'Position');
%	xy3 = xy2 - [right,top].*ref;
%	set(ax,'Position',[xy3,right,top],...
%			'XLim',[0 right],'YLim',[0 top])
%	
%	% Plot the line type samples.
%	hl = zeros(n,1);
%	if isstr(specs)
%		for i = 1:n
%			lt = deblank(specs(i,:));
%			color = get(0,'DefaultTextColor');
%			colorSpec = lt == 'r' | lt == 'g' | lt == 'b' | lt == 'c' ...
%					| lt == 'm' | lt == 'y' | lt == 'w' | lt == 'k';
%			if any(colorSpec), color = lt(colorSpec); end
%			lt(colorSpec) = [];
%			if strcmp(lt,'-') | strcmp(lt,'--') | strcmp(lt,'-.') ...
%					| strcmp(lt,':')
%				x = [0,sampleWid] + 2*border;
%				y = [1,1]*yvals(i);
%				hl(i) = line(x,y,'LineStyle',lt,'Color',color);
%			elseif strcmp(lt,'#')
%				x = [-1 1 1 -1]*sampleWid/3 + 2*border + sampleWid/2;
%				y = [-1 -1 1 1]*maxht/3 + yvals(i);
%				hl(i) = patch(x,y,'r','FaceColor',color);
%			else
%				if ver5
%					hl(i) = line(2*border+sampleWid/2,yvals(i),...
%							'LineStyle','none','Marker',lt,'Color',color);
%				else
%					hl(i) = line(2*border+sampleWid/2,yvals(i),...
%							'LineStyle',lt,'Color',color);
%				end
%			end
%		end
%	else
%		for i = 1:n
%			objType = get(specs(i),'Type');
%			if strcmp(objType,'line')
%				if ver5
%					lt = get(specs(i),'LineStyle');
%					mt = get(specs(i),'Marker');
%					tmpl = 0;
%					tmpm = 0;
%					if ~strcmp(lt,'none')
%						tmpl = line([0,sampleWid]+2*border,[1 1]*yvals(i),...
%								'LineStyle',lt,...
%								'Marker','none',...
%								'LineWidth',get(specs(i),'LineWidth'),...
%								'Color',get(specs(i),'Color'));
%					end
%					if ~strcmp(mt,'none')
%						tmpm = line(2*border+sampleWid/2,yvals(i),...
%								'LineStyle','none',...
%								'Marker',mt,...
%								'LineWidth',get(specs(i),'LineWidth'),...
%								'MarkerSize',get(specs(i),'MarkerSize'),...
%								'MarkerEdgeColor',...
%								get(specs(i),'MarkerEdgeColor'),...
%								'MarkerFaceColor',...
%								get(specs(i),'MarkerFaceColor'),...
%								'Color',get(specs(i),'Color'));
%					end
%					if tmpl
%						hl(i) = tmpl;
%					else
%						hl(i) = tmpm;
%					end
%				else
%					lt = get(specs(i),'LineStyle');
%					if strcmp(lt,'-') | strcmp(lt,'--') | strcmp(lt,'-.') ...
%							| strcmp(lt,':')
%						hl(i) = line([0,sampleWid]+2*border,[1 1]*yvals(i),...
%								'LineStyle',lt,...
%								'LineWidth',get(specs(i),'LineWidth'),...
%								'MarkerSize',get(specs(i),'MarkerSize'),...
%								'Color',get(specs(i),'Color'));
%					else
%						hl(i) = line(2*border+sampleWid/2,yvals(i),...
%								'LineStyle',lt,...
%								'LineWidth',get(specs(i),'LineWidth'),...
%								'MarkerSize',get(specs(i),'MarkerSize'),...
%								'Color',get(specs(i),'Color'));
%					end
%				end
%			elseif strcmp(objType,'patch')
%				x = [-1 1 1 -1]*sampleWid/3 + 2*border + sampleWid/2;
%				y = [-1 -1 1 1]*maxht/3 + yvals(i);
%				hl(i) = patch(x,y,'r',...
%						'FaceColor',get(specs(i),'FaceColor'),...
%						'EdgeColor',get(specs(i),'EdgeColor'),...
%						'LineWidth',get(specs(i),'LineWidth'));
%			else
%				delete(ax)
%				error(['Illegal object of type ''',objType,'''.'])
%			end
%		end
%	end
%	
%	% Save some needed data and enable legend dragging.
%	userData = [xy,ref];
%	if mouse
%		set(ax,'Tag','slegend movable','UserData',userData)
%		set(gcf,'WindowButtonDownFcn','slegend(1)')
%	else
%		set(ax,'Tag','slegend','UserData',userData)
%	end
%	set(gcf,'CurrentAxes',baseAxes)
%	
%	if nargout > 0
%		leg = ax;
%	end
%	
%elseif isstr(xy)
%	xy = lower(xy);
%	if strcmp(xy,'move') | strcmp(xy,'mouse')
%		fig = get(0,'CurrentFigure');
%		fixed = findobj(fig,'Tag','slegend');
%		nf = length(fixed);
%		nm = length(findobj(fig,'Tag','slegend movable'));
%		for i = 1:nf
%			set(fixed(i),'Tag','slegend movable')
%		end
%		if nf + nm > 0
%			set(gcf,'WindowButtonDownFcn','slegend(1)')
%		end
%	else
%		error('Unknown command.')
%	end
%
%% We have a mouse-down on a legend.
%elseif xy == 1
%	fig = get(0,'CurrentFigure');
%	% Uncomment the following line to require holding down the control key
%	% (or option on a Mac) while clicking the mouse to move a legend.
%	%if ~strcmp(get(fig,'SelectionType'),'alt'), return, end
%	curAx = get(fig,'CurrentAxes');
%	
%	figUnits = get(fig,'Units');
%	figPos = get(fig,'Position');
%	set(fig,'Units','points')
%	cp = get(fig,'CurrentPoint');
%	
%	% Find the legend closest to current point.
%	movLeg = findobj(fig,'Tag','slegend movable');
%	n = length(movLeg);
%	if n == 0
%		set(fig,'Units',figUnits,'Position',figPos,'WindowButtonDownFcn','')
%		return
%	end
%	d2 = zeros(n,1);
%	for i = 1:n
%		pos = get(movLeg(i),'Position');
%		d = cp - pos(1:2);
%		d2(i) = d*d';
%	end
%	[junk,closest] = min(d2);
%	theLeg = movLeg(closest);
%	
%	userData = get(theLeg,'UserData');
%	set(theLeg,'UserData',[userData(1:4),cp,real(figUnits)],...
%			'Tag','slegend moving')
%	set(fig,'CurrentAxes',theLeg,'CurrentAxes',curAx,...
%			'WindowButtonMotionFcn','slegend(2)',...
%			'WindowButtonUpFcn','slegend(3)',...
%			'KeyPressFcn','slegend(4)',...
%			'pointer','fleur')
%
%% Moving a legend.
%elseif xy == 2
%	fig = get(0,'CurrentFigure');
%	theLeg = findobj(fig,'Tag','slegend moving');
%	userData = get(theLeg,'UserData');
%	cp = userData(5:6);
%	newp = get(fig,'CurrentPoint');
%	userData(5:6) = newp;
%	delta = newp - cp;
%	pos = get(theLeg,'Position');
%	pos(1:2) = pos(1:2) + delta;
%	set(theLeg,'Position',pos,'UserData',userData)
%
%% We have a mouse-up on a legend.
%elseif xy == 3
%	fig = get(0,'CurrentFigure');
%	theLeg = findobj(fig,'Tag','slegend moving');
%	userData = get(theLeg,'UserData');
%	set(theLeg,'Units','norm')
%	pos = get(theLeg,'Position');
%	set(theLeg,'Units','points')
%	ref = userData(3:4);
%	userData(1:2) = pos(1:2) + ref.*pos(3:4);
%	set(theLeg,'UserData',userData,'Tag','slegend movable')
%	figUnits = setstr(userData(7:length(userData)));
%	set(fig,'Units',figUnits,'pointer','arrow',...
%			'WindowButtonMotionFcn','','WindowButtonUpFcn','',...
%			'KeyPressFcn','')
%
%% We are locking the position of a legend.
%elseif xy == 4
%	fig = get(0,'CurrentFigure');
%	theLeg = findobj(fig,'Tag','slegend moving');
%	if get(fig,'CurrentCharacter') == ' '
%		if length(findobj(fig,'Tag','slegend movable')) == 0
%			set(fig,'WindowButtonDownFcn','')
%		end
%		userData = get(theLeg,'UserData');
%		set(theLeg,'Units','norm')
%		pos = get(theLeg,'Position');
%		set(theLeg,'Units','points')
%		ref = userData(3:4);
%		userData(1:2) = pos(1:2) + ref.*pos(3:4);
%		set(theLeg,'UserData',userData,'Tag','slegend')
%		figUnits = setstr(userData(7:length(userData)));
%		set(fig,'Units',figUnits,'pointer','arrow',...
%				'WindowButtonMotionFcn','','WindowButtonUpFcn','',...
%				'KeyPressFcn','')
%	end
%end
fclose(fout);

disp(' ## Installing: "spreview.m" (text)')
fout = fopen('spreview.m', 'w');
%function spreview(sel)
%%SPREVIEW GUI application to preview styled text objects.
%%	SPREVIEW will create a new figure which contains an edit box in
%%	which styled text can be typed and an axes to display the resulting
%%	styled text object.  This can be used to construct styled text
%%	objects, especially complicated ones.
%%
%%	SPREVIEW(STYLEDTEXT) uses the styled text in STYLEDTEXT as the
%%	initial contents of the edit box.
%%
%%	See also STEXT.
%
%%	Requires functions STEXT and FIXSTEXT.
%%	Requires MATLAB Version 4.2 or greater.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%if nargin == 0
%	sel = 0;
%	s = '';
%elseif nargin == 1
%	if isstr(sel)
%		s = sel;
%		sel = 0;
%	end
%end
%
%if sel == 0
%	this = mfilename;
%	fig = figure('Number','off','Name',this);
%	set(fig,'Units','pixels')
%	figpos = get(fig,'Position');
%	
%	framePos = [16,16,figpos(3)-32,68];
%	editPos = [20,20,figpos(3)-40,40];
%	textPos = [20,60,figpos(3)-40,20];
%	makePos = [figpos(3)-150,62,40,20];
%	clearPos = [figpos(3)-106,62,40,20];
%	savePos = [figpos(3)-62,62,40,20];
%	axPos = [17,92,figpos(3)-32,figpos(4)-98];
%	
%	hf = uicontrol('Style','frame',...
%			'Units','pixels',...
%			'Position',framePos);
%	he = uicontrol('Style','edit',...
%			'Units','pixels',...
%			'Position',editPos,...
%			'String',s,...
%			'Horiz','left',...
%			'CallBack',[this,'(1)']);
%	ht = uicontrol('Style','text',...
%			'Units','pixels',...
%			'Position',textPos,...
%			'String','Type styled text here and press Make or RETURN:',...
%			'Horiz','left');
%	hm = uicontrol('Style','pushbutton',...
%			'Units','pixels',...
%			'Position',makePos,...
%			'String','Make',...
%			'CallBack',[this,'(1)']);
%	hc = uicontrol('Style','pushbutton',...
%			'Units','pixels',...
%			'Position',clearPos,...
%			'String','Clear',...
%			'CallBack','cla');
%	hs = uicontrol('Style','pushbutton',...
%			'Units','pixels',...
%			'Position',savePos,...
%			'String','Save',...
%			'CallBack','get(findobj(gcf,''Style'',''edit''),''String'')');
%	ax = axes('Units','pixels',...
%			'Position',axPos,...
%			'XTick',[],'YTick',[],...
%			'Box','on',...
%			'XLim',[0 1],'YLim',[0 1]);
%	set(fig,'UserData',[hf he ht hm hc hs ax])
%	eval(['set(fig,''ResizeFcn'',''',this,'(2)'')'],'')
%	
%% Pressed RETURN or Make, create new styled text.
%elseif sel == 1
%	fig = gcf;
%	cla
%	refresh
%	h = get(fig,'UserData');
%	str = get(h(2),'String');
%	stext(.5,.5,str,'Horiz','center');
%
%% Resizing the figure.
%elseif sel == 2
%	fig = gcf;
%	figpos = get(fig,'Position');
%	
%	framePos = [16,16,figpos(3)-32,68];
%	editPos = [20,20,figpos(3)-40,40];
%	textPos = [20,60,figpos(3)-40,20];
%	makePos = [figpos(3)-150,62,40,20];
%	clearPos = [figpos(3)-106,62,40,20];
%	savePos = [figpos(3)-62,62,40,20];
%	axPos = [17,92,figpos(3)-32,figpos(4)-98];
%	
%	h = get(fig,'UserData');
%	
%	set(h(1),'Position',framePos)
%	set(h(2),'Position',editPos)
%	set(h(3),'Position',textPos)
%	set(h(4),'Position',makePos)
%	set(h(5),'Position',clearPos)
%	set(h(6),'Position',savePos)
%	set(h(7),'Position',axPos)
%	
%	fixstext
%end
fclose(fout);

disp(' ## Installing: "stext.m" (text)')
fout = fopen('stext.m', 'w');
%function output = stext(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,...
%		a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28)
%%STEXT Add Styled Text to the current plot.
%%	STEXT(X,Y,'string') adds the styled text in the quotes to location
%%	(X,Y) on the current axes in a manner similar to the TEXT function.
%%	Most of the same property/value pairs that can be used with TEXT
%%	will work with STEXT.  The styling information is embedded in the
%%	string in the form of commands which are preceeded by backslashes
%%	and terminated by a space, another backslash or a brace.  The
%%	commands control font, font size, font angle, font weight, color,
%%	superscript and subscript attributes.  A command is normally
%%	applied to all subsequent text except that temporary changes can be
%%	assigned inside curly braces.  Font names and style changing
%%	commands can be abbreviated.  Also, many characters from the Symbol
%%	font can be produced by using backslash names (mostly the same
%%	names used in LaTeX).
%%
%%	Command Summary
%%	\<font size>   \bigger   \larger   \smaller
%%	\<font name>
%%	\italic   \oblique   \light   \demi   \bold   \normal
%%	^{<text>}   _{<text>}
%%	\black  \white  \red  \green  \blue  \cyan  \magenta  \yellow  \gray
%%	\color{<R>,<G>,<B>}
%%	\left{<x>}    \right{<x>}    \up{<x>}    \down{<x>}
%%	\rleft{<x>}   \rright{<x>}   \rup{<x>}   \rdown{<x>}
%%	\\    \{    \}    \^    \_    \=    \+    \-    \<    \<    \#{}
%%
%%	Character Summary
%%	\<letter>, e.g., \alpha to produce lowercase Greek letters
%%	\<Letter>, e.g., \Gamma to produce uppercase Greek letters
%%	\forall          \pm        \aleph       \subset     \Leftrightarrow
%%	\exists          \geq       \Im          \subseteq   \Leftarrow
%%	\cong            \propto    \Re          \in         \Uparrow
%%	\perp            \partial   \wp          \notin      \Rightarrow
%%	\bot             \bullet    \otimes      \angle      \Downarrow
%%	\leq             \div       \oplus       \nabla      \diamond
%%	\infty           \neq       \emptyset    \surd       \langle
%%	\leftrightarrow  \equiv     \cap         \cdot       \lceil
%%	\leftarrow       \approx    \cup         \neg        \lfloor
%%	\uparrow         \dots      \supset      \lnot       \rangle
%%	\rightarrow      \vert      \supseteq    \land       \rceil
%%	\downarrow       \Vert      \notsubset   \lor        \rfloor
%%	\degrees                                                           
%%
%%	\therefore \prime \dprime \slash \mult \horiz
%%
%%	\grave \acute \ddot \hat \tilde \bar \breve \dot \check
%%	\Grave \Acute \Ddot \Hat \Tilde \Bar \Breve \Dot \Check
%%
%%	\int{<a>}{<b>}    \sum{<a>}{<b>}    \prod{<a>}{<b>}
%%	\frac{<x>}{<y>}   \sqrt{<x>}        \root{<n>}{<x>}
%%
%%	Examples:
%%		STEXT(X,Y,'\18\times This text will be 18-point Times.')
%%		STEXT(X,Y,'The word {\italic italic} will be in italics.')
%%		STEXT(X,Y,'Einstein''s famous equation: E = mc^2')
%%		STEXT(X,Y,'\18\times The resistance is 12 k\Omega.')
%%
%%	STEXT(X,Y,Z,'string') adds text in 3-D coordinates.
%%
%%	Because of the way styled text objects are created, it is necessary
%%	to reposition them using FIXSTEXT when a figure is resized or the
%%	axes are changed (including changing the view in 3-D).  Also, they
%%	must be printed with PRINTSTO.
%%
%%	STEXT returns a handle to an STEXT object.  STEXT objects are
%%	children of AXES objects.
%%
%%	The X,Y pair (X,Y,Z triple for 3-D) can be followed by
%%	parameter/value pairs to specify additional properties of the text.
%%	The X,Y pair (X,Y,Z triple for 3-D) can be omitted entirely, and
%%	all properties specified using parameter/value pairs.
%%
%%	See also SXLABEL, SYLABEL, SZLABEL, STITLE, DELSTEXT, PRINTSTO,
%%	SETSTEXT, FIXSTEXT and the accompanying README document.
%
%%	Requires functions CMDMATCH, GETCARGS and READSTFM and MAT-file
%%	STFM.MAT or the text version STFM.TXT.
%%	Requires MATLAB Version 4.2 or greater.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%% Define gFONT_METRICS, gKERNING_DATA, gENCODING, gACCENTS, gENC_SEL
%% and gVAL as global variables (operating as static variables) so we
%% only have to load them the first time stext is run.
%global gFONT_METRICS gKERNING_DATA gENCODING gACCENTS gENC_SEL gVAL
%if length(gFONT_METRICS) == 0
%	stextfun = which('stext');
%	stextfun((length(stextfun) - 6):length(stextfun)) = [];
%	% If MAT-file exists then load it, otherwise load data from text file
%	% and create MAT-file (which is faster to load) for future use.
%	if exist([stextfun,'stfm.mat']) == 2
%		load([stextfun,'stfm.mat'])
%	else
%		[gFONT_METRICS,gKERNING_DATA,gENCODING,gACCENTS,gENC_SEL,gVAL] = ...
%				readstfm;
%		
%		savedir = stextfun;
%		tempfid = fopen([savedir,'stfm.mat'],'w');
%		if tempfid == -1
%			savedir = [pwd,stextfun(length(stextfun))];
%		else
%			fclose(tempfid);
%			delete([savedir,'stfm.mat'])
%		end
%		save([savedir,'stfm.mat'],'gFONT_METRICS','gKERNING_DATA',...
%				'gENCODING','gACCENTS','gENC_SEL','gVAL')
%		if tempfid == -1
%			fprintf('Unable to save font metrics MAT-file\n')
%			fprintf('\t%s\n\n',[stextfun,'stfm.mat'])
%			fprintf('File saved as\n\t%s\n\n',[savedir,'stfm.mat'])
%			fprintf('For faster operation and to avoid seeing this ')
%			fprintf('message, have\nyour system administrator move this ')
%			fprintf('file to the directory\n\t%s\n',stextfun)
%		end
%	end
%end
%% Determine encoding selector, es, depending on platform.
%if gENC_SEL == 0
%	comp = computer;
%	if cmdmatch(comp,'MAC')
%		es = 3;
%	elseif cmdmatch(comp,'PC')
%		es = 4;
%	else
%		es = 5;
%	end
%else
%	es = gENC_SEL;
%end
%nacc = length(gACCENTS);
%accents = 32*ones(1,nacc);
%for i = 1:nacc
%	loc = find(gENCODING(:,es) == gACCENTS(i));
%	if ~isempty(loc)
%		accents(i) = max(loc) - 1;
%	end
%end
%
%% Figure out what the input arguments are.
%if nargin >= 4
%	flags = [isstr(a1),isstr(a2),isstr(a3),isstr(a4)];
%elseif nargin == 3
%	flags = [isstr(a1),isstr(a2),isstr(a3),-1];
%elseif nargin == 2
%	flags = [isstr(a1),isstr(a2),-1,-1];
%elseif nargin == 1
%	error('Not enough input arguments.')
%else
%	flags = [-1,-1,-1,-1];
%end
%
%% From flags, determine which argument is the first property name
%% and how many property/value pairs are present.
%if all(flags == [0 0 0 1])
%	firstOpt = 5;
%	numOptions = (nargin - 4)/2;
%elseif all(flags == [0 0 1 1])
%	firstOpt = 4;
%	numOptions = (nargin - 3)/2;
%elseif all(flags == [0 0 1 -1])
%	firstOpt = 4;
%	numOptions = 0;
%elseif flags(1) == 1
%	firstOpt = 1;
%	numOptions = nargin/2;
%elseif all(flags == -1)
%	numOptions = 0;
%else
%	error('Incorrect property/value pairs.')
%end
%
%% Build initial text command.
%if nargin == 0
%	textCmd = 'text';
%else
%	textCmd = 'text(';
%	if firstOpt == 4
%		textCmd = [textCmd,'''Position'',[a1,a2],''String'',a3,'];
%	elseif firstOpt == 5
%		textCmd = [textCmd,'''Position'',[a1,a2,a3],''String'',a4,'];
%	end
%	for i = firstOpt:nargin
%		textCmd = [textCmd,sprintf('a%d,',i)];
%	end
%	textCmd(length(textCmd)) = ')';
%end
%anchor = eval(textCmd);
%set(anchor,'Tag','stext')
%ver5 = cmdmatch(version,'5');
%if ver5, set(anchor,'Interpreter','none'), end
%
%% Get default values.
%str           = setstr(rem(get(anchor,'String'),256));
%anchorPos     = get(anchor,'Position');
%horizAlign    = get(anchor,'HorizontalAlignment');
%vertAlign     = get(anchor,'VerticalAlignment');
%anchorUnits   = get(anchor,'Units');
%rotation      = get(anchor,'Rotation');
%eraseMode     = get(anchor,'EraseMode');
%buttonDownFcn = get(anchor,'ButtonDownFcn');
%clipping      = get(anchor,'Clipping');
%interruptible = get(anchor,'Interruptible');
%fontSize      = get(anchor,'FontSize');
%fontName      = lower(get(anchor,'FontName'));
%visible       = get(anchor,'Visible');
%
%set(anchor,'Rotation',0,'Visible','off')
%
%% Process property/value pairs.
%for i = 1:numOptions
%	property = eval(['a',num2str(firstOpt + 2*(i-1))]);
%	value = eval(['a',num2str(firstOpt + 2*(i-1) + 1)]);
%	
%	% Convert property and value (if it's a string) to lower case.
%	% This code is significantly simpler and faster than lower.m, but
%	% sufficient for our purposes.
%	upperCase = property >= 'A' & property <= 'Z';
%	property(upperCase) = setstr(property(upperCase) + ('a' - 'A'));
%	if isstr(value) & ~cmdmatch('string',property)
%		upperCase = value >= 'A' & value <= 'Z';
%		value(upperCase) = setstr(value(upperCase) + ('a' - 'A'));
%	end
%	
%	% HorizontalAlignment: [ {left} | center | right ]
%	if cmdmatch('horizontalalignment',property)
%		horizAlign = value;
%		set(anchor,'HorizontalAlignment',value)
%	
%	% VerticalAlignment: [ top | cap | {middle} | baseline | bottom ]
%	elseif cmdmatch('verticalalignment',property)
%		vertAlign = value;
%		set(anchor,'VerticalAlignment',value)
%	
%	% Units: [ inches | centimeters | normalized | points | pixels | {data} ]
%	elseif cmdmatch('units',property)
%		anchorUnits = value;
%		set(anchor,'Units',value)
%		anchorPos = get(anchor,'Position');
%	
%	% Position
%	elseif cmdmatch('position',property)
%		anchorPos = value;
%		set(anchor,'Position',value)
%		xin = value(1);
%		yin = value(2);
%	
%	% Rotation
%	elseif cmdmatch('rotation',property)
%		rotation = value;
%		rotation = rotation - floor(rotation/360)*360;
%	
%	% String
%	elseif cmdmatch('string',property)
%		str = value;
%		set(anchor,'String',value)
%	
%	% EraseMode
%	elseif cmdmatch('erasemode',property)
%		eraseMode = value;
%		set(anchor,'EraseMode',value)
%	
%	% ButtonDownFcn
%	elseif cmdmatch('buttondownfcn',property)
%		buttonDownFcn = value;
%		set(anchor,'ButtonDownFcn',value)
%	
%	% Clipping
%	elseif cmdmatch('clipping',property)
%		clipping = value;
%		set(anchor,'Clipping',value)
%	
%	% Interruptible
%	elseif cmdmatch('interruptible',property)
%		interruptible = value;
%		set(anchor,'Interruptible',value)
%	
%	% Visible
%	elseif cmdmatch('visible',property)
%		visible = value;
%		set(anchor,'Visible',value)
%	
%	else
%		delete(anchor)
%		error('Invalid object property.')
%	end
%end
%
%
%% Determine exact starting point.
%if cmdmatch('points',anchorUnits)
%	pos = get(anchor,'Position');
%else
%	posu0 = get(anchor,'Position');
%	set(anchor,'Units','points')
%	pos1 = get(anchor,'Position');
%	set(anchor,'Units',anchorUnits)
%	posu1 = get(anchor,'Position');
%	set(anchor,'Units','points','Position',pos1 + 1,'Units',anchorUnits)
%	posu2 = get(anchor,'Position');
%	pos = (posu0(1:2) - posu1(1:2))./(posu2(1:2) - posu1(1:2)) + pos1(1:2);
%	set(anchor,'Units','points','Position',pos,'Units',anchorUnits)
%end
%x0 = pos(1);
%y0 = pos(2);
%
%% Initialize some data.
%objList = [];
%heightList = [];
%xDistance = [];
%first = 1;
%slantTagged = 0;
%termNoDigits = setstr(1:255);
%termNoDigits(real('0'):real('9')) = [];
%termNoAlpha = setstr(1:255);
%termNoAlpha([real('A'):real('Z'),real('a'):real('z')]) = [];
%xstack = [];
%colLut = [1 1 3 3;2 2 4 4;2 2 4 4];
%if isstudent
%	fm = [1 1 1 1 ; 2 2 2 2 ; 3:6 ; 7:10 ; 11:14 ; 15:18 ; 19:22 ;...
%			23:26 ; 27:30 ; 7:10 ; 31 31 31 31];
%else
%	fm = [1 1 1 1 ; 2 2 2 2 ; 3:6 ; 7:10 ; 11:14 ; 15:18 ; 19:22 ;...
%			23:26 ; 27:30 ; 31:34 ; 35 35 35 35];
%end
%
%fontanglelist = str2mat('normal','italic','oblique');
%fontnamelist = str2mat('symbol','zapfdingbats','times','helvetica',...
%		'palatino','courier','avantgarde','bookman',...
%		'newcenturyschlbk','n helvetica narrow','zapfchancery');
%fontweightlist = str2mat('light','normal','demi','bold');
%
%% Initialize indexing parameters for "params" array.  fa = font angle,
%% fn = font name, fs = font size, fw = font weight, cr,cg,cb = color rgb,
%% x = x location, y = y location, mode is used for super- and subscripts,
%% nextX = x location of next object.
%fa = 1; fn = 2; fs = 3; fw = 4; cr = 5; cg = 6; cb = 7; x = 8; y = 9;
%mode = 10; nextX = 11;
%
%% params is a parameter stack.  The contents are indices into string
%% matrices for font angle, name and weight and actual values for
%% the others.
%
%% Initialize params: font angle = normal, font name = default font,
%% font size = default text font size, font weight = normal,
%% color = default text color, x = 0, y = 0, mode = 0, nextX = 0.
%params = [1;4;fontSize;2;get(0,'DefaultTextColor')';0;0;0;0];
%for fontIndex = 1:11
%	if cmdmatch(fontnamelist(fontIndex,:),fontName)
%		params(fn) = fontIndex;
%		break
%	end
%end
%
%% Parse str looking for commands.
%while ~isempty(str)
%	if str(1) == '{'
%		% Push a copy of the current parameters on the parameter stack.
%		params = [params(:,1),params];
%		params(mode) = 0;
%		str(1) = [];
%	elseif str(1) == '}'
%		% Pop the parameter stack except for adjustments to the x values.
%		if size(params,2) == 1
%			delete(objList)
%			delete(anchor)
%			error('Unmatched braces.')
%		end
%		str(1) = [];
%		params(nextX,2) = max(params(nextX),params(nextX,2));
%		if params(mode,2) == 0
%			params(x,2) = params(x);
%		end
%		if isempty(str)
%			params(x,2) = params(x);
%		else
%			if str(1) ~= '^' & str(1) ~= '_'
%				params(x,2) = params(x);
%				params(mode,2) = 0;
%			end
%		end
%		params(:,1) = [];
%	elseif str(1) == '^'
%		% Superscript
%		params(mode) = params(mode) + 1;
%		params = [params(:,1),params];
%		params(mode) = 0;
%		params(nextX) = params(x);
%		params(y) = params(y) + params(fs)/3;
%		params(fs) = params(fs)/sqrt(2);
%		if str(2) == '{'
%			str(1:2) = [];
%		else
%			str(1:2) = [str(2),'}'];
%		end
%	elseif str(1) == '_'
%		% Subscript
%		params(mode) = params(mode) + 2;
%		params = [params(:,1),params];
%		params(mode) = 0;
%		params(nextX) = params(x);
%		params(y) = params(y) - params(fs)/4;
%		params(fs) = params(fs)/sqrt(2);
%		if str(2) == '{'
%			str(1:2) = [];
%		else
%			str(1:2) = [str(2),'}'];
%		end
%	elseif str(1) == '\'
%		% Extract command.
%		if all(str(2) ~= termNoAlpha)
%			[cmd,str] = strtok(setstr(str),setstr(termNoAlpha));
%			if length(str) > 1
%				if str(1) == ' '
%					nonSpace = min(find(str ~= ' '));
%					if ~isempty(nonSpace)
%						if all(str(nonSpace) ~= termNoAlpha)
%							str(1) = [];
%						end
%					end
%				end
%			end
%		elseif all(str(2) ~= termNoDigits)
%			[cmd,str] = strtok(str,termNoDigits);
%			if length(str) > 1
%				if str(1) == ' '
%					nonSpace = min(find(str ~= ' '));
%					if ~isempty(nonSpace)
%						if all(str(nonSpace) ~= termNoDigits)
%							str(1) = [];
%						end
%					end
%				end
%			end
%		else
%			cmd = str(2);
%			str(1:2) = [];
%		end
%		
%		% Command is a space.
%		if strcmp(' ',cmd)
%			str = [' ',str];
%		
%		% Font size specified in points.
%		elseif all(cmd >= '0' & cmd <= '9')
%			params(fs) = sscanf(cmd,'%d');
%			if params(fs) > 255
%				delete(objList)
%				delete(anchor)
%				error('Font size too large.')
%			end
%				
%		% Font angle and weight commands.
%		elseif cmdmatch('normal',cmd),  params(fa) = 1; params(fw) = 2;
%		elseif cmdmatch('italic',cmd),  params(fa) = 2;
%		elseif cmdmatch('oblique',cmd), params(fa) = 3;
%		elseif cmdmatch('light',cmd),   params(fw) = 1;
%		elseif cmdmatch('demi',cmd),    params(fw) = 3;
%		elseif cmdmatch('bold',cmd),    params(fw) = 4;
%		
%		% Font names.
%		elseif cmdmatch('symbol',cmd),           params(fn) = 1;
%		elseif cmdmatch('zapfdingbats',cmd),     params(fn) = 2;
%		elseif cmdmatch('times',cmd),            params(fn) = 3;
%		elseif cmdmatch('helvetica',cmd),        params(fn) = 4;
%		elseif cmdmatch('palatino',cmd),         params(fn) = 5;
%		elseif cmdmatch('courier',cmd),          params(fn) = 6;
%		elseif cmdmatch('avantgarde',cmd),       params(fn) = 7;
%		elseif cmdmatch('bookman',cmd),          params(fn) = 8;
%		elseif cmdmatch('newcenturyschlbk',cmd), params(fn) = 9;
%		elseif cmdmatch('narrow',cmd),           params(fn) = 10;
%		elseif cmdmatch('zapfchancery',cmd),     params(fn) = 11;
%		
%		% Font size in sqrt(2) increments.
%		elseif cmdmatch('bigger',cmd),  params(fs) = params(fs)*sqrt(2);
%		elseif cmdmatch('larger',cmd),  params(fs) = params(fs)*sqrt(2);
%		elseif cmdmatch('smaller',cmd), params(fs) = params(fs)/sqrt(2);
%		
%		% Colors.
%		elseif cmdmatch('black',cmd),   params(cr:cb) = [0;0;0];
%		elseif cmdmatch('white',cmd),   params(cr:cb) = [1;1;1];
%		elseif cmdmatch('red',cmd),     params(cr:cb) = [1;0;0];
%		elseif cmdmatch('green',cmd),   params(cr:cb) = [0;1;0];
%		elseif cmdmatch('blue',cmd),    params(cr:cb) = [0;0;1];
%		elseif cmdmatch('cyan',cmd),    params(cr:cb) = [0;1;1];
%		elseif cmdmatch('magenta',cmd), params(cr:cb) = [1;0;1];
%		elseif cmdmatch('yellow',cmd),  params(cr:cb) = [1;1;0];
%		elseif cmdmatch('gray',cmd),    params(cr:cb) = [0.5;0.5;0.5];
%		elseif cmdmatch('color',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			params(cr:cb) = sscanf(arg,'%f,%f,%f');
%		
%		% Absolute positioning in points.
%		elseif cmdmatch('left',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params([x,nextX]) = params([x,nextX]) - arg;
%		elseif cmdmatch('right',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params([x,nextX]) = params([x,nextX]) + arg;
%		elseif cmdmatch('up',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params(y) = params(y) + arg;
%		elseif cmdmatch('down',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params(y) = params(y) - arg;
%		
%		% Relative positioning in units of current font size.
%		elseif cmdmatch('rleft',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params([x,nextX]) = params([x,nextX]) - arg*round(params(fs));
%		elseif cmdmatch('rright',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params([x,nextX]) = params([x,nextX]) + arg*round(params(fs));
%		elseif cmdmatch('rup',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params(y) = params(y) + arg*round(params(fs));
%		elseif cmdmatch('rdown',cmd)
%			[arg,str] = strtok(str,'{}');
%			str(1) = [];
%			arg = sscanf(arg,'%f');
%			params(y) = params(y) - arg*round(params(fs));
%		
%		% Integral.
%		elseif strcmp('int',cmd)
%			[arg1,str] = getcargs(str);
%			[arg2,str] = getcargs(str);
%			str = ['{\rdown{.25}\larger\sym',242,...
%					'}_{\rleft{.1}\rdown{.3}{',arg1,...
%					'}}^{\rright{.2}\rup{.6}{',arg2,'}}',str];
%		
%		% Summation.
%		elseif strcmp('sum',cmd)
%			[arg1,str] = getcargs(str);
%			[arg2,str] = getcargs(str);
%			str = ['{\rdown{.2}\larger\sym',229,'}_{\rdown{.1}{',arg1,...
%					'}}^{\rup{.2}{',arg2,'}}',str];
%		
%		% Product.
%		elseif strcmp('prod',cmd)
%			[arg1,str] = getcargs(str);
%			[arg2,str] = getcargs(str);
%			str = ['{\rdown{.2}\larger\sym',213,'}_{\rdown{.1}{',arg1,...
%					'}}^{\rup{.2}{',arg2,'}}',str];
%		
%		% Square root.
%		elseif strcmp('sqrt',cmd)
%			[arg1,str] = getcargs(str);
%			pfs = round(params(fs));
%			nfs = sprintf('%d',pfs);
%			nfn = deblank(fontnamelist(params(fn),:));
%			if params(fn) == 11
%				nfn = 'n helvetica narrow';
%			end
%			narg1 = ['\',nfs,'\',nfn,'{}',arg1];
%			h1 = eval(['stext(0,0,narg1,''Units'',''points'',',...
%					'''vert'',''base'')'],'-1');
%			if h1 == -1
%				delete(objList)
%				delete(anchor)
%				error(lasterr)
%			end
%			e1 = getstext(h1,'Extent');
%			delstext(h1)
%			rfs = ceil(e1(4)/0.955);
%			ofs = 0.038*rfs + e1(2);
%			exr = 0.2;
%			sqrtwid = e1(3) + 2*exr*pfs;
%			numex = sqrtwid/(rfs*0.5);
%			numex1 = ceil(numex) - 1;
%			jog = 0.5*rfs - (sqrtwid - numex1*0.5*rfs);
%			exs = setstr(96*ones(1,numex1));
%			x1 = e1(3) + exr*pfs - 0.5*rfs;
%			x2 = exr*pfs;
%			str = ['{\',num2str(rfs),'\up{',num2str(ofs),...
%					'}\nor\sym',214,'\rleft{0.549}',exs,...
%					'\left{',num2str(jog),'}',96,...
%					'\left{',num2str(x1),'}}{',arg1,...
%					'}\right{',num2str(x2),'}',str];
%			
%		% Root.
%		elseif strcmp('root',cmd)
%			[arg1,str] = getcargs(str);
%			[arg2,str] = getcargs(str);
%			pfs = round(params(fs));
%			nfs = sprintf('%d',pfs);
%			nfn = deblank(fontnamelist(params(fn),:));
%			if params(fn) == 11
%				nfn = 'n helvetica narrow';
%			end
%			narg2 = ['\',nfs,'\',nfn,'{}',arg2];
%			h1 = eval(['stext(0,0,narg2,''Units'',''points'',',...
%					'''vert'',''base'')'],'-1');
%			if h1 == -1
%				delete(objList)
%				delete(anchor)
%				error(lasterr)
%			end
%			e1 = getstext(h1,'Extent');
%			delstext(h1)
%			rfs = ceil(e1(4)/0.955);
%			ofs = 0.038*rfs + e1(2);
%			exr = 0.2;
%			sqrtwid = e1(3) + 2*exr*pfs;
%			numex = sqrtwid/(rfs*0.5);
%			numex1 = ceil(numex) - 1;
%			jog = 0.5*rfs - (sqrtwid - numex1*0.5*rfs);
%			exs = setstr(96*ones(1,numex1));
%			x1 = e1(3) + exr*pfs - 0.5*rfs;
%			x2 = exr*pfs;
%			pfs2 = round(pfs/2);
%			str = ['{\',num2str(rfs),'\up{',num2str(ofs),...
%					'}{\pushx\rup{0.56}\rright{0.17}\',...
%					num2str(pfs2),'{}',arg1,...
%					'\popx}\norm\sym',214,'\rleft{0.549}',...
%					exs,'\left{',num2str(jog),'}',96,...
%					'\left{',num2str(x1),'}}{',arg2,...
%					'}\right{',num2str(x2),'}',str];
%			
%		% Fraction.
%		elseif strcmp('frac',cmd)
%			[arg1,str] = getcargs(str);
%			[arg2,str] = getcargs(str);
%			pfs = round(params(fs));
%			nfs = sprintf('%d',pfs);
%			nfn = deblank(fontnamelist(params(fn),:));
%			if params(fn) == 11
%				nfn = 'n helvetica narrow';
%			end
%			narg1 = ['\',nfs,'\',nfn,'{}',arg1];
%			narg2 = ['\',nfs,'\',nfn,'{}',arg2];
%			h1 = eval(['stext(0,0,narg1,''Units'',''points'',',...
%					'''vert'',''base'')'],'-1');
%			if h1 == -1
%				delete(objList)
%				delete(anchor)
%				error(lasterr)
%			end
%			e1 = getstext(h1,'Extent');
%			delstext(h1)
%			h2 = eval(['stext(0,0,narg2,''Units'',''points'',',...
%					'''vert'',''base'')'],'-1');
%			if h2 == -1
%				delete(objList)
%				delete(anchor)
%				error(lasterr)
%			end
%			e2 = getstext(h2,'Extent');
%			delstext(h2)
%			
%			if e2(3) > e1(3)
%				x1 = (e2(3) - e1(3))/2;
%				x2 = -(x1 + e1(3));
%				x3 = 0;
%			else
%				x1 = 0;
%				x2 = -(e1(3) + e2(3))/2;
%				x3 = (e1(3) - e2(3))/2;
%			end
%			y1 = pfs/3 - e1(2);
%			y2 = -y1 - (e2(4) + e2(2)) + pfs/6;
%			y3 = -(y1 + y2);
%			
%			exr = 0.1;
%			fracwid = max(e1(3),e2(3)) + 2*exr*pfs;
%			numu = fracwid/(pfs*0.5);
%			numu1 = ceil(numu) - 1;
%			jog = 0.5*pfs - (fracwid - numu1*0.5*pfs);
%			unds = ('\_')';
%			unds = unds(:,ones(numu1,1));
%			unds = unds(:)';
%			str = ['{\up{',num2str(y1),'}\right{',num2str(x1+exr*pfs),...
%					'}{',arg1,'}\up{',num2str(y2),...
%					'}\right{',num2str(x2),'}{',arg2,...
%					'}\right{',num2str(x3),'}}{\left{',...
%					num2str(fracwid-exr*pfs),'}\up{',...
%					num2str(pfs*0.4385),'}\sym',unds,...
%					'\left{',num2str(jog),'}\_}',str];
%			
%		% Slashed fraction.
%		elseif strcmp('slash',cmd)
%			[arg1,str] = getcargs(str);
%			[arg2,str] = getcargs(str);
%			pfs = round(params(fs));
%			ffs = round(pfs*0.625);
%			ffss = sprintf('%d',ffs);
%			str = ['{\rup{0.256}\',ffss,'{',arg1,...
%					'}}{\sym',164,'}{\',ffss,'{',arg2,'}}',str];
%		
%		% Lowercase Greek letters.
%		elseif strcmp('alpha',cmd),      str = ['{\sym a}',str];
%		elseif strcmp('beta',cmd),       str = ['{\sym b}',str];
%		elseif strcmp('gamma',cmd),      str = ['{\sym g}',str];
%		elseif strcmp('delta',cmd),      str = ['{\sym d}',str];
%		elseif strcmp('epsilon',cmd),    str = ['{\sym e}',str];
%		elseif strcmp('varepsilon',cmd), str = ['{\sym e}',str];
%		elseif strcmp('zeta',cmd),       str = ['{\sym z}',str];
%		elseif strcmp('eta',cmd),        str = ['{\sym h}',str];
%		elseif strcmp('theta',cmd),      str = ['{\sym q}',str];
%		elseif strcmp('vartheta',cmd),   str = ['{\sym J}',str];
%		elseif strcmp('iota',cmd),       str = ['{\sym i}',str];
%		elseif strcmp('kappa',cmd),      str = ['{\sym k}',str];
%		elseif strcmp('lambda',cmd),     str = ['{\sym l}',str];
%		elseif strcmp('mu',cmd),         str = ['{\sym m}',str];
%		elseif strcmp('nu',cmd),         str = ['{\sym n}',str];
%		elseif strcmp('xi',cmd),         str = ['{\sym x}',str];
%		elseif strcmp('pi',cmd),         str = ['{\sym p}',str];
%		elseif strcmp('varpi',cmd),      str = ['{\sym v}',str];
%		elseif strcmp('rho',cmd),        str = ['{\sym r}',str];
%		elseif strcmp('varrho',cmd),     str = ['{\sym r}',str];
%		elseif strcmp('sigma',cmd),      str = ['{\sym s}',str];
%		elseif strcmp('varsigma',cmd),   str = ['{\sym V}',str];
%		elseif strcmp('tau',cmd),        str = ['{\sym t}',str];
%		elseif strcmp('upsilon',cmd),    str = ['{\sym u}',str];
%		elseif strcmp('phi',cmd),        str = ['{\sym f}',str];
%		elseif strcmp('varphi',cmd),     str = ['{\sym j}',str];
%		elseif strcmp('chi',cmd),        str = ['{\sym c}',str];
%		elseif strcmp('psi',cmd),        str = ['{\sym y}',str];
%		elseif strcmp('omega',cmd),      str = ['{\sym w}',str];
%		
%		% Uppercase Greek letters.
%		elseif strcmp('Gamma',cmd),      str = ['{\sym G}',str];
%		elseif strcmp('Delta',cmd),      str = ['{\sym D}',str];
%		elseif strcmp('Theta',cmd),      str = ['{\sym Q}',str];
%		elseif strcmp('Lambda',cmd),     str = ['{\sym L}',str];
%		elseif strcmp('Xi',cmd),         str = ['{\sym X}',str];
%		elseif strcmp('Pi',cmd),         str = ['{\sym P}',str];
%		elseif strcmp('Sigma',cmd),      str = ['{\sym S}',str];
%		elseif strcmp('Upsilon',cmd),    str = ['{\sym',161,'}',str];
%		elseif strcmp('varUpsilon',cmd), str = ['{\sym U}',str];
%		elseif strcmp('Phi',cmd),        str = ['{\sym F}',str];
%		elseif strcmp('Psi',cmd),        str = ['{\sym Y}',str];
%		elseif strcmp('Omega',cmd),      str = ['{\sym W}',str];
%		
%		% Other LaTeX characters.
%		elseif strcmp('forall',cmd),         str = ['{\sym',34,'}',str];
%		elseif strcmp('exists',cmd),         str = ['{\sym',36,'}',str];
%		elseif strcmp('cong',cmd),           str = ['{\sym',64,'}',str];
%		elseif strcmp('perp',cmd),           str = ['{\sym\^}',str];
%		elseif strcmp('bot',cmd),            str = ['{\sym\^}',str];
%		elseif strcmp('leq',cmd),            str = ['{\sym',163,'}',str];
%		elseif strcmp('infty',cmd),          str = ['{\sym',165,'}',str];
%		elseif strcmp('leftrightarrow',cmd), str = ['{\sym',171,'}',str];
%		elseif strcmp('leftarrow',cmd),      str = ['{\sym',172,'}',str];
%		elseif strcmp('uparrow',cmd),        str = ['{\sym',173,'}',str];
%		elseif strcmp('rightarrow',cmd),     str = ['{\sym',174,'}',str];
%		elseif strcmp('downarrow',cmd),      str = ['{\sym',175,'}',str];
%		elseif strcmp('degrees',cmd),        str = ['{\sym',176,'}',str];
%		elseif strcmp('pm',cmd),             str = ['{\sym',177,'}',str];
%		elseif strcmp('geq',cmd),            str = ['{\sym',179,'}',str];
%		elseif strcmp('propto',cmd),         str = ['{\sym',181,'}',str];
%		elseif strcmp('partial',cmd),        str = ['{\sym',182,'}',str];
%		elseif strcmp('bullet',cmd),         str = ['{\sym',183,'}',str];
%		elseif strcmp('div',cmd),            str = ['{\sym',184,'}',str];
%		elseif strcmp('neq',cmd),            str = ['{\sym',185,'}',str];
%		elseif strcmp('equiv',cmd),          str = ['{\sym',186,'}',str];
%		elseif strcmp('approx',cmd),         str = ['{\sym',187,'}',str];
%		elseif strcmp('dots',cmd),           str = ['{\sym',188,'}',str];
%		elseif strcmp('aleph',cmd),          str = ['{\sym',192,'}',str];
%		elseif strcmp('Im',cmd),             str = ['{\sym',193,'}',str];
%		elseif strcmp('Re',cmd),             str = ['{\sym',194,'}',str];
%		elseif strcmp('wp',cmd),             str = ['{\sym',195,'}',str];
%		elseif strcmp('otimes',cmd),         str = ['{\sym',196,'}',str];
%		elseif strcmp('oplus',cmd),          str = ['{\sym',197,'}',str];
%		elseif strcmp('emptyset',cmd),       str = ['{\sym',198,'}',str];
%		elseif strcmp('cap',cmd),            str = ['{\sym',199,'}',str];
%		elseif strcmp('cup',cmd),            str = ['{\sym',200,'}',str];
%		elseif strcmp('supset',cmd),         str = ['{\sym',201,'}',str];
%		elseif strcmp('supseteq',cmd),       str = ['{\sym',202,'}',str];
%		elseif strcmp('notsubset',cmd),      str = ['{\sym',203,'}',str];
%		elseif strcmp('subset',cmd),         str = ['{\sym',204,'}',str];
%		elseif strcmp('subseteq',cmd),       str = ['{\sym',205,'}',str];
%		elseif strcmp('in',cmd),             str = ['{\sym',206,'}',str];
%		elseif strcmp('notin',cmd),          str = ['{\sym',207,'}',str];
%		elseif strcmp('angle',cmd),          str = ['{\sym',208,'}',str];
%		elseif strcmp('nabla',cmd),          str = ['{\sym',209,'}',str];
%		elseif strcmp('surd',cmd),           str = ['{\sym',214,'}',str];
%		elseif strcmp('cdot',cmd),           str = ['{\sym',215,'}',str];
%		elseif strcmp('neg',cmd),            str = ['{\sym',216,'}',str];
%		elseif strcmp('lnot',cmd),           str = ['{\sym',216,'}',str];
%		elseif strcmp('land',cmd),           str = ['{\sym',217,'}',str];
%		elseif strcmp('lor',cmd),            str = ['{\sym',218,'}',str];
%		elseif strcmp('Leftrightarrow',cmd), str = ['{\sym',219,'}',str];
%		elseif strcmp('Leftarrow',cmd),      str = ['{\sym',220,'}',str];
%		elseif strcmp('Uparrow',cmd),        str = ['{\sym',221,'}',str];
%		elseif strcmp('Rightarrow',cmd),     str = ['{\sym',222,'}',str];
%		elseif strcmp('Downarrow',cmd),      str = ['{\sym',223,'}',str];
%		elseif strcmp('diamond',cmd),        str = ['{\sym',224,'}',str];
%		elseif strcmp('langle',cmd),         str = ['{\sym',225,'}',str];
%		elseif strcmp('lceil',cmd),          str = ['{\sym',233,'}',str];
%		elseif strcmp('lfloor',cmd),         str = ['{\sym',235,'}',str];
%		elseif strcmp('vert',cmd),           str = ['{\sym',239,'}',str];
%		elseif strcmp('rangle',cmd),         str = ['{\sym',241,'}',str];
%		elseif strcmp('rceil',cmd),          str = ['{\sym',249,'}',str];
%		elseif strcmp('rfloor',cmd),         str = ['{\sym',251,'}',str];
%		elseif strcmp('AA',cmd),             str = [accents(10),str];
%		elseif strcmp('ii',cmd),             str = [accents(11),str];
%		
%		elseif strcmp('Vert',cmd),     str = ['{\sym',[247,231],'}',str];
%		elseif strcmp('parallel',cmd), str = ['{\sym',[247,231],'}',str];
%		
%		elseif strcmp('{',cmd),              str = ['{' + 256,str];
%		elseif strcmp('}',cmd),              str = ['}' + 256,str];
%		elseif strcmp('\',cmd),              str = ['\' + 256,str];
%		elseif strcmp('^',cmd),              str = ['^' + 256,str];
%		elseif strcmp('_',cmd),              str = ['_' + 256,str];
%		
%		% Non-LaTeX characters and LaTeX-like constructs that don't work
%		% quite like they do in LaTeX.
%		elseif strcmp('+',cmd),         str = ['{\sym+}',str];
%		elseif strcmp('-',cmd),         str = ['{\sym-}',str];
%		elseif strcmp('=',cmd),         str = ['{\sym=}',str];
%		elseif strcmp('>',cmd),         str = ['{\sym>}',str];
%		elseif strcmp('<',cmd),         str = ['{\sym<}',str];
%		elseif strcmp('|',cmd),         str = ['{\sym|}',str];
%		elseif strcmp('therefore',cmd), str = ['{\sym\\}',str];
%		elseif strcmp('prime',cmd),     str = ['{\sym',162,'}',str];
%		elseif strcmp('dprime',cmd),    str = ['{\sym',178,'}',str];
%		elseif strcmp('mult',cmd),      str = ['{\sym',180,'}',str];
%		elseif strcmp('horiz',cmd),     str = ['{\sym',190,'}',str];
%		
%		% Spaces.
%		elseif strcmp('/',cmd),         str = ['\rright{0.07}',str];
%		elseif strcmp(',',cmd),         str = ['\rright{0.125}',str];
%		elseif strcmp(':',cmd),         str = ['\rright{0.1667}',str];
%		elseif strcmp(';',cmd),         str = ['\rright{0.2083}',str];
%		
%		% ASCII code.
%		elseif strcmp('#',cmd)
%			[arg1,str] = getcargs(str);
%			str = [setstr(sscanf(arg1,'%d')),str];
%		
%		% Diacritics.
%		elseif strcmp('grave',cmd)
%			accent = accents(1);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('acute',cmd)
%			accent = accents(2);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('ddot',cmd)
%			accent = accents(3);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('hat',cmd)
%			accent = accents(4);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('tilde',cmd)
%			accent = accents(5);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('bar',cmd)
%			accent = accents(6);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('breve',cmd)
%			accent = accents(7);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('dot',cmd)
%			accent = accents(8);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('check',cmd)
%			accent = accents(9);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Grave',cmd)
%			accent = accents(1);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Acute',cmd)
%			accent = accents(2);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Ddot',cmd)
%			accent = accents(3);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Hat',cmd)
%			accent = accents(4);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Tilde',cmd)
%			accent = accents(5);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Bar',cmd)
%			accent = accents(6);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Breve',cmd)
%			accent = accents(7);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Dot',cmd)
%			accent = accents(8);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('Check',cmd)
%			accent = accents(9);
%			ww = gFONT_METRICS(gENCODING(accent+1,es),fm(params(fn),...
%					colLut(params(fa),params(fw))))*round(params(fs))/1000;
%			lr = [lastWidth,ww]*[1 1;1 -1]/2;
%			str = ['{\rup{.2}\left{',num2str(lr(1)),'}',accent,...
%					'\right{',num2str(lr(2)),'}}',str];
%		
%		elseif strcmp('pushx',cmd)
%			xstack = [params([x;nextX]),xstack];
%		
%		elseif strcmp('popx',cmd)
%			if size(xstack,2) < 1
%				delete(objList)
%				delete(anchor)
%				error('Stack empty.')
%			end
%			params(x) = xstack(1);
%			params(nextX) = xstack(2);
%			xstack(:,1) = [];
%		
%		elseif strcmp('swapx',cmd)
%			if size(xstack,2) < 2
%				delete(objList)
%				delete(anchor)
%				error('Stack does not contain at least two items.')
%			end
%			temp = xstack(:,1);
%			xstack(:,[1,2]) = xstack(:,[2,1]);
%		
%		else
%			% Command is unknown.
%			delete(objList)
%			delete(anchor)
%			error(['Unrecognized command: ',cmd])
%		
%		end
%	else
%		% str(1) is not one of '{}^_\' so it must be the beginning of text.
%		params(x) = params(nextX);
%		params(mode) = 0;
%		[newStr,str] = strtok(str,'\{}^_');
%		newStr = setstr(rem(newStr,256));
%		newStr1 = newStr + 1;
%		
%		% Compute character widths.
%		strLen = length(newStr);
%		fmSel = fm(params(fn),colLut(params(fa),params(fw)));
%		if fmSel > 2
%			encSel = es;
%		else
%			encSel = fmSel;
%		end
%		fontOffset = 1000*(fmSel - 2);
%		widths = gFONT_METRICS(gENCODING(newStr1,encSel),fmSel) * ...
%				round(params(fs))/1000;
%		
%		% Increase widths by 4.5% if Symbol-Bold.
%		if params(fn) == 1 & params(fw) == 4
%			widths = 1.045*widths;
%		end
%		
%		lastWidth = widths(length(widths));
%		
%		% Compute kern correction, kc.
%		kc = zeros(strLen-1,1);
%		if fmSel > 2
%			for k = 1:strLen-1
%				kc(k) = gKERNING_DATA(fontOffset + gENCODING(newStr1(k),...
%						encSel),gENCODING(newStr1(k+1),encSel));
%			end
%			kc = kc*round(params(fs))/1000;
%		end
%		
%		xx = params(x) + cumsum([0;widths((1:strLen-1)') + kc]);
%		yy = params(y(ones(strLen,1)));
%		lastxx = xx(strLen);
%		
%		% Add shifted versions of the characters if they are Symbol-Bold.
%		% Total width increase is 4.5%.
%		if params(fn) == 1 & params(fw) == 4
%			xsh = 0.015*round(params(fs));
%			xx = [xx;xx + xsh;xx + 2*xsh;xx + 3*xsh];
%			yy = [yy;yy;yy;yy];
%			newStr = [newStr,newStr,newStr,newStr];
%			strLen = length(newStr);
%			params(fw) = 2;
%		end
%		
%		% Prepend invisible characters if Symbol italic or oblique.  This
%		% can be detected in the PostScript file so that it can be modified
%		% to produce slanted Symbol characters.
%		if params(fn) == 1 & params(fa) > 1
%			if ~slantTagged
%				xx = [0;0;0;xx];
%				yy = [0;0;0;yy];
%				newStr = setstr([9,9,9,newStr]);
%				strLen = length(newStr);
%				slantTagged = 1;
%			end
%		else
%			slantTagged = 0;
%		end
%		
%		if strLen == 1
%			newObj = text('Position',  [xx,yy],...
%					'String',              newStr,...
%					'FontAngle',           fontanglelist(params(fa),:),...
%					'FontName',            deblank(fontnamelist(params(fn),:)),...
%					'FontSize',            round(params(fs)),...
%					'FontWeight',          fontweightlist(params(fw),:),...
%					'Units',               'points',...
%					'Rotation',            0,...
%					'HorizontalAlignment', 'left',...
%					'VerticalAlignment',   'baseline',...
%					'Color',               params(cr:cb),...
%					'EraseMode',           eraseMode,...
%					'ButtonDownFcn',       buttonDownFcn,...
%					'Clipping',            clipping,...
%					'Interruptible',       interruptible,...
%					'Visible',             visible);
%		else
%			newObj = text(xx,yy,newStr',...
%					'FontAngle',           fontanglelist(params(fa),:),...
%					'FontName',            deblank(fontnamelist(params(fn),:)),...
%					'FontSize',            round(params(fs)),...
%					'FontWeight',          fontweightlist(params(fw),:),...
%					'Units',               'points',...
%					'Rotation',            0,...
%					'HorizontalAlignment', 'left',...
%					'VerticalAlignment',   'baseline',...
%					'Color',               params(cr:cb),...
%					'EraseMode',           eraseMode,...
%					'ButtonDownFcn',       buttonDownFcn,...
%					'Clipping',            clipping,...
%					'Interruptible',       interruptible,...
%					'Visible',             visible);
%		end
%		if ver5, set(newObj,'Interpreter','none'), end
%		objList = [objList,newObj'];
%		heightList = [heightList,yy'];
%		xDistance = [xDistance,xx'];
%		params(nextX) = lastxx + lastWidth;
%		params(x) = params(nextX);
%		
%		% The vertical position of the styled text is based on the first
%		% character of the text.
%		if first
%			if cmdmatch('top',vertAlign)
%				va = 1;
%			elseif cmdmatch('cap',vertAlign)
%				va = 2;
%			elseif cmdmatch('middle',vertAlign)
%				va = 3;
%			elseif cmdmatch('baseline',vertAlign)
%				va = 4;
%			elseif cmdmatch('bottom',vertAlign)
%				va = 5;
%			end
%			hOffset = -gVAL(fmSel,va)*round(params(fs));
%			first = 0;
%		end
%	end
%end
%totalWidth = params(nextX);
%numSegments = length(objList);
%
%% Compute new x and y locations for each text object based on
%% justification and rotation.
%r = rotation*pi/180;
%if cmdmatch('left',horizAlign)
%	t = 0;
%elseif cmdmatch('center',horizAlign)
%	t = totalWidth/2;
%elseif cmdmatch('right',horizAlign)
%	t = totalWidth;
%end
%xList = x0 + (xDistance - t)*cos(r) - (heightList + hOffset)*sin(r);
%yList = y0 + (xDistance - t)*sin(r) + (heightList + hOffset)*cos(r);
%
%for i = 1:numSegments
%	set(objList(i),'Position',[xList(i),yList(i)],'Rotation',rotation);
%end
%
%% Anchor text object is invisible, but by setting the rotation we can
%% use get(stext object handle).  UserData contains a type flag (0 =
%% normal, 1 = x-label, 2 = y-label, 3 = z-label, 4 = title), the
%% location of the anchor object in points and a list of the handles
%% to the text objects that make up the styled text object.
%
%set(anchor,'Rotation',rotation,'UserData',[0,x0,y0,objList])
%
%if nargout == 1
%	output = anchor;
%end
fclose(fout);

disp(' ## Installing: "stextbox.m" (text)')
fout = fopen('stextbox.m', 'w');
%function [leg,h] = stextbox(xy,strs,p1,v1,p2,v2,p3,v3,...
%		p4,v4,p5,v5,p6,v6,p7,v7)
%%STEXTBOX Styled text multi-line box.
%%	STEXTBOX(XY,TEXT) places a box of left-justified text centered at XY =
%%	[X,Y] on the current figure, where X and Y are in normalized figure
%%	units.  TEXT is a string matrix (see STR2MAT) which specifies the
%%	multi-line text.  The text is produced with STEXT and so each row of
%%	TEXT must be valid styled text.
%%	
%%	If XY = 'title', several parameters are set automatically to make a
%%	multi-line title on the current axes.
%%	
%%	XY = 'mouse' allows dragging the box to the desired location with the
%%	mouse.  The box can be locked in position by pressing the space bar
%%	while holding down the mouse button.  STEXTBOX('move') or
%%	STEXTBOX('mouse') will make all stextboxes and slegends in the current
%%	figure movable.
%%	
%%	XY and TEXT can be followed by property/value pairs to specify
%%	additional properties of the text box:
%%	
%%	Property = 'Justification', value = [ {left} | center | right ]
%%		allows you to specify left, center or right justification of the
%%		text in the box.
%%	
%%	Property = 'Color', value = [ {none} ] -or- a ColorSpec
%%		allows you to specify the background color of the box.  If the
%%		color is 'none', the box will be transparent.  When printed,
%%		text boxes are placed on top of other axes and opaque boxes will
%%		obscure whatever is behind them.
%%	
%%	Property = 'HorizontalAlignment', value = [ left | {center} | right ]
%%		controls the horizontal alignment of the box with respect to XY.
%%
%%	Property = 'VerticalAlignment', value = [ top | {middle} | bottom ]
%%		controls the vertical alignment of the box with respect to XY.
%%
%%	Property = 'Box', value = [ {on} | off ]
%%		allows you to control whether the enclosing box is visible.
%%	
%%	Property = 'BorderFactor', value = [ {0.25} | <any positive number> ]
%%		sets the amount of space between the text and the enclosing box
%%		as a fraction of the height of the tallest line of text.
%%	
%%	Property = 'Spacing', value = [ tight | {loose} | <any positive number>]
%%		controls the line spacing of the text.  Tight spacing moves the
%%		lines as close together as possible, loose spacing makes all
%%		lines equally spaced and equal to the height of the tallest line.
%%		Setting this to a number specifies tight spacing scaled by the
%%		amount specified.  For example, 1 => normal tight spacing,
%%		0.5 => lines compressed to 50% of normal.
%%	
%%	
%%	[H,HTEXT] = STEXTBOX(...) returns a handle to the text box axes object
%%	and handles to the lines of text.  Since a text box is an axes object
%%	it is possible to make changes to its properties, e.g., changing the
%%	'LineWidth' of the border.
%%	
%%	A figure containing an STEXTBOX must be printed with PRINTSTO.
%%	
%%	See also STEXT, SLEGEND, PRINTSTO, STR2MAT and PLOT.
%
%%	Requires functions STEXT, GETSTEXT and MOVE1STO.
%%	Requires MATLAB Version 4.2 or greater.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%if nargin > 1
%	% Set defaults.
%	mouse = 0;
%	just = 'left';
%	legColor = 'none';
%	horiz = 0.5;
%	vert = 0.5;
%	ref = [0.5,0.5];
%	box = 'on';
%	borderFactor = 0.25;
%	tightSpacing = 1;
%	numOptions = (nargin - 2)/2;
%	baseAxes = gca;
%	ver5 = cmdmatch(version,'5');
%	
%	if isstr(xy)
%		if strcmp(lower(xy),'mouse')
%			mouse = 1;
%			xy = [0.5,0.5];
%		elseif strcmp(xy,'title')
%			baseUnits = get(baseAxes,'Units');
%			basePos = get(baseAxes,'Position');
%			set(baseAxes,'Units','norm')
%			basePos = get(baseAxes,'Position');
%			set(baseAxes,'Units',baseUnits,'Position',basePos)
%			xy = basePos(1:2) + basePos(3:4).*[0.5,1];
%			just = 'center';
%			horiz = 0.5;
%			vert = 0;
%			box = 'off';
%			borderFactor = 0;
%		else
%			error('Unknown position option.')
%		end
%	else
%		if length(xy) ~= 2
%			error('The position must be a 2-element vector')
%		end
%	end
%	
%	for i = 1:numOptions
%		property = lower(eval(sprintf('p%d',i)));
%		value = lower(eval(sprintf('v%d',i)));
%		
%		if cmdmatch('justification',property)
%			just = value;
%		
%		elseif cmdmatch('color',property)
%			legColor = value;
%		
%		elseif cmdmatch('horizontalalignment',property)
%			horiz = value;
%		
%		elseif cmdmatch('verticalalignment',property)
%			vert = value;
%		
%		elseif cmdmatch('box',property)
%			box = value;
%		
%		elseif cmdmatch('borderfactor',property)
%			borderFactor = value;
%		
%		elseif cmdmatch('spacing',property)
%			if isstr(value)
%				if cmdmatch('tight',value)
%					tightSpacing = 1;
%				elseif cmdmatch('loose',value)
%					tightSpacing = 0;
%				else
%					error('Invalid data for slegend parameter "Spacing".')
%				end
%			else
%				tightSpacing = value;
%			end
%		
%		else
%			error('Unknown property.')
%		end
%	end
%	
%	if cmdmatch('left',just)
%		rjust = 0;
%	elseif cmdmatch('center',just)
%		rjust = 0.5;
%	elseif cmdmatch('right',just)
%		rjust = 1;
%	else
%		error('Invalid data for stextbox parameter "Justification".')
%	end
%	
%	if isstr(horiz)
%		if cmdmatch('left',horiz)
%			ref(1) = 0;
%		elseif cmdmatch('right',horiz)
%			ref(1) = 1;
%		elseif cmdmatch('center',horiz)
%			ref(1) = 0.5;
%		else
%			error('Invalid data for stextbox parameter "HorizontalAlignment".')
%		end
%	else
%		ref(1) = horiz;
%	end
%	
%	if isstr(vert)
%		if cmdmatch('bottom',vert)
%			ref(2) = 0;
%		elseif cmdmatch('top',vert)
%			ref(2) = 1;
%		elseif cmdmatch('middle',vert)
%			ref(2) = 0.5;
%		else
%			error('Invalid data for stextbox parameter "VerticalAlignment".')
%		end
%	else
%		ref(2) = vert;
%	end
%	
%	% Create the text box axes and contents.
%	ax = axes('Units','norm','Position',[xy,0.5,0.5],...
%			'XTick',[],'YTick',[],'Box','on','Color',legColor);
%	if strcmp(box,'off')
%		if strcmp(legColor,'none')
%			set(ax,'Visible','off')
%		else
%			set(ax,'XColor',legColor,'YColor',legColor,'ZColor',legColor)
%		end
%	end
%	
%	set(ax,'Units','points')
%	xy2 = get(ax,'Position');
%	xy2(3:4) = [];
%	n = size(strs,1);
%	h = zeros(n,1);
%	exts = zeros(n,4);
%	for i = 1:n
%		cmd = ['stext(0,0,deblank(strs(i,:)),''units'',''points'',',...
%				'''hor'',''left'',''vert'',''mid'')'];
%		h(i) = eval(cmd,'-1');
%		if h(i) == -1
%			delete(ax)
%			error(lasterr)
%		end
%		exts(i,:) = getstext(h(i),'Extent');
%	end
%	
%	% Compute the size of the axes based on the contents.
%	maxht = max(exts(:,4));
%	maxdrop = min(exts(:,2));
%	maxwid = max(exts(:,3));
%	border = maxht*borderFactor;
%	if tightSpacing
%		yvals = flipud([0;cumsum(exts(n:-1:2,4))])*tightSpacing ...
%				- exts(:,2) + border;
%		top = yvals(1) + exts(1,4) + exts(1,2) + border + 1;
%	else
%		yvals = flipud(maxht*(0:(n-1))') - min(exts(:,2)) + border;
%		top = yvals(1) + maxht + maxdrop + border + 1;
%	end
%	left = 2*border;
%	right = left + maxwid + 2*border;
%	
%	% Move the contents to their final positions and set the new size
%	% for the text box axes.
%	for i = 1:n
%		delta = [(maxwid - exts(i,3))*rjust,yvals(i)];
%		userData = get(h(i),'UserData');
%		userData(2:3) = userData(2:3) + delta;
%		set(h(i),'Position',delta)
%		set(h(i),'UserData',userData)
%		if ver5
%			move1sto(h(i),[left,0,0] + [delta,0])
%		else
%			move1sto(h(i),[left,0] + delta)
%		end
%	end
%	pos = get(ax,'Position');
%	xy3 = xy2 - [right,top].*ref;
%	set(ax,'Position',[xy3,right,top],...
%			'XLim',[0 right],'YLim',[0 top])
%	
%	% Save some needed data and enable dragging.
%	userData = [xy,ref];
%	if mouse
%		set(ax,'Tag','slegend movable','UserData',userData)
%		set(gcf,'WindowButtonDownFcn','stextbox(1)')
%	else
%		set(ax,'Tag','slegend','UserData',userData)
%	end
%	set(gcf,'CurrentAxes',baseAxes)
%	
%	if nargout > 0
%		leg = ax;
%	end
%
%elseif isstr(xy)
%	xy = lower(xy);
%	if strcmp(xy,'move') | strcmp(xy,'mouse')
%		fig = get(0,'CurrentFigure');
%		fixed = findobj(fig,'Tag','slegend');
%		nf = length(fixed);
%		nm = length(findobj(fig,'Tag','slegend movable'));
%		for i = 1:nf
%			set(fixed(i),'Tag','slegend movable')
%		end
%		if nf + nm > 0
%			set(gcf,'WindowButtonDownFcn','stextbox(1)')
%		end
%	else
%		error('Unknown command.')
%	end
%
%% We have a mouse-down on a text box.
%elseif xy == 1
%	fig = get(0,'CurrentFigure');
%	% Uncomment the following line to require holding down the control key
%	% (or option on a Mac) while clicking the mouse to move a text box.
%	%if ~strcmp(get(fig,'SelectionType'),'alt'), return, end
%	curAx = get(fig,'CurrentAxes');
%	
%	figUnits = get(fig,'Units');
%	set(fig,'Units','points')
%	cp = get(fig,'CurrentPoint');
%	
%	% Find the legend closest to current point.
%	movLeg = findobj(fig,'Tag','slegend movable');
%	n = length(movLeg);
%	if n == 0
%		set(fig,'Units',figUnits,'WindowButtonDownFcn','')
%		return
%	end
%	d2 = zeros(n,1);
%	for i = 1:n
%		pos = get(movLeg(i),'Position');
%		d = cp - pos(1:2);
%		d2(i) = d*d';
%	end
%	[junk,closest] = min(d2);
%	theLeg = movLeg(closest);
%	
%	userData = get(theLeg,'UserData');
%	set(theLeg,'UserData',[userData(1:4),cp,real(figUnits)],...
%			'Tag','slegend moving')
%	set(fig,'CurrentAxes',theLeg,'CurrentAxes',curAx,...
%			'WindowButtonMotionFcn','stextbox(2)',...
%			'WindowButtonUpFcn','stextbox(3)',...
%			'KeyPressFcn','stextbox(4)',...
%			'pointer','fleur')
%
%% Moving a text box.
%elseif xy == 2
%	fig = get(0,'CurrentFigure');
%	theLeg = findobj(fig,'Tag','slegend moving');
%	userData = get(theLeg,'UserData');
%	cp = userData(5:6);
%	newp = get(fig,'CurrentPoint');
%	userData(5:6) = newp;
%	delta = newp - cp;
%	pos = get(theLeg,'Position');
%	pos(1:2) = pos(1:2) + delta;
%	set(theLeg,'Position',pos,'UserData',userData)
%
%% We have a mouse-up on a text box.
%elseif xy == 3
%	fig = get(0,'CurrentFigure');
%	theLeg = findobj(fig,'Tag','slegend moving');
%	userData = get(theLeg,'UserData');
%	set(theLeg,'Units','norm')
%	pos = get(theLeg,'Position');
%	set(theLeg,'Units','points')
%	ref = userData(3:4);
%	userData(1:2) = pos(1:2) + ref.*pos(3:4);
%	set(theLeg,'UserData',userData,'Tag','slegend movable')
%	figUnits = setstr(userData(7:length(userData)));
%	set(fig,'Units',figUnits,'pointer','arrow',...
%			'WindowButtonMotionFcn','','WindowButtonUpFcn','',...
%			'KeyPressFcn','')
%
%% We are locking the position of a text box.
%elseif xy == 4
%	fig = get(0,'CurrentFigure');
%	theLeg = findobj(fig,'Tag','slegend moving');
%	if get(fig,'CurrentCharacter') == ' '
%		if length(findobj(fig,'Tag','slegend movable')) == 0
%			set(fig,'WindowButtonDownFcn','')
%		end
%		userData = get(theLeg,'UserData');
%		set(theLeg,'Units','norm')
%		pos = get(theLeg,'Position');
%		set(theLeg,'Units','points')
%		ref = userData(3:4);
%		userData(1:2) = pos(1:2) + ref.*pos(3:4);
%		set(theLeg,'UserData',userData,'Tag','slegend')
%		figUnits = setstr(userData(7:length(userData)));
%		set(fig,'Units',figUnits,'pointer','arrow',...
%				'WindowButtonMotionFcn','','WindowButtonUpFcn','',...
%				'KeyPressFcn','')
%	end
%end
fclose(fout);

disp(' ## Installing: "stfixps.m" (text)')
fout = fopen('stfixps.m', 'w');
%function stfixps(filename)
%%STFIXPS Modifies MATLAB PostScript files to produce Symbol-Oblique.
%%	STFIXPS(PSFILE) takes a MATLAB PostScript file containing Styled
%%	Text Objects with italic or oblique Symbol characters and modifies
%%	it so that the Symbol characters are slanted.
%%
%%	See also STFIXPS, STEXT, PRINTSTO.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%% Define slant angle.  12 degrees matches slant of Times-Italic.
%slantAngle = 12*pi/180;
%mtx = sprintf('[1 0 %.6f -1 0 0]',tan(slantAngle));
%wtfmt = ['/Symbol findfont %d scalefont ',mtx,' makefont setfont'];
%rdfmt = '/Symbol /%*s %d';
%
%comp = computer;
%if cmdmatch(comp,'PC') | cmdmatch(comp,'VAX')
%	fid = fopen(filename,'rt+');
%else
%	fid = fopen(filename,'r+');
%end
%
%% Determine end-of-line sequence.
%line = fgets(fid);
%eol = line(find(line == 10 | line == 13));
%neol = length(eol);
%
%last1changed = 0;
%pos = 0;
%space = ' ';
%while isstr(line)
%	if strncmp(line,'/Symbol /',9)
%		lastsympos = pos;
%		beginsave = ftell(fid);
%		fs = sscanf(line,rdfmt);
%	elseif strncmp(line,'(\11) s',7)
%		len = length(lastline);
%		if len >= 16
%			substr = lastline(len-5-neol:len);
%			if strncmp(substr,'rotate',6)
%				n = 7;
%			else
%				n = 4;
%			end
%		else
%			n = 4;
%		end
%		for i = 1:n, fgets(fid); end
%		newpos = ftell(fid);
%		if lastsympos ~= last1changed
%			newsym = sprintf([wtfmt,eol],fs);
%			fseek(fid,beginsave,'bof');
%			saved = fread(fid,[1,lastpos - beginsave],'char');
%			numSpaces = (newpos - lastsympos) ...
%					- (length(newsym) + lastpos - beginsave) - neol;
%			spaces = space(ones(1,numSpaces));
%			newblock = [newsym,saved,spaces,eol];
%			fseek(fid,lastsympos,'bof');
%			last1changed = lastsympos;
%		else
%			spaces = space(ones(1,newpos - lastpos - neol));
%			newblock = [spaces,eol];
%			fseek(fid,lastpos,'bof');
%		end
%		fwrite(fid,newblock,'char');
%		fseek(fid,newpos,'bof');
%	end
%	lastline = line;
%	lastpos = pos;
%	pos = ftell(fid);
%	line = fgets(fid);
%end
%fclose(fid);
fclose(fout);

disp(' ## Installing: "stfm.txt" (text)')
fout = fopen('stfm.txt', 'w');
%Styled Text Toolbox Font Metrics 2.0
%
%BeginFontList 35
%Times-Roman
%Times-Italic
%Times-Bold
%Times-BoldItalic
%Helvetica
%Helvetica-Oblique
%Helvetica-Bold
%Helvetica-BoldOblique
%Palatino-Roman
%Palatino-Italic
%Palatino-Bold
%Palatino-BoldItalic
%Courier
%Courier-Oblique
%Courier-Bold
%Courier-BoldOblique
%AvantGarde-Book
%AvantGarde-BookOblique
%AvantGarde-Demi
%AvantGarde-DemiOblique
%Bookman-Light
%Bookman-LightItalic
%Bookman-Demi
%Bookman-DemiItalic
%NewCenturySchlbk-Roman
%NewCenturySchlbk-Italic
%NewCenturySchlbk-Bold
%NewCenturySchlbk-BoldItalic
%Helvetica-Narrow
%Helvetica-Narrow-Oblique
%Helvetica-Narrow-Bold
%Helvetica-Narrow-BoldOblique
%ZapfChancery-MediumItalic
%Symbol
%ZapfDingbats
%EndFontList
%
%BeginRomanCharWidths 260 33
%250 250 250 250 278 278 278 278 250 250 250 250 600 600 600 600 277 277 280 280 320 300 340 340 278 278 287 287 228 228 228 228 220
%333 333 333 389 278 278 333 333 278 333 278 333 600 600 600 600 295 295 280 280 300 320 360 320 296 333 296 333 228 228 273 273 280
%408 420 555 555 355 355 474 474 371 500 402 500 600 600 600 600 309 309 360 360 380 360 420 380 389 400 333 400 291 291 389 389 220
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%833 833 1000 833 889 889 889 889 840 889 889 889 600 600 600 600 775 775 860 860 900 800 940 880 833 833 833 889 729 729 729 729 680
%778 778 833 778 667 667 722 722 778 778 833 833 600 600 600 600 757 757 680 680 800 820 800 980 815 852 852 889 547 547 592 592 780
%333 333 333 333 222 222 278 278 278 278 278 278 600 600 600 600 351 351 280 280 220 280 320 320 204 204 241 259 182 182 228 228 240
%333 333 333 333 333 333 333 333 333 333 333 333 600 600 600 600 369 369 380 380 300 280 320 260 333 333 389 407 273 273 273 273 260
%333 333 333 333 333 333 333 333 333 333 333 333 600 600 600 600 369 369 380 380 300 280 320 260 333 333 389 407 273 273 273 273 220
%500 500 500 500 389 389 389 389 389 389 444 444 600 600 600 600 425 425 440 440 440 440 460 460 500 500 500 500 319 319 319 319 420
%564 675 570 570 584 584 584 584 606 606 606 606 600 600 600 600 606 606 600 600 600 600 600 600 606 606 606 606 479 479 479 479 520
%250 250 250 250 278 278 278 278 250 250 250 250 600 600 600 600 277 277 280 280 320 300 340 340 278 278 278 287 228 228 228 228 220
%333 333 333 333 333 333 333 333 333 333 333 389 600 600 600 600 332 332 420 420 400 320 360 280 333 333 333 333 273 273 273 273 280
%250 250 250 250 278 278 278 278 250 250 250 250 600 600 600 600 277 277 280 280 320 300 340 340 278 278 278 287 228 228 228 228 220
%278 278 278 278 278 278 278 278 606 296 296 315 600 600 600 600 437 437 460 460 600 600 600 360 278 606 278 278 228 228 228 228 340
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%278 333 333 333 278 278 333 333 250 250 250 250 600 600 600 600 277 277 280 280 320 300 340 340 278 278 278 287 228 228 273 273 260
%278 333 333 333 278 278 333 333 250 250 250 250 600 600 600 600 277 277 280 280 320 300 340 340 278 278 278 287 228 228 273 273 240
%564 675 570 570 584 584 584 584 606 606 606 606 600 600 600 600 606 606 600 600 600 600 600 620 606 606 606 606 479 479 479 479 520
%564 675 570 570 584 584 584 584 606 606 606 606 600 600 600 600 606 606 600 600 600 600 600 600 606 606 606 606 479 479 479 479 520
%564 675 570 570 584 584 584 584 606 606 606 606 600 600 600 600 606 606 600 600 600 600 600 620 606 606 606 606 479 479 479 479 520
%444 500 500 500 556 556 611 611 444 500 444 444 600 600 600 600 591 591 560 560 540 540 660 620 444 444 500 481 456 456 501 501 380
%921 920 930 832 1015 1015 975 975 747 747 747 833 600 600 600 600 867 867 740 740 820 780 820 780 737 747 747 747 832 832 800 800 700
%722 611 722 667 667 667 722 722 778 722 778 722 600 600 600 600 740 740 740 740 680 700 720 720 722 704 759 741 547 547 592 592 620
%667 611 667 667 667 667 722 722 611 611 667 667 600 600 600 600 574 574 580 580 740 720 720 720 722 722 778 759 547 547 592 592 600
%667 667 722 667 722 722 722 722 709 667 722 685 600 600 600 600 813 813 780 780 740 720 740 700 722 722 778 759 592 592 592 592 520
%722 722 722 722 722 722 722 722 774 778 833 778 600 600 600 600 744 744 700 700 800 740 780 760 778 778 833 833 592 592 592 592 700
%611 611 667 667 667 667 667 667 611 611 611 611 600 600 600 600 536 536 520 520 720 680 720 720 722 722 759 741 547 547 547 547 620
%556 611 611 667 611 611 611 611 556 556 556 556 600 600 600 600 485 485 480 480 640 620 680 660 667 667 722 704 501 501 501 501 580
%722 722 778 722 778 778 778 778 763 722 833 778 600 600 600 600 872 872 840 840 800 760 780 760 778 778 833 815 638 638 638 638 620
%722 722 778 778 722 722 722 722 832 778 833 778 600 600 600 600 683 683 680 680 800 800 820 800 833 833 870 870 592 592 592 592 680
%333 333 389 389 278 278 278 278 337 333 389 389 600 600 600 600 226 226 280 280 340 320 400 380 407 407 444 444 228 228 228 228 380
%389 444 500 500 500 500 556 556 333 333 389 389 600 600 600 600 482 482 480 480 600 560 640 620 556 611 648 667 410 410 456 456 400
%722 667 778 667 667 667 722 722 726 667 778 722 600 600 600 600 591 591 620 620 720 720 800 780 778 741 815 778 547 547 592 592 660
%611 556 667 611 556 556 611 611 611 556 611 611 600 600 600 600 462 462 440 440 600 580 640 640 667 667 722 704 456 456 501 501 580
%889 833 944 889 833 833 833 833 946 944 1000 944 600 600 600 600 919 919 900 900 920 860 940 860 944 944 981 944 683 683 683 683 840
%722 667 722 722 722 722 722 722 831 778 833 778 600 600 600 600 740 740 740 740 740 720 740 740 815 815 833 852 592 592 592 592 700
%722 722 778 722 778 778 778 778 786 778 833 833 600 600 600 600 869 869 840 840 800 760 800 760 778 778 833 833 638 638 638 638 600
%556 611 611 611 667 667 667 667 604 611 611 667 600 600 600 600 592 592 560 560 620 600 660 640 667 667 759 741 547 547 547 547 540
%722 722 778 722 778 778 778 778 786 778 833 833 600 600 600 600 871 871 840 840 820 780 800 760 778 778 833 833 638 638 638 638 600
%667 611 722 667 722 722 722 722 668 667 722 722 600 600 600 600 607 607 580 580 720 700 780 740 722 741 815 796 592 592 592 592 600
%556 500 556 556 667 667 667 667 525 556 611 556 600 600 600 600 498 498 520 520 660 640 660 700 630 667 667 685 547 547 547 547 460
%611 556 667 611 611 611 611 611 613 611 667 611 600 600 600 600 426 426 420 420 620 600 700 700 667 685 722 722 501 501 501 501 500
%722 722 722 722 722 722 722 722 778 778 778 778 600 600 600 600 655 655 640 640 780 720 740 740 815 815 833 833 592 592 592 592 740
%722 611 722 667 667 667 667 667 722 722 778 667 600 600 600 600 702 702 700 700 700 680 720 660 722 704 759 741 547 547 547 547 640
%944 833 1000 889 944 944 944 944 1000 944 1000 1000 600 600 600 600 960 960 900 900 960 960 940 1000 981 926 981 944 774 774 774 774 880
%722 611 722 667 667 667 667 667 667 722 667 722 600 600 600 600 609 609 680 680 720 700 780 740 704 704 722 741 547 547 547 547 560
%722 556 722 611 667 667 667 667 667 667 667 611 600 600 600 600 592 592 620 620 640 660 700 660 704 685 722 704 547 547 547 547 560
%611 556 667 611 611 611 611 611 667 667 667 667 600 600 600 600 480 480 500 500 640 580 640 680 611 667 667 704 501 501 501 501 620
%333 389 333 333 278 278 333 333 333 333 333 333 600 600 600 600 351 351 320 320 300 260 300 260 333 333 389 407 228 228 273 273 240
%278 278 278 278 278 278 278 278 606 606 606 606 600 600 600 600 605 605 640 640 600 600 600 580 606 606 606 606 228 228 228 228 480
%333 389 333 333 278 278 333 333 333 333 333 333 600 600 600 600 351 351 320 320 300 260 300 260 333 333 389 407 228 228 273 273 320
%469 422 581 570 469 469 584 584 606 606 606 606 600 600 600 600 606 606 600 600 600 600 600 620 606 606 606 606 385 385 479 479 520
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 500 500 500 500 500 500 500 500 500 500 500 500 456 456 456 456 500
%333 333 333 333 222 222 278 278 278 278 278 278 600 600 600 600 351 351 280 280 220 280 320 320 204 204 241 259 182 182 228 228 240
%444 500 500 500 556 556 556 556 500 444 500 556 600 600 600 600 683 683 660 660 580 620 580 680 556 574 611 667 456 456 456 456 420
%500 500 556 500 556 556 611 611 553 463 611 537 600 600 600 600 682 682 660 660 620 600 600 600 556 556 648 611 456 456 501 501 420
%444 444 444 444 500 500 556 556 444 407 444 444 600 600 600 600 647 647 640 640 520 480 580 560 444 444 556 537 410 410 456 456 340
%500 500 556 500 556 556 611 611 611 500 611 556 600 600 600 600 685 685 660 660 620 640 640 680 574 611 667 667 456 456 501 501 440
%444 444 444 444 556 556 556 556 479 389 500 444 600 600 600 600 650 650 640 640 520 540 580 560 500 444 574 519 456 456 456 456 340
%333 278 333 333 278 278 333 333 333 278 389 333 600 600 600 600 314 314 280 280 320 340 380 420 333 333 389 389 228 228 273 273 320
%500 500 500 500 556 556 611 611 556 500 556 500 600 600 600 600 673 673 660 660 540 560 580 620 537 537 611 611 456 456 501 501 400
%500 500 556 556 556 556 611 611 582 500 611 556 600 600 600 600 610 610 600 600 660 620 680 700 611 611 685 685 456 456 501 501 440
%278 278 278 278 222 222 278 278 291 278 333 333 600 600 600 600 200 200 240 240 300 280 360 380 315 333 370 389 182 182 228 228 240
%278 278 333 278 222 222 278 278 234 278 333 333 600 600 600 600 203 203 260 260 300 280 340 320 296 315 352 370 182 182 228 228 220
%500 444 556 500 500 500 556 556 556 444 611 556 600 600 600 600 502 502 580 580 620 600 660 700 593 556 667 648 410 410 456 456 440
%278 278 278 278 222 222 278 278 291 278 333 333 600 600 600 600 200 200 240 240 300 280 340 380 315 333 352 389 182 182 228 228 240
%778 722 833 778 833 833 889 889 883 778 889 833 600 600 600 600 938 938 940 940 940 880 1000 960 889 889 963 944 683 683 729 729 620
%500 500 556 556 556 556 611 611 582 556 611 556 600 600 600 600 610 610 600 600 660 620 680 680 611 611 685 685 456 456 501 501 460
%500 500 500 500 556 556 611 611 546 444 556 556 600 600 600 600 655 655 640 640 560 540 620 600 500 500 611 574 456 456 501 501 400
%500 500 556 500 556 556 611 611 601 500 611 556 600 600 600 600 682 682 660 660 620 600 640 660 574 574 667 648 456 456 501 501 440
%500 500 556 500 556 556 611 611 560 463 611 537 600 600 600 600 682 682 660 660 580 560 620 620 556 556 648 630 456 456 501 501 400
%333 389 444 389 333 333 389 389 395 389 389 389 600 600 600 600 301 301 320 320 440 400 460 500 444 444 519 519 273 273 319 319 300
%389 389 389 389 500 500 556 556 424 389 444 444 600 600 600 600 388 388 440 440 520 540 520 540 463 444 500 481 410 410 456 456 320
%278 278 333 278 278 278 333 333 326 333 333 389 600 600 600 600 339 339 300 300 380 340 460 440 389 352 426 407 228 228 273 273 320
%500 500 556 556 556 556 611 611 603 556 611 556 600 600 600 600 608 608 600 600 680 620 660 680 611 611 685 685 456 456 501 501 460
%500 444 500 444 500 500 556 556 565 500 556 556 600 600 600 600 554 554 560 560 520 540 600 540 537 519 611 556 410 410 456 456 440
%722 667 722 667 722 722 778 778 834 722 833 833 600 600 600 600 831 831 800 800 780 880 800 860 778 778 889 833 592 592 638 638 680
%500 444 500 500 500 500 556 556 516 500 500 500 600 600 600 600 480 480 560 560 560 540 600 620 537 500 611 574 410 410 456 456 420
%500 444 500 444 500 500 556 556 556 500 556 556 600 600 600 600 536 536 580 580 540 600 620 600 537 500 611 519 410 410 456 456 400
%444 389 444 389 500 500 500 500 500 444 500 500 600 600 600 600 425 425 460 460 480 520 560 560 481 463 537 519 410 410 410 410 440
%480 400 394 348 334 334 389 389 333 333 310 333 600 600 600 600 351 351 340 340 280 360 320 300 333 333 389 407 274 274 319 319 240
%200 275 220 220 260 260 280 280 606 606 606 606 600 600 600 600 672 672 600 600 600 600 600 620 606 606 606 606 213 213 230 230 520
%480 400 394 348 334 334 389 389 333 333 310 333 600 600 600 600 351 351 340 340 280 380 320 300 333 333 389 407 274 274 319 319 240
%541 541 520 570 584 584 584 584 606 606 606 606 600 600 600 600 606 606 600 600 600 600 600 620 606 606 606 606 479 479 479 479 520
%333 389 333 389 333 333 333 333 278 333 278 333 600 600 600 600 295 295 280 280 300 320 360 320 296 333 296 333 273 273 273 273 280
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%167 167 167 167 167 167 167 167 167 167 167 167 600 600 600 600 166 166 160 160 140 20 120 120 167 167 167 167 137 137 137 137 60
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%500 500 500 500 556 556 556 556 500 500 500 556 600 600 600 600 615 615 560 560 520 620 600 620 500 500 500 500 456 456 456 456 420
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 554 554 560 560 620 620 660 680 556 556 574 574 456 456 456 456 440
%180 214 278 278 191 191 238 238 208 333 227 250 600 600 600 600 198 198 220 220 220 200 240 180 204 278 241 287 157 157 195 195 160
%444 556 500 500 333 333 500 500 500 500 500 500 600 600 600 600 502 502 480 480 400 440 540 520 389 389 481 481 273 273 410 410 340
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 425 425 460 460 360 300 400 380 426 426 500 481 456 456 456 456 340
%333 333 333 333 333 333 333 333 331 333 389 333 600 600 600 600 251 251 240 240 240 180 220 220 259 333 333 278 273 273 273 273 240
%333 333 333 333 333 333 333 333 331 333 389 333 600 600 600 600 251 251 240 240 240 180 220 220 259 333 333 278 273 273 273 273 260
%556 500 556 556 500 500 611 611 605 528 611 611 600 600 600 600 487 487 520 520 620 640 740 820 611 611 685 685 410 410 501 501 520
%556 500 556 556 500 500 611 611 608 545 611 611 600 600 600 600 485 485 520 520 620 660 740 820 611 611 685 685 410 410 501 501 520
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 500 500 500 500 500 500 500 500 556 500 500 500 456 456 456 456 500
%500 500 500 500 556 556 556 556 500 500 500 556 600 600 600 600 553 553 560 560 540 620 440 420 500 500 500 500 456 456 456 456 460
%500 500 500 500 556 556 556 556 500 500 500 556 600 600 600 600 553 553 560 560 540 620 380 420 500 500 500 500 456 456 456 456 480
%250 250 250 250 278 278 278 278 250 250 250 250 600 600 600 600 277 277 280 280 320 300 340 340 278 278 278 287 228 228 228 228 220
%453 523 540 500 537 537 556 556 628 500 641 556 600 600 600 600 564 564 600 600 600 620 800 680 606 650 747 650 440 440 456 456 500
%350 350 350 350 350 350 350 350 606 500 606 606 600 600 600 600 606 606 600 600 460 460 460 360 606 606 606 606 287 287 287 287 600
%333 333 333 333 222 222 278 278 278 278 333 250 600 600 600 600 354 354 280 280 220 320 320 300 204 204 241 259 182 182 228 228 180
%444 556 500 500 333 333 500 500 500 500 500 500 600 600 600 600 502 502 480 480 400 480 540 520 389 389 481 481 273 273 410 410 280
%444 556 500 500 333 333 500 500 500 500 500 500 600 600 600 600 484 484 480 480 400 440 540 520 389 389 481 481 273 273 410 410 360
%500 500 500 500 556 556 556 556 500 500 500 500 600 600 600 600 425 425 460 460 360 300 400 380 426 426 500 481 456 456 456 456 380
%1000 889 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 600 600 600 600 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 820 820 820 820 1000
%1000 1000 1000 1000 1000 1000 1000 1000 1144 1000 1000 1000 600 600 600 600 1174 1174 1280 1280 1280 1180 1360 1360 1000 1000 1000 1167 820 820 820 820 960
%444 500 500 500 611 611 611 611 444 500 444 444 600 600 600 600 591 591 560 560 540 540 660 620 444 444 500 481 501 501 501 501 400
%333 333 333 333 333 333 333 333 333 333 333 333 600 600 600 600 378 378 420 420 340 340 400 380 333 333 333 333 273 273 273 273 220
%333 333 333 333 333 333 333 333 333 333 333 333 600 600 600 600 375 375 420 420 340 320 400 340 333 333 333 333 273 273 273 273 300
%333 333 333 333 333 333 333 333 333 333 333 333 600 600 600 600 502 502 540 540 420 440 500 480 333 333 333 333 273 273 273 273 340
%333 333 333 333 333 333 333 333 333 333 333 333 600 600 600 600 439 439 480 480 440 440 480 480 333 333 333 333 273 273 273 273 440
%333 333 333 333 333 333 333 333 333 333 333 333 600 600 600 600 485 485 420 420 440 440 460 480 333 333 333 333 273 273 273 273 440
%333 333 333 333 333 333 333 333 333 333 333 333 600 600 600 600 453 453 480 480 460 440 500 460 333 333 333 333 273 273 273 273 440
%333 333 333 333 333 333 333 333 250 333 333 333 600 600 600 600 222 222 280 280 260 260 320 380 333 333 333 333 273 273 273 273 220
%333 333 333 333 333 333 333 333 333 333 333 333 600 600 600 600 369 369 500 500 420 420 500 520 333 333 333 333 273 273 273 273 360
%333 333 333 333 333 333 333 333 333 333 333 556 600 600 600 600 332 332 360 360 320 300 340 360 333 333 333 333 273 273 273 273 300
%333 333 333 333 333 333 333 333 333 333 333 333 600 600 600 600 324 324 340 340 320 320 360 360 333 333 333 333 273 273 273 273 300
%333 333 333 333 333 333 333 333 380 333 333 333 600 600 600 600 552 552 700 700 380 340 440 560 333 333 333 333 273 273 273 273 400
%333 333 333 333 333 333 333 333 313 333 333 333 600 600 600 600 302 302 340 340 320 260 320 320 333 333 333 333 273 273 273 273 280
%333 333 333 333 333 333 333 333 333 333 333 333 600 600 600 600 502 502 540 540 420 440 500 480 333 333 333 333 273 273 273 273 340
%1000 889 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 600 600 600 600 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 820 820 820 820 1000
%889 889 1000 944 1000 1000 1000 1000 944 941 1000 944 600 600 600 600 992 992 900 900 1260 1220 1140 1140 1000 870 981 889 820 820 820 820 740
%276 276 300 266 370 370 370 370 333 333 438 333 600 600 600 600 369 369 360 360 420 440 400 440 334 422 367 412 303 303 303 303 260
%611 556 667 611 556 556 611 611 611 556 611 611 600 600 600 600 517 517 480 480 600 580 640 640 667 667 722 704 456 456 501 501 580
%722 722 778 722 778 778 778 778 833 778 833 833 600 600 600 600 868 868 840 840 800 760 800 760 778 778 833 833 638 638 638 638 660
%889 944 1000 944 1000 1000 1000 1000 998 1028 1000 944 600 600 600 600 1194 1194 1060 1060 1240 1180 1220 1180 1000 981 1000 963 820 820 820 820 820
%310 310 330 300 365 365 365 365 333 333 488 333 600 600 600 600 369 369 360 360 420 400 400 440 300 372 367 356 299 299 299 299 260
%667 667 722 722 889 889 889 889 758 638 778 738 600 600 600 600 1157 1157 1080 1080 860 880 880 880 796 722 870 815 729 729 729 729 540
%278 278 278 278 278 278 278 278 287 278 333 333 600 600 600 600 200 200 240 240 300 280 360 380 315 333 370 389 228 228 228 228 240
%278 278 278 278 222 222 278 278 291 278 333 333 600 600 600 600 300 300 320 320 320 340 340 380 315 333 352 389 182 182 228 228 300
%500 500 500 500 611 611 611 611 556 444 556 556 600 600 600 600 653 653 660 660 560 540 620 600 500 500 611 574 501 501 501 501 440
%722 667 722 722 944 944 944 944 827 669 833 778 600 600 600 600 1137 1137 1080 1080 900 900 940 920 833 778 907 852 774 774 774 774 560
%500 500 556 500 611 611 611 611 556 500 611 556 600 600 600 600 554 554 600 600 660 620 660 660 574 556 611 574 501 501 501 501 420
%611 556 667 611 611 611 611 611 667 667 667 667 600 600 600 600 480 480 500 500 640 580 640 680 611 667 667 704 501 501 501 501 620
%444 444 444 444 500 500 556 556 444 407 444 444 600 600 600 600 647 647 640 640 520 480 580 560 444 444 556 537 410 410 456 456 340
%500 444 500 444 500 500 556 556 556 500 556 556 600 600 600 600 536 536 580 580 540 600 620 600 537 500 611 519 410 410 456 456 400
%444 500 500 500 556 556 556 556 500 444 500 556 600 600 600 600 683 683 660 660 580 620 580 680 556 574 611 667 456 456 456 456 420
%278 278 278 278 278 278 278 278 287 278 333 333 600 600 600 600 200 200 240 240 300 280 360 380 315 333 370 389 228 228 228 228 240
%300 300 300 300 333 333 333 333 300 300 300 300 600 600 600 600 332 332 336 336 372 372 396 408 333 333 344 344 273 273 273 273 264
%444 444 444 444 556 556 556 556 479 389 500 444 600 600 600 600 650 650 640 640 520 540 580 560 500 444 574 519 456 456 456 456 340
%500 500 556 500 556 556 611 611 601 500 611 556 600 600 600 600 682 682 660 660 620 600 640 660 574 574 667 648 456 456 501 501 440
%444 444 444 444 556 556 556 556 479 389 500 444 600 600 600 600 650 650 640 640 520 540 580 560 500 444 574 519 456 456 456 456 340
%300 300 300 300 333 333 333 333 300 300 300 300 600 600 600 600 332 332 336 336 372 372 396 408 333 333 344 344 273 273 273 273 264
%444 444 444 444 556 556 556 556 479 389 500 444 600 600 600 600 650 650 640 640 520 540 580 560 500 444 574 519 456 456 456 456 340
%500 500 500 500 556 556 611 611 546 444 556 556 600 600 600 600 655 655 640 640 560 540 620 600 500 500 611 574 456 456 501 501 400
%722 611 722 667 667 667 722 722 778 722 778 722 600 600 600 600 740 740 740 740 680 700 720 720 722 704 759 741 547 547 592 592 620
%500 500 500 500 556 556 611 611 546 444 556 556 600 600 600 600 655 655 640 640 560 540 620 600 500 500 611 574 456 456 501 501 400
%500 444 500 444 500 500 556 556 556 500 556 556 600 600 600 600 536 536 580 580 540 600 620 600 537 500 611 519 410 410 456 456 400
%500 500 556 556 556 556 611 611 603 556 611 556 600 600 600 600 608 608 600 600 680 620 660 680 611 611 685 685 456 456 501 501 460
%750 750 750 750 834 834 834 834 750 750 750 750 600 600 600 600 831 831 840 840 930 930 990 1020 834 834 861 861 684 684 684 684 660
%444 500 500 500 556 556 556 556 500 444 500 556 600 600 600 600 683 683 660 660 580 620 580 680 556 574 611 667 456 456 456 456 420
%722 722 722 722 722 722 722 722 774 778 833 778 600 600 600 600 790 790 742 742 800 740 780 760 778 778 833 833 592 592 592 592 700
%444 444 444 444 556 556 556 556 479 389 500 444 600 600 600 600 650 650 640 640 520 540 580 560 500 444 574 519 456 456 456 456 340
%500 500 556 556 556 556 611 611 603 556 611 556 600 600 600 600 608 608 600 600 680 620 660 680 611 611 685 685 456 456 501 501 460
%980 980 1000 1000 1000 1000 1000 1000 979 1000 998 1000 600 600 600 600 1000 1000 1000 1000 980 980 980 940 1000 950 1000 950 820 820 820 820 1000
%500 500 500 500 556 556 611 611 546 444 556 556 600 600 600 600 655 655 640 640 560 540 620 600 500 500 611 574 456 456 501 501 400
%389 389 389 389 500 500 556 556 424 389 444 444 600 600 600 600 388 388 440 440 520 540 520 540 463 444 500 481 410 410 456 456 320
%333 333 389 389 278 278 278 278 337 333 389 389 600 600 600 600 226 226 280 280 340 320 400 380 407 407 444 444 228 228 228 228 380
%500 500 556 556 556 556 611 611 603 556 611 556 600 600 600 600 608 608 600 600 680 620 660 680 611 611 685 685 456 456 501 501 460
%444 500 500 500 556 556 556 556 500 444 500 556 600 600 600 600 683 683 660 660 580 620 580 680 556 574 611 667 456 456 456 456 420
%500 500 556 556 556 556 611 611 582 556 611 556 600 600 600 600 610 610 600 600 660 620 680 680 611 611 685 685 456 456 501 501 460
%444 500 500 500 556 556 556 556 500 444 500 556 600 600 600 600 683 683 660 660 580 620 580 680 556 574 611 667 456 456 456 456 420
%444 389 444 389 500 500 500 500 500 444 500 500 600 600 600 600 425 425 460 460 480 520 560 560 481 463 537 519 410 410 410 410 440
%333 333 389 389 278 278 278 278 337 333 389 389 600 600 600 600 226 226 280 280 340 320 400 380 407 407 444 444 228 228 228 228 380
%722 667 722 722 722 722 722 722 831 778 833 778 600 600 600 600 740 740 740 740 740 720 740 740 815 815 833 852 592 592 592 592 700
%500 500 556 556 556 556 611 611 603 556 611 556 600 600 600 600 608 608 600 600 680 620 660 680 611 611 685 685 456 456 501 501 460
%611 611 667 667 667 667 667 667 611 611 611 611 600 600 600 600 536 536 520 520 720 680 720 720 722 722 759 741 547 547 547 547 620
%333 333 389 389 278 278 278 278 337 333 389 389 600 600 600 600 226 226 280 280 340 320 400 380 407 407 444 444 228 228 228 228 380
%667 667 722 667 722 722 722 722 709 667 722 685 600 600 600 600 813 813 780 780 740 720 740 700 722 722 778 759 592 592 592 592 520
%722 722 778 722 778 778 778 778 786 778 833 833 600 600 600 600 869 869 840 840 800 760 800 760 778 778 833 833 638 638 638 638 600
%556 500 556 556 667 667 667 667 525 556 611 556 600 600 600 600 498 498 520 520 660 640 660 700 630 667 667 685 547 547 547 547 460
%611 611 667 667 667 667 667 667 611 611 611 611 600 600 600 600 536 536 520 520 720 680 720 720 722 722 759 741 547 547 547 547 620
%333 333 389 389 278 278 278 278 337 333 389 389 600 600 600 600 226 226 280 280 340 320 400 380 407 407 444 444 228 228 228 228 380
%444 500 500 500 556 556 556 556 500 444 500 556 600 600 600 600 683 683 660 660 580 620 580 680 556 574 611 667 456 456 456 456 420
%722 722 778 722 778 778 778 778 786 778 833 833 600 600 600 600 869 869 840 840 800 760 800 760 778 778 833 833 638 638 638 638 600
%611 611 667 667 667 667 667 667 611 611 611 611 600 600 600 600 536 536 520 520 720 680 720 720 722 722 759 741 547 547 547 547 620
%722 556 722 611 667 667 667 667 667 667 667 611 600 600 600 600 592 592 620 620 640 660 700 660 704 685 722 704 547 547 547 547 560
%760 760 747 747 737 737 737 737 747 747 747 747 600 600 600 600 747 747 740 740 740 740 740 780 737 747 747 747 604 604 604 604 740
%722 722 778 722 778 778 778 778 786 778 833 833 600 600 600 600 869 869 840 840 800 760 800 760 778 778 833 833 638 638 638 638 600
%750 750 750 750 834 834 834 834 750 750 750 750 600 600 600 600 831 831 840 840 930 930 990 1020 834 834 861 861 684 684 684 684 660
%722 722 722 722 722 722 722 722 778 778 778 778 600 600 600 600 655 655 640 640 780 720 740 740 815 815 833 833 592 592 592 592 740
%722 722 722 722 722 722 722 722 778 778 778 778 600 600 600 600 655 655 640 640 780 720 740 740 815 815 833 833 592 592 592 592 740
%556 611 611 611 667 667 667 667 604 611 611 667 600 600 600 600 592 592 560 560 620 600 660 640 667 667 759 741 547 547 547 547 540
%564 675 570 570 584 584 584 584 606 606 606 606 600 600 600 600 606 606 600 600 600 600 600 600 606 606 606 606 479 479 479 479 520
%722 611 722 667 667 667 722 722 778 722 778 722 600 600 600 600 740 740 740 740 680 700 720 720 722 704 759 741 547 547 592 592 620
%722 722 722 722 722 722 722 722 778 778 778 778 600 600 600 600 655 655 640 640 780 720 740 740 815 815 833 833 592 592 592 592 740
%722 722 778 722 778 778 778 778 786 778 833 833 600 600 600 600 869 869 840 840 800 760 800 760 778 778 833 833 638 638 638 638 600
%564 675 570 606 584 584 584 584 606 606 606 606 600 600 600 600 606 606 600 600 600 600 600 620 606 606 606 606 479 479 479 479 520
%722 611 722 667 667 667 722 722 778 722 778 722 600 600 600 600 740 740 740 740 680 700 720 720 722 704 759 741 547 547 592 592 620
%278 278 278 278 278 278 278 278 287 278 333 333 600 600 600 600 200 200 240 240 300 280 360 380 315 333 370 389 228 228 228 228 240
%278 278 278 278 278 278 278 278 287 278 333 333 600 600 600 600 200 200 240 240 300 280 360 380 315 333 370 389 228 228 228 228 240
%444 500 500 500 556 556 556 556 500 444 500 556 600 600 600 600 683 683 660 660 580 620 580 680 556 574 611 667 456 456 456 456 420
%564 675 570 570 584 584 584 584 606 606 606 606 600 600 600 600 606 606 600 600 600 600 600 600 606 606 606 606 479 479 479 479 520
%564 675 570 570 584 584 584 584 606 606 606 606 600 600 600 600 606 606 600 600 600 600 600 600 606 606 606 606 479 479 479 479 520
%722 722 722 722 722 722 722 722 778 778 778 778 600 600 600 600 655 655 640 640 780 720 740 740 815 815 833 833 592 592 592 592 740
%564 675 570 606 584 584 584 584 606 606 606 606 600 600 600 600 606 606 600 600 600 600 600 600 606 606 606 606 479 479 479 479 520
%300 300 300 300 333 333 333 333 300 300 300 300 600 600 600 600 332 332 336 336 372 372 396 408 333 333 344 344 273 273 273 273 264
%611 611 667 667 667 667 667 667 611 611 611 611 600 600 600 600 536 536 520 520 720 680 720 720 722 722 759 741 547 547 547 547 620
%722 611 722 667 667 667 722 722 778 722 778 722 600 600 600 600 740 740 740 740 680 700 720 720 722 704 759 741 547 547 592 592 620
%760 760 747 747 737 737 737 737 747 747 747 747 600 600 600 600 747 747 740 740 740 740 740 780 737 747 747 747 604 604 604 604 740
%722 611 722 667 667 667 722 722 778 722 778 722 600 600 600 600 740 740 740 740 680 700 720 720 722 704 759 741 547 547 592 592 620
%500 500 500 500 556 556 611 611 546 444 556 556 600 600 600 600 655 655 640 640 560 540 620 600 500 500 611 574 456 456 501 501 400
%500 500 500 500 556 556 611 611 546 444 556 556 600 600 600 600 655 655 640 640 560 540 620 600 500 500 611 574 456 456 501 501 400
%400 400 400 400 400 400 400 400 400 400 400 400 600 600 600 600 400 400 400 400 400 400 400 400 400 400 400 400 328 328 328 328 400
%278 278 278 278 278 278 278 278 287 278 333 333 600 600 600 600 200 200 240 240 300 280 360 380 315 333 370 389 228 228 228 228 240
%500 500 556 576 556 556 611 611 603 556 611 556 600 600 600 600 608 608 576 576 680 620 660 680 611 611 685 685 456 456 501 501 460
%722 722 778 722 778 778 778 778 786 778 833 833 600 600 600 600 869 869 840 840 800 760 800 760 778 778 833 833 638 638 638 638 600
%500 500 500 500 556 556 611 611 546 444 556 556 600 600 600 600 655 655 640 640 560 540 620 600 500 500 611 574 456 456 501 501 400
%722 611 722 667 667 667 722 722 778 722 778 722 600 600 600 600 740 740 740 740 680 700 720 720 722 704 759 741 547 547 592 592 620
%722 556 722 611 667 667 667 667 667 667 667 611 600 600 600 600 592 592 620 620 640 660 700 660 704 685 722 704 547 547 547 547 560
%200 275 220 220 260 260 280 280 606 606 606 606 600 600 600 600 672 672 600 600 600 600 600 620 606 606 606 606 213 213 230 230 520
%750 750 750 750 834 834 834 834 750 750 750 750 600 600 600 600 831 831 840 840 930 930 990 1020 834 834 861 861 684 684 684 684 660
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%0 0 0 0 0 0 0 0 0 0 0 0 600 600 600 600 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%EndRomanCharWidths
%
%BeginSymbolCharWidths 189
%250
%333
%713
%500
%549
%833
%778
%439
%333
%333
%500
%549
%250
%549
%250
%278
%500
%500
%500
%500
%500
%500
%500
%500
%500
%500
%278
%278
%549
%549
%549
%444
%549
%722
%667
%722
%612
%611
%763
%603
%722
%333
%631
%722
%686
%889
%722
%722
%768
%741
%556
%592
%611
%690
%439
%768
%645
%795
%611
%333
%863
%333
%658
%500
%500
%631
%549
%549
%494
%439
%521
%411
%603
%329
%603
%549
%549
%576
%521
%549
%549
%521
%549
%603
%439
%576
%713
%686
%493
%686
%494
%480
%200
%480
%549
%620
%247
%549
%167
%713
%500
%753
%753
%753
%753
%1042
%987
%603
%987
%603
%400
%549
%411
%549
%549
%713
%494
%460
%549
%549
%549
%549
%1000
%603
%1000
%658
%823
%686
%795
%987
%768
%768
%823
%768
%768
%713
%713
%713
%713
%713
%713
%713
%768
%713
%790
%790
%890
%823
%549
%250
%713
%603
%603
%1042
%987
%603
%987
%603
%494
%329
%790
%790
%786
%713
%384
%384
%384
%384
%384
%384
%494
%494
%494
%494
%329
%274
%686
%686
%686
%384
%384
%384
%384
%384
%384
%494
%494
%494
%790
%EndSymbolCharWidths
%
%BeginZapfDingbatsCharWidths 202
%278
%974
%961
%974
%980
%719
%789
%790
%791
%690
%960
%939
%549
%855
%911
%933
%911
%945
%974
%755
%846
%762
%761
%571
%677
%763
%760
%759
%754
%494
%552
%537
%577
%692
%786
%788
%788
%790
%793
%794
%816
%823
%789
%841
%823
%833
%816
%831
%923
%744
%723
%749
%790
%792
%695
%776
%768
%792
%759
%707
%708
%682
%701
%826
%815
%789
%789
%707
%687
%696
%689
%786
%787
%713
%791
%785
%791
%873
%761
%762
%762
%759
%759
%892
%892
%788
%784
%438
%138
%277
%415
%392
%392
%668
%668
%732
%544
%544
%910
%667
%760
%760
%776
%595
%694
%626
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%788
%894
%838
%1016
%458
%748
%924
%748
%918
%927
%928
%928
%834
%873
%828
%924
%924
%917
%930
%931
%463
%883
%836
%836
%867
%867
%696
%696
%874
%874
%760
%946
%771
%865
%771
%888
%967
%888
%831
%873
%927
%970
%918
%410
%509
%334
%509
%390
%234
%276
%390
%410
%317
%317
%276
%334
%234
%EndZapfDingbatsCharWidths
%
%BeginKernData 5039
%1 34 90 -92
%1 34 88 -92
%1 34 87 -74
%1 34 8 -111
%1 34 58 -105
%1 34 56 -90
%1 34 55 -135
%1 34 54 -55
%1 34 53 -111
%1 34 50 -55
%1 34 48 -55
%1 34 40 -40
%1 34 36 -40
%1 35 54 -10
%1 35 34 -35
%1 37 58 -55
%1 37 56 -30
%1 37 55 -40
%1 37 34 -40
%1 39 15 -80
%1 39 80 -15
%1 39 13 -80
%1 39 66 -15
%1 39 34 -74
%1 43 34 -60
%1 44 90 -25
%1 44 86 -15
%1 44 80 -35
%1 44 70 -25
%1 44 48 -30
%1 45 90 -55
%1 45 8 -92
%1 45 58 -100
%1 45 56 -74
%1 45 55 -100
%1 45 53 -92
%1 47 34 -35
%1 48 58 -50
%1 48 57 -40
%1 48 56 -35
%1 48 55 -50
%1 48 53 -40
%1 48 34 -35
%1 49 15 -111
%1 49 13 -111
%1 49 66 -15
%1 49 34 -92
%1 50 54 -10
%1 51 58 -65
%1 51 56 -55
%1 51 55 -80
%1 51 54 -40
%1 51 53 -60
%1 51 48 -40
%1 53 90 -80
%1 53 88 -80
%1 53 86 -45
%1 53 28 -55
%1 53 83 -35
%1 53 15 -74
%1 53 80 -80
%1 53 74 -35
%1 53 14 -92
%1 53 70 -70
%1 53 13 -74
%1 53 27 -50
%1 53 66 -80
%1 53 48 -18
%1 53 34 -93
%1 54 34 -40
%1 55 86 -75
%1 55 28 -74
%1 55 15 -129
%1 55 80 -129
%1 55 74 -60
%1 55 14 -100
%1 55 70 -111
%1 55 13 -129
%1 55 27 -74
%1 55 66 -111
%1 55 48 -40
%1 55 40 -15
%1 55 34 -135
%1 56 90 -73
%1 56 86 -50
%1 56 28 -37
%1 56 15 -92
%1 56 80 -80
%1 56 74 -40
%1 56 14 -65
%1 56 70 -80
%1 56 13 -92
%1 56 27 -37
%1 56 66 -80
%1 56 48 -10
%1 56 34 -120
%1 58 86 -111
%1 58 28 -92
%1 58 15 -129
%1 58 80 -110
%1 58 74 -55
%1 58 14 -111
%1 58 70 -100
%1 58 13 -129
%1 58 27 -92
%1 58 66 -100
%1 58 48 -30
%1 58 34 -120
%1 66 88 -15
%1 66 87 -20
%1 67 87 -15
%1 67 86 -20
%1 67 15 -40
%1 68 90 -15
%1 13 8 -70
%1 13 119 -70
%1 70 90 -15
%1 70 89 -15
%1 70 88 -25
%1 70 87 -25
%1 70 72 -15
%1 71 8 55
%1 71 74 -20
%1 71 71 -25
%1 71 145 -50
%1 71 66 -10
%1 72 66 -5
%1 73 90 -5
%1 74 87 -25
%1 76 90 -15
%1 76 80 -10
%1 76 70 -10
%1 77 88 -10
%1 79 90 -15
%1 79 87 -40
%1 80 90 -10
%1 80 88 -25
%1 80 87 -15
%1 81 90 -10
%1 15 8 -70
%1 15 119 -70
%1 105 34 -80
%1 65 65 -74
%1 65 34 -80
%1 8 87 -50
%1 8 85 -18
%1 8 1 -74
%1 8 84 -55
%1 8 83 -50
%1 8 8 -74
%1 8 77 -10
%1 8 69 -50
%1 83 15 -55
%1 83 14 -20
%1 83 72 -18
%1 83 13 -40
%1 1 58 -90
%1 1 56 -30
%1 1 55 -50
%1 1 53 -18
%1 1 34 -55
%1 87 15 -65
%1 87 80 -20
%1 87 70 -15
%1 87 13 -65
%1 87 66 -25
%1 88 15 -65
%1 88 80 -10
%1 88 13 -65
%1 88 66 -10
%1 89 70 -15
%1 90 15 -65
%1 90 13 -65
%2 34 90 -55
%2 34 88 -55
%2 34 87 -55
%2 34 86 -20
%2 34 8 -37
%2 34 58 -55
%2 34 56 -95
%2 34 55 -105
%2 34 54 -50
%2 34 53 -37
%2 34 50 -40
%2 34 48 -40
%2 34 40 -35
%2 34 36 -30
%2 35 54 -10
%2 35 34 -25
%2 37 58 -40
%2 37 56 -40
%2 37 55 -40
%2 37 34 -35
%2 39 83 -55
%2 39 15 -135
%2 39 80 -105
%2 39 74 -45
%2 39 70 -75
%2 39 13 -135
%2 39 66 -75
%2 39 34 -115
%2 43 86 -35
%2 43 15 -25
%2 43 80 -25
%2 43 70 -25
%2 43 13 -25
%2 43 66 -35
%2 43 34 -40
%2 44 90 -40
%2 44 86 -40
%2 44 80 -40
%2 44 70 -35
%2 44 48 -50
%2 45 90 -30
%2 45 8 -37
%2 45 58 -20
%2 45 56 -55
%2 45 55 -55
%2 45 53 -20
%2 47 34 -27
%2 48 58 -50
%2 48 57 -40
%2 48 56 -50
%2 48 55 -50
%2 48 53 -40
%2 48 34 -55
%2 49 15 -135
%2 49 80 -80
%2 49 70 -80
%2 49 13 -135
%2 49 66 -80
%2 49 34 -90
%2 50 54 -10
%2 51 58 -18
%2 51 56 -18
%2 51 55 -18
%2 51 54 -40
%2 51 48 -40
%2 53 90 -74
%2 53 88 -74
%2 53 86 -55
%2 53 28 -65
%2 53 83 -55
%2 53 15 -74
%2 53 80 -92
%2 53 74 -55
%2 53 14 -74
%2 53 70 -92
%2 53 13 -74
%2 53 27 -55
%2 53 66 -92
%2 53 48 -18
%2 53 34 -50
%2 54 15 -25
%2 54 13 -25
%2 54 34 -40
%2 55 86 -74
%2 55 28 -74
%2 55 15 -129
%2 55 80 -111
%2 55 74 -74
%2 55 14 -55
%2 55 70 -111
%2 55 13 -129
%2 55 27 -65
%2 55 66 -111
%2 55 48 -30
%2 55 34 -60
%2 56 90 -70
%2 56 86 -55
%2 56 28 -65
%2 56 15 -92
%2 56 80 -92
%2 56 74 -55
%2 56 14 -37
%2 56 70 -92
%2 56 13 -92
%2 56 27 -65
%2 56 66 -92
%2 56 48 -25
%2 56 34 -60
%2 58 86 -92
%2 58 28 -65
%2 58 15 -92
%2 58 80 -92
%2 58 74 -74
%2 58 14 -74
%2 58 70 -92
%2 58 13 -92
%2 58 27 -65
%2 58 66 -92
%2 58 48 -15
%2 58 34 -50
%2 66 72 -10
%2 67 86 -20
%2 67 15 -40
%2 68 76 -20
%2 68 73 -15
%2 13 8 -140
%2 13 119 -140
%2 70 90 -30
%2 70 89 -20
%2 70 88 -15
%2 70 87 -15
%2 70 15 -15
%2 70 72 -40
%2 70 13 -10
%2 71 8 92
%2 71 15 -15
%2 71 74 -20
%2 71 71 -18
%2 71 145 -60
%2 71 13 -10
%2 72 15 -15
%2 72 72 -10
%2 72 70 -10
%2 72 13 -10
%2 76 90 -10
%2 76 80 -10
%2 76 70 -10
%2 79 87 -40
%2 80 87 -10
%2 80 72 -10
%2 15 8 -140
%2 15 119 -140
%2 65 65 -111
%2 8 87 -10
%2 8 85 -30
%2 8 1 -111
%2 8 84 -40
%2 8 83 -25
%2 8 8 -111
%2 8 69 -25
%2 83 84 -10
%2 83 82 -37
%2 83 15 -111
%2 83 80 -45
%2 83 14 -20
%2 83 72 -37
%2 83 70 -37
%2 83 69 -37
%2 83 13 -111
%2 83 68 -37
%2 83 66 -15
%2 1 58 -75
%2 1 56 -40
%2 1 55 -35
%2 1 53 -18
%2 1 34 -18
%2 87 15 -74
%2 87 13 -74
%2 88 15 -74
%2 88 13 -74
%2 90 15 -55
%2 90 13 -55
%3 34 90 -74
%3 34 88 -90
%3 34 87 -100
%3 34 86 -50
%3 34 8 -74
%3 34 81 -25
%3 34 58 -100
%3 34 56 -130
%3 34 55 -145
%3 34 54 -50
%3 34 53 -95
%3 34 50 -45
%3 34 48 -45
%3 34 40 -55
%3 34 36 -55
%3 35 54 -10
%3 35 34 -30
%3 37 15 -20
%3 37 58 -40
%3 37 56 -40
%3 37 55 -40
%3 37 34 -35
%3 39 15 -110
%3 39 80 -25
%3 39 70 -25
%3 39 13 -92
%3 39 66 -25
%3 39 34 -90
%3 43 86 -15
%3 43 15 -20
%3 43 80 -15
%3 43 70 -15
%3 43 66 -15
%3 43 34 -30
%3 44 90 -45
%3 44 86 -15
%3 44 80 -25
%3 44 70 -25
%3 44 48 -30
%3 45 90 -55
%3 45 8 -110
%3 45 119 -20
%3 45 58 -92
%3 45 56 -92
%3 45 55 -92
%3 45 53 -92
%3 47 34 -20
%3 48 58 -50
%3 48 57 -40
%3 48 56 -50
%3 48 55 -50
%3 48 53 -40
%3 48 34 -40
%3 49 15 -110
%3 49 80 -20
%3 49 70 -20
%3 49 13 -92
%3 49 66 -10
%3 49 34 -74
%3 50 15 -20
%3 50 54 -10
%3 51 58 -35
%3 51 56 -35
%3 51 55 -55
%3 51 54 -30
%3 51 53 -40
%3 51 48 -30
%3 53 90 -74
%3 53 88 -74
%3 53 86 -92
%3 53 28 -74
%3 53 83 -74
%3 53 15 -90
%3 53 80 -92
%3 53 74 -18
%3 53 14 -92
%3 53 70 -92
%3 53 13 -74
%3 53 27 -74
%3 53 66 -92
%3 53 48 -18
%3 53 34 -90
%3 54 15 -50
%3 54 13 -50
%3 54 34 -60
%3 55 86 -92
%3 55 28 -92
%3 55 15 -145
%3 55 80 -100
%3 55 74 -37
%3 55 14 -74
%3 55 70 -100
%3 55 13 -129
%3 55 27 -92
%3 55 66 -92
%3 55 48 -45
%3 55 40 -30
%3 55 34 -135
%3 56 90 -60
%3 56 86 -50
%3 56 28 -55
%3 56 15 -92
%3 56 80 -75
%3 56 74 -18
%3 56 14 -37
%3 56 70 -65
%3 56 13 -92
%3 56 27 -55
%3 56 66 -65
%3 56 48 -10
%3 56 34 -120
%3 58 86 -92
%3 58 28 -92
%3 58 15 -92
%3 58 80 -111
%3 58 74 -37
%3 58 14 -92
%3 58 70 -111
%3 58 13 -92
%3 58 27 -92
%3 58 66 -85
%3 58 48 -35
%3 58 34 -110
%3 66 87 -25
%3 67 87 -15
%3 67 86 -20
%3 67 15 -40
%3 67 67 -10
%3 13 8 -55
%3 13 119 -45
%3 69 88 -15
%3 70 87 -15
%3 71 8 55
%3 71 119 50
%3 71 15 -15
%3 71 80 -25
%3 71 74 -25
%3 71 145 -35
%3 71 13 -15
%3 72 15 -15
%3 73 90 -15
%3 74 87 -10
%3 76 90 -15
%3 76 80 -15
%3 76 70 -10
%3 79 87 -40
%3 80 88 -10
%3 80 87 -10
%3 15 8 -55
%3 15 119 -55
%3 105 34 -10
%3 65 65 -63
%3 65 34 -10
%3 8 87 -20
%3 8 1 -74
%3 8 84 -37
%3 8 83 -20
%3 8 8 -63
%3 8 69 -20
%3 83 87 -10
%3 83 82 -18
%3 83 15 -100
%3 83 81 -10
%3 83 80 -18
%3 83 79 -15
%3 83 14 -37
%3 83 72 -10
%3 83 70 -18
%3 83 13 -92
%3 83 68 -18
%3 1 58 -55
%3 1 56 -30
%3 1 55 -45
%3 1 53 -30
%3 1 34 -55
%3 87 15 -70
%3 87 80 -10
%3 87 70 -10
%3 87 13 -55
%3 87 66 -10
%3 88 15 -70
%3 88 80 -10
%3 88 13 -55
%3 90 15 -70
%3 90 80 -25
%3 90 70 -10
%3 90 13 -55
%4 34 90 -74
%4 34 88 -74
%4 34 87 -74
%4 34 86 -30
%4 34 8 -74
%4 34 58 -70
%4 34 56 -100
%4 34 55 -95
%4 34 54 -50
%4 34 53 -55
%4 34 50 -55
%4 34 48 -50
%4 34 40 -60
%4 34 36 -65
%4 35 54 -10
%4 35 34 -25
%4 37 58 -50
%4 37 56 -40
%4 37 55 -50
%4 37 34 -25
%4 39 83 -50
%4 39 15 -129
%4 39 80 -70
%4 39 74 -40
%4 39 70 -100
%4 39 13 -129
%4 39 66 -95
%4 39 34 -100
%4 43 86 -40
%4 43 15 -10
%4 43 80 -40
%4 43 70 -40
%4 43 13 -10
%4 43 66 -40
%4 43 34 -25
%4 44 90 -20
%4 44 86 -20
%4 44 80 -25
%4 44 70 -25
%4 44 48 -30
%4 45 90 -37
%4 45 8 -55
%4 45 58 -37
%4 45 56 -37
%4 45 55 -37
%4 45 53 -18
%4 47 34 -30
%4 48 58 -50
%4 48 57 -40
%4 48 56 -50
%4 48 55 -50
%4 48 53 -40
%4 48 34 -40
%4 49 15 -129
%4 49 80 -55
%4 49 70 -50
%4 49 13 -129
%4 49 66 -40
%4 49 34 -85
%4 50 54 -10
%4 51 58 -18
%4 51 56 -18
%4 51 55 -18
%4 51 54 -40
%4 51 53 -30
%4 51 48 -40
%4 53 90 -37
%4 53 88 -37
%4 53 86 -37
%4 53 28 -74
%4 53 83 -37
%4 53 15 -92
%4 53 80 -95
%4 53 74 -37
%4 53 14 -92
%4 53 70 -92
%4 53 13 -92
%4 53 27 -74
%4 53 66 -92
%4 53 48 -18
%4 53 34 -55
%4 54 34 -45
%4 55 86 -55
%4 55 28 -74
%4 55 15 -129
%4 55 80 -111
%4 55 74 -55
%4 55 14 -70
%4 55 70 -111
%4 55 13 -129
%4 55 27 -74
%4 55 66 -111
%4 55 48 -30
%4 55 40 -10
%4 55 34 -85
%4 56 90 -55
%4 56 86 -55
%4 56 28 -55
%4 56 15 -74
%4 56 80 -80
%4 56 74 -37
%4 56 14 -50
%4 56 70 -90
%4 56 13 -74
%4 56 27 -55
%4 56 66 -85
%4 56 48 -15
%4 56 34 -74
%4 58 86 -92
%4 58 28 -92
%4 58 15 -74
%4 58 80 -111
%4 58 74 -55
%4 58 14 -92
%4 58 70 -111
%4 58 13 -92
%4 58 27 -92
%4 58 66 -92
%4 58 48 -25
%4 58 34 -74
%4 67 86 -20
%4 67 15 -40
%4 67 67 -10
%4 68 76 -10
%4 68 73 -10
%4 13 8 -95
%4 13 119 -95
%4 70 67 -10
%4 71 8 55
%4 71 15 -10
%4 71 80 -10
%4 71 71 -18
%4 71 70 -10
%4 71 145 -30
%4 71 13 -10
%4 76 80 -10
%4 76 70 -30
%4 79 87 -40
%4 80 90 -10
%4 80 89 -10
%4 80 88 -25
%4 80 87 -15
%4 15 8 -95
%4 15 119 -95
%4 65 65 -74
%4 8 87 -15
%4 8 85 -37
%4 8 1 -74
%4 8 84 -74
%4 8 83 -15
%4 8 8 -74
%4 8 69 -15
%4 83 15 -65
%4 83 13 -65
%4 1 58 -70
%4 1 56 -70
%4 1 55 -70
%4 1 34 -37
%4 87 15 -37
%4 87 80 -15
%4 87 70 -15
%4 87 13 -37
%4 88 15 -37
%4 88 80 -15
%4 88 70 -10
%4 88 13 -37
%4 88 66 -10
%4 89 70 -10
%4 90 15 -37
%4 90 13 -37
%5 34 90 -40
%5 34 88 -40
%5 34 87 -40
%5 34 86 -30
%5 34 58 -100
%5 34 56 -50
%5 34 55 -70
%5 34 54 -50
%5 34 53 -120
%5 34 50 -30
%5 34 48 -30
%5 34 40 -30
%5 34 36 -30
%5 35 15 -20
%5 35 13 -20
%5 35 54 -10
%5 36 15 -30
%5 36 13 -30
%5 37 15 -70
%5 37 13 -70
%5 37 58 -90
%5 37 56 -40
%5 37 55 -70
%5 37 34 -40
%5 39 83 -45
%5 39 15 -150
%5 39 80 -30
%5 39 70 -30
%5 39 13 -150
%5 39 66 -50
%5 39 34 -80
%5 43 86 -20
%5 43 15 -30
%5 43 13 -30
%5 43 66 -20
%5 43 34 -20
%5 44 90 -50
%5 44 86 -30
%5 44 80 -40
%5 44 70 -40
%5 44 48 -50
%5 45 90 -30
%5 45 8 -160
%5 45 119 -140
%5 45 58 -140
%5 45 56 -70
%5 45 55 -110
%5 45 53 -110
%5 48 15 -40
%5 48 13 -40
%5 48 58 -70
%5 48 57 -60
%5 48 56 -30
%5 48 55 -50
%5 48 53 -40
%5 48 34 -20
%5 49 15 -180
%5 49 80 -50
%5 49 70 -50
%5 49 13 -180
%5 49 66 -40
%5 49 34 -120
%5 50 54 -10
%5 51 58 -50
%5 51 56 -30
%5 51 55 -50
%5 51 54 -40
%5 51 53 -30
%5 51 48 -20
%5 52 15 -20
%5 52 13 -20
%5 53 90 -120
%5 53 88 -120
%5 53 86 -120
%5 53 28 -20
%5 53 83 -120
%5 53 15 -120
%5 53 80 -120
%5 53 14 -140
%5 53 70 -120
%5 53 13 -120
%5 53 27 -20
%5 53 66 -120
%5 53 48 -40
%5 53 34 -120
%5 54 15 -40
%5 54 13 -40
%5 54 34 -40
%5 55 86 -70
%5 55 28 -40
%5 55 15 -125
%5 55 80 -80
%5 55 14 -80
%5 55 70 -80
%5 55 13 -125
%5 55 27 -40
%5 55 66 -70
%5 55 48 -40
%5 55 40 -40
%5 55 34 -80
%5 56 90 -20
%5 56 86 -30
%5 56 15 -80
%5 56 80 -30
%5 56 14 -40
%5 56 70 -30
%5 56 13 -80
%5 56 66 -40
%5 56 48 -20
%5 56 34 -50
%5 58 86 -110
%5 58 28 -60
%5 58 15 -140
%5 58 80 -140
%5 58 74 -20
%5 58 14 -140
%5 58 70 -140
%5 58 13 -140
%5 58 27 -60
%5 58 66 -140
%5 58 48 -85
%5 58 34 -110
%5 66 90 -30
%5 66 88 -20
%5 66 87 -20
%5 67 90 -20
%5 67 87 -20
%5 67 86 -20
%5 67 15 -40
%5 67 77 -20
%5 67 13 -40
%5 67 67 -10
%5 68 76 -20
%5 68 13 -15
%5 27 1 -50
%5 13 8 -100
%5 13 119 -100
%5 70 90 -20
%5 70 89 -30
%5 70 88 -20
%5 70 87 -30
%5 70 15 -15
%5 70 13 -15
%5 71 8 50
%5 71 119 60
%5 71 15 -30
%5 71 80 -30
%5 71 70 -30
%5 71 145 -28
%5 71 13 -30
%5 71 66 -30
%5 72 83 -10
%5 73 90 -30
%5 76 80 -20
%5 76 70 -20
%5 78 90 -15
%5 78 86 -10
%5 79 90 -15
%5 79 87 -20
%5 79 86 -10
%5 80 90 -30
%5 80 89 -30
%5 80 88 -15
%5 80 87 -15
%5 80 15 -40
%5 80 13 -40
%5 147 91 -55
%5 147 90 -70
%5 147 89 -85
%5 147 88 -70
%5 147 87 -70
%5 147 86 -55
%5 147 85 -55
%5 147 84 -55
%5 147 83 -55
%5 147 82 -55
%5 147 15 -95
%5 147 81 -55
%5 147 80 -55
%5 147 79 -55
%5 147 78 -55
%5 147 77 -55
%5 147 76 -55
%5 147 75 -55
%5 147 74 -55
%5 147 73 -55
%5 147 72 -55
%5 147 71 -55
%5 147 70 -55
%5 147 69 -55
%5 147 13 -95
%5 147 68 -55
%5 147 67 -55
%5 147 66 -55
%5 81 90 -30
%5 81 15 -35
%5 81 13 -35
%5 15 1 -60
%5 15 8 -100
%5 15 119 -100
%5 119 1 -40
%5 65 65 -57
%5 8 1 -70
%5 8 84 -50
%5 8 83 -50
%5 8 8 -57
%5 8 69 -50
%5 83 90 30
%5 83 87 30
%5 83 86 15
%5 83 85 40
%5 83 28 30
%5 83 15 -50
%5 83 81 30
%5 83 79 25
%5 83 78 25
%5 83 77 15
%5 83 76 15
%5 83 74 15
%5 83 13 -50
%5 83 27 30
%5 83 66 -10
%5 84 88 -30
%5 84 15 -15
%5 84 13 -15
%5 28 1 -50
%5 1 65 -60
%5 1 105 -30
%5 1 58 -90
%5 1 56 -40
%5 1 55 -50
%5 1 53 -50
%5 87 15 -80
%5 87 80 -25
%5 87 70 -25
%5 87 13 -80
%5 87 66 -25
%5 88 15 -60
%5 88 80 -10
%5 88 70 -10
%5 88 13 -60
%5 88 66 -15
%5 89 70 -30
%5 90 15 -100
%5 90 80 -20
%5 90 70 -20
%5 90 13 -100
%5 90 66 -20
%5 91 80 -15
%5 91 70 -15
%6 34 90 -40
%6 34 88 -40
%6 34 87 -40
%6 34 86 -30
%6 34 58 -100
%6 34 56 -50
%6 34 55 -70
%6 34 54 -50
%6 34 53 -120
%6 34 50 -30
%6 34 48 -30
%6 34 40 -30
%6 34 36 -30
%6 35 15 -20
%6 35 13 -20
%6 35 54 -10
%6 36 15 -30
%6 36 13 -30
%6 37 15 -70
%6 37 13 -70
%6 37 58 -90
%6 37 56 -40
%6 37 55 -70
%6 37 34 -40
%6 39 83 -45
%6 39 15 -150
%6 39 80 -30
%6 39 70 -30
%6 39 13 -150
%6 39 66 -50
%6 39 34 -80
%6 43 86 -20
%6 43 15 -30
%6 43 13 -30
%6 43 66 -20
%6 43 34 -20
%6 44 90 -50
%6 44 86 -30
%6 44 80 -40
%6 44 70 -40
%6 44 48 -50
%6 45 90 -30
%6 45 8 -160
%6 45 119 -140
%6 45 58 -140
%6 45 56 -70
%6 45 55 -110
%6 45 53 -110
%6 48 15 -40
%6 48 13 -40
%6 48 58 -70
%6 48 57 -60
%6 48 56 -30
%6 48 55 -50
%6 48 53 -40
%6 48 34 -20
%6 49 15 -180
%6 49 80 -50
%6 49 70 -50
%6 49 13 -180
%6 49 66 -40
%6 49 34 -120
%6 50 54 -10
%6 51 58 -50
%6 51 56 -30
%6 51 55 -50
%6 51 54 -40
%6 51 53 -30
%6 51 48 -20
%6 52 15 -20
%6 52 13 -20
%6 53 90 -120
%6 53 88 -120
%6 53 86 -120
%6 53 28 -20
%6 53 83 -120
%6 53 15 -120
%6 53 80 -120
%6 53 14 -140
%6 53 70 -120
%6 53 13 -120
%6 53 27 -20
%6 53 66 -120
%6 53 48 -40
%6 53 34 -120
%6 54 15 -40
%6 54 13 -40
%6 54 34 -40
%6 55 86 -70
%6 55 28 -40
%6 55 15 -125
%6 55 80 -80
%6 55 14 -80
%6 55 70 -80
%6 55 13 -125
%6 55 27 -40
%6 55 66 -70
%6 55 48 -40
%6 55 40 -40
%6 55 34 -80
%6 56 90 -20
%6 56 86 -30
%6 56 15 -80
%6 56 80 -30
%6 56 14 -40
%6 56 70 -30
%6 56 13 -80
%6 56 66 -40
%6 56 48 -20
%6 56 34 -50
%6 58 86 -110
%6 58 28 -60
%6 58 15 -140
%6 58 80 -140
%6 58 74 -20
%6 58 14 -140
%6 58 70 -140
%6 58 13 -140
%6 58 27 -60
%6 58 66 -140
%6 58 48 -85
%6 58 34 -110
%6 66 90 -30
%6 66 88 -20
%6 66 87 -20
%6 67 90 -20
%6 67 87 -20
%6 67 86 -20
%6 67 15 -40
%6 67 77 -20
%6 67 13 -40
%6 67 67 -10
%6 68 76 -20
%6 68 13 -15
%6 27 1 -50
%6 13 8 -100
%6 13 119 -100
%6 70 90 -20
%6 70 89 -30
%6 70 88 -20
%6 70 87 -30
%6 70 15 -15
%6 70 13 -15
%6 71 8 50
%6 71 119 60
%6 71 15 -30
%6 71 80 -30
%6 71 70 -30
%6 71 145 -28
%6 71 13 -30
%6 71 66 -30
%6 72 83 -10
%6 73 90 -30
%6 76 80 -20
%6 76 70 -20
%6 78 90 -15
%6 78 86 -10
%6 79 90 -15
%6 79 87 -20
%6 79 86 -10
%6 80 90 -30
%6 80 89 -30
%6 80 88 -15
%6 80 87 -15
%6 80 15 -40
%6 80 13 -40
%6 147 91 -55
%6 147 90 -70
%6 147 89 -85
%6 147 88 -70
%6 147 87 -70
%6 147 86 -55
%6 147 85 -55
%6 147 84 -55
%6 147 83 -55
%6 147 82 -55
%6 147 15 -95
%6 147 81 -55
%6 147 80 -55
%6 147 79 -55
%6 147 78 -55
%6 147 77 -55
%6 147 76 -55
%6 147 75 -55
%6 147 74 -55
%6 147 73 -55
%6 147 72 -55
%6 147 71 -55
%6 147 70 -55
%6 147 69 -55
%6 147 13 -95
%6 147 68 -55
%6 147 67 -55
%6 147 66 -55
%6 81 90 -30
%6 81 15 -35
%6 81 13 -35
%6 15 1 -60
%6 15 8 -100
%6 15 119 -100
%6 119 1 -40
%6 65 65 -57
%6 8 1 -70
%6 8 84 -50
%6 8 83 -50
%6 8 8 -57
%6 8 69 -50
%6 83 90 30
%6 83 87 30
%6 83 86 15
%6 83 85 40
%6 83 28 30
%6 83 15 -50
%6 83 81 30
%6 83 79 25
%6 83 78 25
%6 83 77 15
%6 83 76 15
%6 83 74 15
%6 83 13 -50
%6 83 27 30
%6 83 66 -10
%6 84 88 -30
%6 84 15 -15
%6 84 13 -15
%6 28 1 -50
%6 1 65 -60
%6 1 105 -30
%6 1 58 -90
%6 1 56 -40
%6 1 55 -50
%6 1 53 -50
%6 87 15 -80
%6 87 80 -25
%6 87 70 -25
%6 87 13 -80
%6 87 66 -25
%6 88 15 -60
%6 88 80 -10
%6 88 70 -10
%6 88 13 -60
%6 88 66 -15
%6 89 70 -30
%6 90 15 -100
%6 90 80 -20
%6 90 70 -20
%6 90 13 -100
%6 90 66 -20
%6 91 80 -15
%6 91 70 -15
%7 34 90 -30
%7 34 88 -30
%7 34 87 -40
%7 34 86 -30
%7 34 58 -110
%7 34 56 -60
%7 34 55 -80
%7 34 54 -50
%7 34 53 -90
%7 34 50 -40
%7 34 48 -40
%7 34 40 -50
%7 34 36 -40
%7 35 54 -10
%7 35 34 -30
%7 37 15 -30
%7 37 13 -30
%7 37 58 -70
%7 37 56 -40
%7 37 55 -40
%7 37 34 -40
%7 39 15 -100
%7 39 13 -100
%7 39 66 -20
%7 39 34 -80
%7 43 86 -20
%7 43 15 -20
%7 43 13 -20
%7 43 34 -20
%7 44 90 -40
%7 44 86 -30
%7 44 80 -35
%7 44 70 -15
%7 44 48 -30
%7 45 90 -30
%7 45 8 -140
%7 45 119 -140
%7 45 58 -120
%7 45 56 -80
%7 45 55 -110
%7 45 53 -90
%7 48 15 -40
%7 48 13 -40
%7 48 58 -70
%7 48 57 -50
%7 48 56 -50
%7 48 55 -50
%7 48 53 -40
%7 48 34 -50
%7 49 15 -120
%7 49 80 -40
%7 49 70 -30
%7 49 13 -120
%7 49 66 -30
%7 49 34 -100
%7 50 15 20
%7 50 13 20
%7 50 54 -10
%7 51 58 -50
%7 51 56 -40
%7 51 55 -50
%7 51 54 -20
%7 51 53 -20
%7 51 48 -20
%7 53 90 -60
%7 53 88 -60
%7 53 86 -90
%7 53 28 -40
%7 53 83 -80
%7 53 15 -80
%7 53 80 -80
%7 53 14 -120
%7 53 70 -60
%7 53 13 -80
%7 53 27 -40
%7 53 66 -80
%7 53 48 -40
%7 53 34 -90
%7 54 15 -30
%7 54 13 -30
%7 54 34 -50
%7 55 86 -60
%7 55 28 -40
%7 55 15 -120
%7 55 80 -90
%7 55 14 -80
%7 55 70 -50
%7 55 13 -120
%7 55 27 -40
%7 55 66 -60
%7 55 48 -50
%7 55 40 -50
%7 55 34 -80
%7 56 90 -20
%7 56 86 -45
%7 56 28 -10
%7 56 15 -80
%7 56 80 -60
%7 56 14 -40
%7 56 70 -35
%7 56 13 -80
%7 56 27 -10
%7 56 66 -40
%7 56 48 -20
%7 56 34 -60
%7 58 86 -100
%7 58 28 -50
%7 58 15 -100
%7 58 80 -100
%7 58 70 -80
%7 58 13 -100
%7 58 27 -50
%7 58 66 -90
%7 58 48 -70
%7 58 34 -110
%7 66 90 -20
%7 66 88 -15
%7 66 87 -15
%7 66 72 -10
%7 67 90 -20
%7 67 87 -20
%7 67 86 -20
%7 67 77 -10
%7 68 90 -10
%7 68 77 -20
%7 68 76 -20
%7 68 73 -10
%7 27 1 -40
%7 13 1 -40
%7 13 8 -120
%7 13 119 -120
%7 69 90 -15
%7 69 88 -15
%7 69 87 -15
%7 69 69 -10
%7 70 90 -15
%7 70 89 -15
%7 70 88 -15
%7 70 87 -15
%7 70 15 20
%7 70 13 10
%7 71 8 30
%7 71 119 30
%7 71 15 -10
%7 71 80 -20
%7 71 70 -10
%7 71 13 -10
%7 72 72 -10
%7 72 70 10
%7 73 90 -20
%7 76 80 -15
%7 77 90 -15
%7 77 88 -15
%7 78 90 -30
%7 78 86 -20
%7 79 90 -20
%7 79 87 -40
%7 79 86 -10
%7 80 90 -20
%7 80 89 -30
%7 80 88 -15
%7 80 87 -20
%7 81 90 -15
%7 15 1 -40
%7 15 8 -120
%7 15 119 -120
%7 119 1 -80
%7 65 65 -46
%7 8 87 -20
%7 8 1 -80
%7 8 84 -60
%7 8 83 -40
%7 8 8 -46
%7 8 77 -20
%7 8 69 -80
%7 83 90 10
%7 83 87 10
%7 83 85 20
%7 83 84 -15
%7 83 82 -20
%7 83 15 -60
%7 83 80 -20
%7 83 14 -20
%7 83 72 -15
%7 83 69 -20
%7 83 13 -60
%7 83 68 -20
%7 84 88 -15
%7 28 1 -40
%7 1 65 -60
%7 1 105 -80
%7 1 58 -120
%7 1 56 -80
%7 1 55 -80
%7 1 53 -100
%7 87 15 -80
%7 87 80 -30
%7 87 13 -80
%7 87 66 -20
%7 88 15 -40
%7 88 80 -20
%7 88 13 -40
%7 89 70 -10
%7 90 15 -80
%7 90 80 -25
%7 90 70 -10
%7 90 13 -80
%7 90 66 -30
%7 91 70 10
%8 34 90 -30
%8 34 88 -30
%8 34 87 -40
%8 34 86 -30
%8 34 58 -110
%8 34 56 -60
%8 34 55 -80
%8 34 54 -50
%8 34 53 -90
%8 34 50 -40
%8 34 48 -40
%8 34 40 -50
%8 34 36 -40
%8 35 54 -10
%8 35 34 -30
%8 37 15 -30
%8 37 13 -30
%8 37 58 -70
%8 37 56 -40
%8 37 55 -40
%8 37 34 -40
%8 39 15 -100
%8 39 13 -100
%8 39 66 -20
%8 39 34 -80
%8 43 86 -20
%8 43 15 -20
%8 43 13 -20
%8 43 34 -20
%8 44 90 -40
%8 44 86 -30
%8 44 80 -35
%8 44 70 -15
%8 44 48 -30
%8 45 90 -30
%8 45 8 -140
%8 45 119 -140
%8 45 58 -120
%8 45 56 -80
%8 45 55 -110
%8 45 53 -90
%8 48 15 -40
%8 48 13 -40
%8 48 58 -70
%8 48 57 -50
%8 48 56 -50
%8 48 55 -50
%8 48 53 -40
%8 48 34 -50
%8 49 15 -120
%8 49 80 -40
%8 49 70 -30
%8 49 13 -120
%8 49 66 -30
%8 49 34 -100
%8 50 15 20
%8 50 13 20
%8 50 54 -10
%8 51 58 -50
%8 51 56 -40
%8 51 55 -50
%8 51 54 -20
%8 51 53 -20
%8 51 48 -20
%8 53 90 -60
%8 53 88 -60
%8 53 86 -90
%8 53 28 -40
%8 53 83 -80
%8 53 15 -80
%8 53 80 -80
%8 53 14 -120
%8 53 70 -60
%8 53 13 -80
%8 53 27 -40
%8 53 66 -80
%8 53 48 -40
%8 53 34 -90
%8 54 15 -30
%8 54 13 -30
%8 54 34 -50
%8 55 86 -60
%8 55 28 -40
%8 55 15 -120
%8 55 80 -90
%8 55 14 -80
%8 55 70 -50
%8 55 13 -120
%8 55 27 -40
%8 55 66 -60
%8 55 48 -50
%8 55 40 -50
%8 55 34 -80
%8 56 90 -20
%8 56 86 -45
%8 56 28 -10
%8 56 15 -80
%8 56 80 -60
%8 56 14 -40
%8 56 70 -35
%8 56 13 -80
%8 56 27 -10
%8 56 66 -40
%8 56 48 -20
%8 56 34 -60
%8 58 86 -100
%8 58 28 -50
%8 58 15 -100
%8 58 80 -100
%8 58 70 -80
%8 58 13 -100
%8 58 27 -50
%8 58 66 -90
%8 58 48 -70
%8 58 34 -110
%8 66 90 -20
%8 66 88 -15
%8 66 87 -15
%8 66 72 -10
%8 67 90 -20
%8 67 87 -20
%8 67 86 -20
%8 67 77 -10
%8 68 90 -10
%8 68 77 -20
%8 68 76 -20
%8 68 73 -10
%8 27 1 -40
%8 13 1 -40
%8 13 8 -120
%8 13 119 -120
%8 69 90 -15
%8 69 88 -15
%8 69 87 -15
%8 69 69 -10
%8 70 90 -15
%8 70 89 -15
%8 70 88 -15
%8 70 87 -15
%8 70 15 20
%8 70 13 10
%8 71 8 30
%8 71 119 30
%8 71 15 -10
%8 71 80 -20
%8 71 70 -10
%8 71 13 -10
%8 72 72 -10
%8 72 70 10
%8 73 90 -20
%8 76 80 -15
%8 77 90 -15
%8 77 88 -15
%8 78 90 -30
%8 78 86 -20
%8 79 90 -20
%8 79 87 -40
%8 79 86 -10
%8 80 90 -20
%8 80 89 -30
%8 80 88 -15
%8 80 87 -20
%8 81 90 -15
%8 15 1 -40
%8 15 8 -120
%8 15 119 -120
%8 119 1 -80
%8 65 65 -46
%8 8 87 -20
%8 8 1 -80
%8 8 84 -60
%8 8 83 -40
%8 8 8 -46
%8 8 77 -20
%8 8 69 -80
%8 83 90 10
%8 83 87 10
%8 83 85 20
%8 83 84 -15
%8 83 82 -20
%8 83 15 -60
%8 83 80 -20
%8 83 14 -20
%8 83 72 -15
%8 83 69 -20
%8 83 13 -60
%8 83 68 -20
%8 84 88 -15
%8 28 1 -40
%8 1 65 -60
%8 1 105 -80
%8 1 58 -120
%8 1 56 -80
%8 1 55 -80
%8 1 53 -100
%8 87 15 -80
%8 87 80 -30
%8 87 13 -80
%8 87 66 -20
%8 88 15 -40
%8 88 80 -20
%8 88 13 -40
%8 89 70 -10
%8 90 15 -80
%8 90 80 -25
%8 90 70 -10
%8 90 13 -80
%8 90 66 -30
%8 91 70 10
%9 34 90 -74
%9 34 88 -74
%9 34 87 -92
%9 34 1 -55
%9 34 8 -74
%9 34 58 -111
%9 34 56 -74
%9 34 55 -111
%9 34 53 -74
%9 39 15 -92
%9 39 13 -92
%9 39 34 -74
%9 45 90 -55
%9 45 1 -37
%9 45 8 -74
%9 45 58 -92
%9 45 56 -74
%9 45 55 -92
%9 45 53 -74
%9 49 1 -18
%9 49 15 -129
%9 49 13 -129
%9 49 34 -92
%9 51 90 -37
%9 51 58 -37
%9 51 56 -37
%9 51 55 -55
%9 51 53 -37
%9 53 90 -90
%9 53 88 -90
%9 53 86 -90
%9 53 28 -55
%9 53 84 -90
%9 53 83 -90
%9 53 15 -74
%9 53 80 -92
%9 53 74 -55
%9 53 14 -55
%9 53 70 -92
%9 53 13 -74
%9 53 27 -55
%9 53 68 -111
%9 53 66 -92
%9 53 48 -18
%9 53 34 -74
%9 55 90 -92
%9 55 86 -92
%9 55 28 -55
%9 55 83 -92
%9 55 15 -129
%9 55 80 -111
%9 55 74 -55
%9 55 14 -74
%9 55 70 -111
%9 55 13 -129
%9 55 27 -55
%9 55 66 -92
%9 55 34 -111
%9 56 90 -50
%9 56 86 -50
%9 56 28 -18
%9 56 83 -74
%9 56 15 -92
%9 56 80 -92
%9 56 74 -55
%9 56 14 -55
%9 56 70 -92
%9 56 13 -92
%9 56 27 -18
%9 56 66 -92
%9 56 34 -92
%9 58 87 -90
%9 58 86 -90
%9 58 1 -18
%9 58 28 -74
%9 58 82 -90
%9 58 15 -111
%9 58 81 -111
%9 58 80 -92
%9 58 74 -55
%9 58 14 -92
%9 58 70 -92
%9 58 13 -111
%9 58 27 -74
%9 58 66 -92
%9 58 34 -92
%9 71 8 55
%9 71 71 -18
%9 18 18 -55
%9 65 65 -37
%9 8 8 -37
%9 83 86 -8
%9 83 8 74
%9 83 82 -18
%9 83 15 -74
%9 83 80 -18
%9 83 14 -18
%9 83 73 -18
%9 83 72 -18
%9 83 70 -18
%9 83 69 -18
%9 83 13 -74
%9 83 68 -18
%9 1 58 -18
%9 1 34 -37
%9 87 15 -111
%9 87 13 -111
%9 88 15 -92
%9 88 13 -92
%9 90 15 -111
%9 90 13 -111
%10 34 90 -55
%10 34 88 -37
%10 34 87 -37
%10 34 1 -37
%10 34 8 -55
%10 34 58 -55
%10 34 56 -55
%10 34 55 -74
%10 34 53 -55
%10 39 15 -111
%10 39 13 -111
%10 39 34 -111
%10 45 90 -37
%10 45 1 -18
%10 45 8 -37
%10 45 58 -74
%10 45 56 -74
%10 45 55 -74
%10 45 53 -74
%10 49 15 -129
%10 49 13 -129
%10 49 34 -129
%10 51 90 -37
%10 51 58 -55
%10 51 56 -55
%10 51 55 -74
%10 51 53 -55
%10 53 90 -92
%10 53 88 -92
%10 53 86 -111
%10 53 28 -74
%10 53 84 -111
%10 53 83 -111
%10 53 15 -74
%10 53 80 -111
%10 53 74 -55
%10 53 14 -55
%10 53 70 -111
%10 53 13 -74
%10 53 27 -74
%10 53 68 -111
%10 53 66 -111
%10 53 48 -18
%10 53 34 -92
%10 55 90 -74
%10 55 86 -74
%10 55 28 -37
%10 55 83 -92
%10 55 15 -129
%10 55 80 -74
%10 55 74 -74
%10 55 14 -55
%10 55 70 -92
%10 55 13 -129
%10 55 27 -37
%10 55 66 -74
%10 55 34 -210
%10 56 90 -20
%10 56 86 -20
%10 56 28 -18
%10 56 83 -20
%10 56 15 -55
%10 56 80 -20
%10 56 74 -20
%10 56 14 -18
%10 56 70 -20
%10 56 13 -55
%10 56 27 -18
%10 56 66 -20
%10 56 34 -92
%10 58 87 -74
%10 58 86 -92
%10 58 28 -74
%10 58 82 -92
%10 58 15 -92
%10 58 81 -74
%10 58 80 -111
%10 58 74 -55
%10 58 14 -74
%10 58 70 -111
%10 58 13 -92
%10 58 27 -74
%10 58 66 -92
%10 58 34 -92
%10 71 8 55
%10 18 18 -55
%10 65 65 -74
%10 8 85 -37
%10 8 1 -55
%10 8 84 -55
%10 8 8 -74
%10 83 8 37
%10 83 82 -18
%10 83 15 -74
%10 83 80 -18
%10 83 73 -18
%10 83 72 -18
%10 83 70 -18
%10 83 13 -74
%10 83 68 -18
%10 87 15 -55
%10 87 13 -55
%10 88 15 -55
%10 88 13 -55
%10 90 15 -37
%10 90 13 -37
%11 34 90 -70
%11 34 88 -70
%11 34 87 -70
%11 34 1 -18
%11 34 8 -92
%11 34 58 -111
%11 34 56 -90
%11 34 55 -129
%11 34 53 -92
%11 39 15 -111
%11 39 13 -111
%11 39 34 -55
%11 45 90 -74
%11 45 1 -18
%11 45 8 -74
%11 45 58 -92
%11 45 56 -92
%11 45 55 -92
%11 45 53 -74
%11 49 15 -129
%11 49 13 -129
%11 49 34 -74
%11 51 90 -30
%11 51 58 -55
%11 51 56 -37
%11 51 55 -74
%11 51 53 -55
%11 53 90 -90
%11 53 88 -90
%11 53 86 -129
%11 53 28 -74
%11 53 84 -111
%11 53 83 -111
%11 53 15 -92
%11 53 80 -111
%11 53 74 -55
%11 53 14 -92
%11 53 70 -111
%11 53 13 -92
%11 53 27 -74
%11 53 68 -129
%11 53 66 -111
%11 53 34 -92
%11 55 90 -90
%11 55 86 -92
%11 55 28 -74
%11 55 83 -111
%11 55 15 -129
%11 55 80 -111
%11 55 74 -55
%11 55 14 -92
%11 55 70 -111
%11 55 13 -129
%11 55 27 -74
%11 55 66 -111
%11 55 34 -129
%11 56 90 -74
%11 56 86 -74
%11 56 28 -37
%11 56 83 -74
%11 56 15 -37
%11 56 80 -74
%11 56 74 -37
%11 56 14 -37
%11 56 70 -74
%11 56 13 -92
%11 56 27 -37
%11 56 66 -74
%11 56 34 -90
%11 58 87 -74
%11 58 86 -74
%11 58 28 -55
%11 58 82 -92
%11 58 15 -74
%11 58 81 -74
%11 58 80 -74
%11 58 74 -55
%11 58 14 -74
%11 58 70 -74
%11 58 13 -74
%11 58 27 -55
%11 58 66 -74
%11 58 34 -55
%11 71 8 37
%11 71 71 -18
%11 18 18 -37
%11 65 65 -55
%11 8 85 -18
%11 8 1 -55
%11 8 84 -55
%11 8 8 -55
%11 83 8 55
%11 83 15 -55
%11 83 14 -18
%11 83 13 -55
%11 87 15 -111
%11 87 13 -111
%11 88 15 -92
%11 88 13 -92
%11 90 15 -92
%11 90 13 -92
%12 34 90 -55
%12 34 88 -37
%12 34 87 -55
%12 34 1 -55
%12 34 8 -55
%12 34 58 -74
%12 34 56 -74
%12 34 55 -74
%12 34 53 -55
%12 39 1 -18
%12 39 15 -111
%12 39 13 -111
%12 39 34 -74
%12 45 90 -37
%12 45 1 -18
%12 45 8 -55
%12 45 58 -74
%12 45 56 -74
%12 45 55 -74
%12 45 53 -74
%12 49 1 -55
%12 49 15 -129
%12 49 13 -129
%12 49 34 -92
%12 51 90 -20
%12 51 58 -37
%12 51 56 -55
%12 51 55 -55
%12 51 53 -37
%12 53 90 -80
%12 53 88 -50
%12 53 86 -92
%12 53 28 -55
%12 53 84 -92
%12 53 83 -92
%12 53 15 -55
%12 53 80 -111
%12 53 74 -74
%12 53 14 -92
%12 53 70 -111
%12 53 13 -55
%12 53 27 -55
%12 53 68 -92
%12 53 66 -111
%12 53 48 -18
%12 53 34 -55
%12 55 90 -50
%12 55 86 -50
%12 55 28 -37
%12 55 83 -74
%12 55 15 -111
%12 55 80 -74
%12 55 74 -50
%12 55 14 -37
%12 55 70 -74
%12 55 13 -111
%12 55 27 -37
%12 55 66 -92
%12 55 34 -74
%12 56 90 -30
%12 56 86 -30
%12 56 28 -18
%12 56 83 -30
%12 56 15 -55
%12 56 80 -55
%12 56 74 -30
%12 56 70 -55
%12 56 13 -55
%12 56 27 -28
%12 56 66 -74
%12 56 34 -74
%12 58 87 -30
%12 58 86 -50
%12 58 28 -55
%12 58 82 -92
%12 58 15 -55
%12 58 81 -74
%12 58 80 -111
%12 58 74 -54
%12 58 14 -55
%12 58 70 -92
%12 58 13 -55
%12 58 27 -55
%12 58 66 -111
%12 58 34 -55
%12 71 8 37
%12 71 71 -37
%12 18 18 -55
%12 65 65 -55
%12 8 85 -18
%12 8 1 -37
%12 8 84 -37
%12 8 8 -55
%12 83 8 55
%12 83 82 -18
%12 83 15 -55
%12 83 80 -18
%12 83 73 -18
%12 83 72 -18
%12 83 70 -18
%12 83 13 -55
%12 83 68 -18
%12 87 15 -55
%12 87 13 -55
%12 88 15 -55
%12 88 13 -55
%12 90 15 -37
%12 90 13 -37
%17 34 90 -62
%17 34 88 -65
%17 34 87 -70
%17 34 86 -20
%17 34 8 -100
%17 34 119 -100
%17 34 58 -92
%17 34 56 -60
%17 34 55 -102
%17 34 54 -40
%17 34 53 -45
%17 34 50 -40
%17 34 48 -50
%17 34 40 -40
%17 34 36 -40
%17 35 34 -10
%17 36 34 -40
%17 37 15 -20
%17 37 13 -20
%17 37 58 -30
%17 37 56 -10
%17 37 55 -50
%17 37 34 -50
%17 39 15 -160
%17 39 70 -20
%17 39 13 -180
%17 39 66 -20
%17 39 34 -75
%17 40 15 -20
%17 40 13 -20
%17 40 58 -20
%17 43 15 -15
%17 43 66 -20
%17 43 34 -30
%17 44 80 -15
%17 44 70 -20
%17 44 48 -20
%17 45 90 -23
%17 45 8 -130
%17 45 119 -130
%17 45 58 -91
%17 45 56 -67
%17 45 55 -113
%17 45 53 -46
%17 48 15 -30
%17 48 13 -30
%17 48 58 -30
%17 48 57 -30
%17 48 56 -20
%17 48 55 -60
%17 48 53 -30
%17 48 34 -60
%17 49 15 -300
%17 49 80 -60
%17 49 70 -20
%17 49 13 -280
%17 49 66 -20
%17 49 34 -114
%17 50 13 20
%17 51 58 -10
%17 51 56 10
%17 51 55 -10
%17 51 53 6
%17 52 13 20
%17 53 90 -50
%17 53 88 -55
%17 53 86 -46
%17 53 28 -29
%17 53 83 -30
%17 53 15 -91
%17 53 80 -70
%17 53 74 10
%17 53 14 -75
%17 53 70 -49
%17 53 13 -82
%17 53 27 -15
%17 53 66 -90
%17 53 48 -30
%17 53 34 -45
%17 54 15 -20
%17 54 13 -20
%17 54 34 -40
%17 55 86 -40
%17 55 28 -33
%17 55 15 -165
%17 55 80 -101
%17 55 74 -5
%17 55 14 -75
%17 55 70 -101
%17 55 13 -145
%17 55 27 -18
%17 55 66 -104
%17 55 48 -60
%17 55 40 -20
%17 55 34 -102
%17 56 90 -2
%17 56 86 -30
%17 56 28 -33
%17 56 15 -106
%17 56 80 -46
%17 56 74 6
%17 56 14 -35
%17 56 70 -47
%17 56 13 -106
%17 56 27 -15
%17 56 66 -50
%17 56 48 -20
%17 56 34 -58
%17 58 86 -52
%17 58 28 -23
%17 58 15 -175
%17 58 80 -89
%17 58 14 -85
%17 58 70 -89
%17 58 13 -145
%17 58 27 -10
%17 58 66 -93
%17 58 48 -30
%17 58 34 -92
%17 66 81 20
%17 66 67 20
%17 67 90 -20
%17 67 87 -20
%17 68 90 -20
%17 68 76 -15
%17 13 1 -110
%17 13 8 -120
%17 13 119 -120
%17 70 90 -20
%17 70 88 -20
%17 70 87 -20
%17 71 15 -50
%17 71 80 -40
%17 71 77 -30
%17 71 74 -34
%17 71 71 -60
%17 71 70 -20
%17 71 145 -34
%17 71 13 -50
%17 71 66 -40
%17 72 66 -15
%17 73 90 -30
%17 76 90 -5
%17 76 70 -15
%17 78 90 -20
%17 78 86 -20
%17 78 66 -20
%17 79 90 -15
%17 79 87 -20
%17 80 90 -20
%17 80 89 -15
%17 80 88 -20
%17 80 87 -30
%17 81 90 -20
%17 15 1 -110
%17 15 8 -120
%17 15 119 -120
%17 105 65 -35
%17 105 34 -100
%17 119 1 -110
%17 65 65 -203
%17 65 34 -100
%17 8 87 -30
%17 8 85 10
%17 8 1 -110
%17 8 84 -15
%17 8 83 -20
%17 8 8 -203
%17 8 119 -35
%17 8 69 -110
%17 83 90 40
%17 83 87 40
%17 83 86 20
%17 83 85 20
%17 83 84 20
%17 83 82 -8
%17 83 15 -73
%17 83 81 20
%17 83 80 -20
%17 83 79 21
%17 83 78 28
%17 83 77 20
%17 83 76 20
%17 83 74 20
%17 83 14 -60
%17 83 72 -15
%17 83 70 -4
%17 83 69 -6
%17 83 13 -75
%17 83 68 -20
%17 83 66 -20
%17 84 15 20
%17 84 13 20
%17 1 65 -110
%17 1 105 -110
%17 1 58 -60
%17 1 56 -25
%17 1 55 -50
%17 1 53 -25
%17 1 34 -20
%17 87 15 -130
%17 87 80 -30
%17 87 70 -20
%17 87 13 -100
%17 87 66 -30
%17 88 15 -100
%17 88 80 -30
%17 88 73 15
%17 88 70 -20
%17 88 13 -90
%17 88 66 -30
%17 90 15 -125
%17 90 80 -30
%17 90 70 -20
%17 90 13 -110
%17 90 66 -30
%18 34 90 -62
%18 34 88 -65
%18 34 87 -70
%18 34 86 -20
%18 34 8 -100
%18 34 119 -100
%18 34 58 -92
%18 34 56 -60
%18 34 55 -102
%18 34 54 -40
%18 34 53 -45
%18 34 50 -40
%18 34 48 -50
%18 34 40 -40
%18 34 36 -40
%18 35 34 -10
%18 36 34 -40
%18 37 15 -20
%18 37 13 -20
%18 37 58 -30
%18 37 56 -10
%18 37 55 -50
%18 37 34 -50
%18 39 15 -160
%18 39 70 -20
%18 39 13 -180
%18 39 66 -20
%18 39 34 -75
%18 40 15 -20
%18 40 13 -20
%18 40 58 -20
%18 43 15 -15
%18 43 66 -20
%18 43 34 -30
%18 44 80 -15
%18 44 70 -20
%18 44 48 -20
%18 45 90 -23
%18 45 8 -130
%18 45 119 -130
%18 45 58 -91
%18 45 56 -67
%18 45 55 -113
%18 45 53 -46
%18 48 15 -30
%18 48 13 -30
%18 48 58 -30
%18 48 57 -30
%18 48 56 -20
%18 48 55 -60
%18 48 53 -30
%18 48 34 -60
%18 49 15 -300
%18 49 80 -60
%18 49 70 -20
%18 49 13 -280
%18 49 66 -20
%18 49 34 -114
%18 50 13 20
%18 51 58 -10
%18 51 56 10
%18 51 55 -10
%18 51 53 6
%18 52 13 20
%18 53 90 -50
%18 53 88 -55
%18 53 86 -46
%18 53 28 -29
%18 53 83 -30
%18 53 15 -91
%18 53 80 -70
%18 53 74 10
%18 53 14 -75
%18 53 70 -49
%18 53 13 -82
%18 53 27 -15
%18 53 66 -90
%18 53 48 -30
%18 53 34 -45
%18 54 15 -20
%18 54 13 -20
%18 54 34 -40
%18 55 86 -40
%18 55 28 -33
%18 55 15 -165
%18 55 80 -101
%18 55 74 -5
%18 55 14 -75
%18 55 70 -101
%18 55 13 -145
%18 55 27 -18
%18 55 66 -104
%18 55 48 -60
%18 55 40 -20
%18 55 34 -102
%18 56 90 -2
%18 56 86 -30
%18 56 28 -33
%18 56 15 -106
%18 56 80 -46
%18 56 74 6
%18 56 14 -35
%18 56 70 -47
%18 56 13 -106
%18 56 27 -15
%18 56 66 -50
%18 56 48 -20
%18 56 34 -58
%18 58 86 -52
%18 58 28 -23
%18 58 15 -175
%18 58 80 -89
%18 58 14 -85
%18 58 70 -89
%18 58 13 -145
%18 58 27 -10
%18 58 66 -93
%18 58 48 -30
%18 58 34 -92
%18 66 81 20
%18 66 67 20
%18 67 90 -20
%18 67 87 -20
%18 68 90 -20
%18 68 76 -15
%18 13 1 -110
%18 13 8 -120
%18 13 119 -120
%18 70 90 -20
%18 70 88 -20
%18 70 87 -20
%18 71 15 -50
%18 71 80 -40
%18 71 77 -30
%18 71 74 -34
%18 71 71 -60
%18 71 70 -20
%18 71 145 -34
%18 71 13 -50
%18 71 66 -40
%18 72 66 -15
%18 73 90 -30
%18 76 90 -5
%18 76 70 -15
%18 78 90 -20
%18 78 86 -20
%18 78 66 -20
%18 79 90 -15
%18 79 87 -20
%18 80 90 -20
%18 80 89 -15
%18 80 88 -20
%18 80 87 -30
%18 81 90 -20
%18 15 1 -110
%18 15 8 -120
%18 15 119 -120
%18 105 65 -35
%18 105 34 -100
%18 119 1 -110
%18 65 65 -203
%18 65 34 -100
%18 8 87 -30
%18 8 85 10
%18 8 1 -110
%18 8 84 -15
%18 8 83 -20
%18 8 8 -203
%18 8 119 -35
%18 8 69 -110
%18 83 90 40
%18 83 87 40
%18 83 86 20
%18 83 85 20
%18 83 84 20
%18 83 82 -8
%18 83 15 -73
%18 83 81 20
%18 83 80 -20
%18 83 79 21
%18 83 78 28
%18 83 77 20
%18 83 76 20
%18 83 74 20
%18 83 14 -60
%18 83 72 -15
%18 83 70 -4
%18 83 69 -6
%18 83 13 -75
%18 83 68 -20
%18 83 66 -20
%18 84 15 20
%18 84 13 20
%18 1 65 -110
%18 1 105 -110
%18 1 58 -60
%18 1 56 -25
%18 1 55 -50
%18 1 53 -25
%18 1 34 -20
%18 87 15 -130
%18 87 80 -30
%18 87 70 -20
%18 87 13 -100
%18 87 66 -30
%18 88 15 -100
%18 88 80 -30
%18 88 73 15
%18 88 70 -20
%18 88 13 -90
%18 88 66 -30
%18 90 15 -125
%18 90 80 -30
%18 90 70 -20
%18 90 13 -110
%18 90 66 -30
%19 34 90 -50
%19 34 88 -65
%19 34 87 -70
%19 34 86 -20
%19 34 8 -90
%19 34 58 -80
%19 34 56 -60
%19 34 55 -102
%19 34 54 -40
%19 34 53 -25
%19 34 50 -50
%19 34 48 -50
%19 34 40 -40
%19 34 36 -40
%19 35 34 -10
%19 36 34 -40
%19 37 15 -20
%19 37 13 -20
%19 37 58 -45
%19 37 56 -25
%19 37 55 -50
%19 37 34 -50
%19 39 15 -129
%19 39 70 -20
%19 39 13 -162
%19 39 66 -20
%19 39 34 -75
%19 40 15 -20
%19 40 13 -20
%19 40 58 -15
%19 43 15 -15
%19 43 66 -20
%19 43 34 -30
%19 44 90 -20
%19 44 86 -15
%19 44 80 -45
%19 44 70 -40
%19 44 48 -30
%19 45 90 -23
%19 45 8 -30
%19 45 119 -30
%19 45 58 -80
%19 45 56 -55
%19 45 55 -85
%19 45 53 -46
%19 48 15 -30
%19 48 13 -30
%19 48 58 -30
%19 48 57 -30
%19 48 56 -20
%19 48 55 -45
%19 48 53 -15
%19 48 34 -60
%19 49 15 -200
%19 49 80 -20
%19 49 70 -20
%19 49 13 -220
%19 49 66 -20
%19 49 34 -100
%19 50 13 20
%19 51 56 25
%19 51 55 -10
%19 51 54 25
%19 51 53 40
%19 51 48 25
%19 52 13 20
%19 53 90 -10
%19 53 88 -55
%19 53 86 -46
%19 53 28 -29
%19 53 83 -30
%19 53 15 -91
%19 53 80 -49
%19 53 14 -75
%19 53 70 -49
%19 53 13 -82
%19 53 27 -15
%19 53 66 -70
%19 53 48 -15
%19 53 34 -25
%19 54 15 -20
%19 54 13 -20
%19 54 34 -40
%19 55 86 -55
%19 55 28 -33
%19 55 15 -145
%19 55 80 -101
%19 55 74 -15
%19 55 14 -75
%19 55 70 -101
%19 55 13 -145
%19 55 27 -18
%19 55 66 -95
%19 55 48 -45
%19 55 40 -20
%19 55 34 -102
%19 56 90 -15
%19 56 86 -30
%19 56 28 -33
%19 56 15 -106
%19 56 80 -46
%19 56 74 -10
%19 56 14 -35
%19 56 70 -47
%19 56 13 -106
%19 56 27 -15
%19 56 66 -50
%19 56 48 -20
%19 56 34 -58
%19 58 86 -52
%19 58 28 -23
%19 58 15 -145
%19 58 80 -89
%19 58 14 -100
%19 58 70 -89
%19 58 13 -145
%19 58 27 -10
%19 58 66 -93
%19 58 48 -30
%19 58 34 -80
%19 66 85 5
%19 66 81 20
%19 66 67 5
%19 67 90 -20
%19 67 87 -20
%19 68 90 -20
%19 68 77 -15
%19 68 76 -15
%19 13 1 -50
%19 13 8 -70
%19 13 119 -70
%19 70 90 -20
%19 70 89 -20
%19 70 88 -20
%19 70 87 -20
%19 71 15 -40
%19 71 80 -20
%19 71 77 -15
%19 71 74 -15
%19 71 71 -20
%19 71 145 -15
%19 71 13 -40
%19 71 66 -15
%19 72 74 25
%19 72 66 15
%19 73 90 -30
%19 76 90 -5
%19 76 80 -30
%19 76 70 -40
%19 78 90 -20
%19 78 86 -20
%19 79 90 -15
%19 79 87 -30
%19 80 90 -20
%19 80 89 -30
%19 80 88 -20
%19 80 87 -30
%19 81 90 -20
%19 15 1 -50
%19 15 8 -70
%19 15 119 -70
%19 105 34 -50
%19 119 1 -50
%19 65 65 -80
%19 65 34 -50
%19 8 87 -10
%19 8 85 10
%19 8 1 -50
%19 8 84 -15
%19 8 83 -20
%19 8 8 -80
%19 8 69 -50
%19 83 90 40
%19 83 87 40
%19 83 86 20
%19 83 85 20
%19 83 84 20
%19 83 82 -8
%19 83 15 -73
%19 83 81 20
%19 83 80 -15
%19 83 79 21
%19 83 78 15
%19 83 77 20
%19 83 76 5
%19 83 74 20
%19 83 14 -60
%19 83 72 1
%19 83 70 -4
%19 83 69 -6
%19 83 13 -75
%19 83 68 -7
%19 84 15 20
%19 84 13 20
%19 1 65 -50
%19 1 105 -50
%19 1 58 -60
%19 1 56 -25
%19 1 55 -80
%19 1 53 -25
%19 1 34 -20
%19 87 15 -90
%19 87 80 -20
%19 87 70 -20
%19 87 13 -90
%19 87 66 -30
%19 88 15 -90
%19 88 80 -30
%19 88 70 -20
%19 88 13 -90
%19 88 66 -30
%19 89 70 -20
%19 90 15 -100
%19 90 80 -30
%19 90 70 -20
%19 90 13 -100
%19 90 68 -35
%19 90 66 -30
%20 34 90 -50
%20 34 88 -65
%20 34 87 -70
%20 34 86 -20
%20 34 8 -90
%20 34 58 -80
%20 34 56 -60
%20 34 55 -102
%20 34 54 -40
%20 34 53 -25
%20 34 50 -50
%20 34 48 -50
%20 34 40 -40
%20 34 36 -40
%20 35 34 -10
%20 36 34 -40
%20 37 15 -20
%20 37 13 -20
%20 37 58 -45
%20 37 56 -25
%20 37 55 -50
%20 37 34 -50
%20 39 15 -129
%20 39 70 -20
%20 39 13 -162
%20 39 66 -20
%20 39 34 -75
%20 40 15 -20
%20 40 13 -20
%20 40 58 -15
%20 43 15 -15
%20 43 66 -20
%20 43 34 -30
%20 44 90 -20
%20 44 86 -15
%20 44 80 -45
%20 44 70 -40
%20 44 48 -30
%20 45 90 -23
%20 45 8 -30
%20 45 119 -30
%20 45 58 -80
%20 45 56 -55
%20 45 55 -85
%20 45 53 -46
%20 48 15 -30
%20 48 13 -30
%20 48 58 -30
%20 48 57 -30
%20 48 56 -20
%20 48 55 -45
%20 48 53 -15
%20 48 34 -60
%20 49 15 -200
%20 49 80 -20
%20 49 70 -20
%20 49 13 -220
%20 49 66 -20
%20 49 34 -100
%20 50 13 20
%20 51 56 25
%20 51 55 -10
%20 51 54 25
%20 51 53 40
%20 51 48 25
%20 52 13 20
%20 53 90 -10
%20 53 88 -55
%20 53 86 -46
%20 53 28 -29
%20 53 83 -30
%20 53 15 -91
%20 53 80 -49
%20 53 14 -75
%20 53 70 -49
%20 53 13 -82
%20 53 27 -15
%20 53 66 -70
%20 53 48 -15
%20 53 34 -25
%20 54 15 -20
%20 54 13 -20
%20 54 34 -40
%20 55 86 -55
%20 55 28 -33
%20 55 15 -145
%20 55 80 -101
%20 55 74 -15
%20 55 14 -75
%20 55 70 -101
%20 55 13 -145
%20 55 27 -18
%20 55 66 -95
%20 55 48 -45
%20 55 40 -20
%20 55 34 -102
%20 56 90 -15
%20 56 86 -30
%20 56 28 -33
%20 56 15 -106
%20 56 80 -46
%20 56 74 -10
%20 56 14 -35
%20 56 70 -47
%20 56 13 -106
%20 56 27 -15
%20 56 66 -50
%20 56 48 -20
%20 56 34 -58
%20 58 86 -52
%20 58 28 -23
%20 58 15 -145
%20 58 80 -89
%20 58 14 -100
%20 58 70 -89
%20 58 13 -145
%20 58 27 -10
%20 58 66 -93
%20 58 48 -30
%20 58 34 -80
%20 66 85 5
%20 66 81 20
%20 66 67 5
%20 67 90 -20
%20 67 87 -20
%20 68 90 -20
%20 68 77 -15
%20 68 76 -15
%20 13 1 -50
%20 13 8 -70
%20 13 119 -70
%20 70 90 -20
%20 70 89 -20
%20 70 88 -20
%20 70 87 -20
%20 71 15 -40
%20 71 80 -20
%20 71 77 -15
%20 71 74 -15
%20 71 71 -20
%20 71 145 -15
%20 71 13 -40
%20 71 66 -15
%20 72 74 25
%20 72 66 15
%20 73 90 -30
%20 76 90 -5
%20 76 80 -30
%20 76 70 -40
%20 78 90 -20
%20 78 86 -20
%20 79 90 -15
%20 79 87 -30
%20 80 90 -20
%20 80 89 -30
%20 80 88 -20
%20 80 87 -30
%20 81 90 -20
%20 15 1 -50
%20 15 8 -70
%20 15 119 -70
%20 105 34 -50
%20 119 1 -50
%20 65 65 -80
%20 65 34 -50
%20 8 87 -10
%20 8 85 10
%20 8 1 -50
%20 8 84 -15
%20 8 83 -20
%20 8 8 -80
%20 8 69 -50
%20 83 90 40
%20 83 87 40
%20 83 86 20
%20 83 85 20
%20 83 84 20
%20 83 82 -8
%20 83 15 -73
%20 83 81 20
%20 83 80 -15
%20 83 79 21
%20 83 78 15
%20 83 77 20
%20 83 76 5
%20 83 74 20
%20 83 14 -60
%20 83 72 1
%20 83 70 -4
%20 83 69 -6
%20 83 13 -75
%20 83 68 -7
%20 84 15 20
%20 84 13 20
%20 1 65 -50
%20 1 105 -50
%20 1 58 -60
%20 1 56 -25
%20 1 55 -80
%20 1 53 -25
%20 1 34 -20
%20 87 15 -90
%20 87 80 -20
%20 87 70 -20
%20 87 13 -90
%20 87 66 -30
%20 88 15 -90
%20 88 80 -30
%20 88 70 -20
%20 88 13 -90
%20 88 66 -30
%20 89 70 -20
%20 90 15 -100
%20 90 80 -30
%20 90 70 -20
%20 90 13 -100
%20 90 68 -35
%20 90 66 -30
%21 34 90 32
%21 34 88 4
%21 34 87 7
%21 34 58 -35
%21 34 56 -40
%21 34 55 -56
%21 34 53 1
%21 39 15 -46
%21 39 13 -41
%21 39 34 -21
%21 45 90 79
%21 45 58 13
%21 45 56 1
%21 45 55 -4
%21 45 53 28
%21 49 15 -60
%21 49 13 -55
%21 49 34 -8
%21 51 90 59
%21 51 58 26
%21 51 56 13
%21 51 55 8
%21 51 53 71
%21 53 84 16
%21 53 83 38
%21 53 15 -33
%21 53 80 15
%21 53 74 42
%21 53 14 90
%21 53 70 13
%21 53 13 -28
%21 53 68 14
%21 53 66 17
%21 53 34 1
%21 55 90 15
%21 55 86 -38
%21 55 83 -41
%21 55 15 -40
%21 55 80 -71
%21 55 74 -20
%21 55 14 11
%21 55 70 -72
%21 55 13 -34
%21 55 66 -69
%21 55 34 -66
%21 56 90 15
%21 56 86 -38
%21 56 83 -41
%21 56 15 -40
%21 56 80 -68
%21 56 74 -20
%21 56 14 11
%21 56 70 -69
%21 56 13 -34
%21 56 66 -66
%21 56 34 -64
%21 58 87 15
%21 58 86 -38
%21 58 82 -55
%21 58 15 -40
%21 58 81 -31
%21 58 80 -57
%21 58 74 -37
%21 58 14 11
%21 58 70 -58
%21 58 13 -34
%21 58 66 -54
%21 58 34 -53
%21 71 71 29
%21 83 82 9
%21 83 15 -64
%21 83 80 8
%21 83 79 31
%21 83 78 31
%21 83 14 70
%21 83 73 -21
%21 83 72 -4
%21 83 71 33
%21 83 70 7
%21 83 69 7
%21 83 13 -58
%21 83 68 7
%22 34 58 -62
%22 34 56 -73
%22 34 55 -78
%22 34 53 -5
%22 39 15 -97
%22 39 13 -98
%22 39 34 -16
%22 45 90 20
%22 45 58 7
%22 45 56 9
%22 45 55 4
%22 49 15 -105
%22 49 13 -106
%22 49 34 -30
%22 51 58 11
%22 51 56 2
%22 51 55 2
%22 51 53 65
%22 53 28 48
%22 53 84 -7
%22 53 83 67
%22 53 15 -78
%22 53 80 14
%22 53 74 71
%22 53 14 20
%22 53 70 10
%22 53 13 -79
%22 53 27 48
%22 53 68 16
%22 53 66 9
%22 53 34 -14
%22 55 90 -14
%22 55 86 -10
%22 55 28 -44
%22 55 83 -20
%22 55 15 -100
%22 55 80 -70
%22 55 74 3
%22 55 14 20
%22 55 70 -70
%22 55 13 -109
%22 55 27 -35
%22 55 66 -70
%22 55 34 -70
%22 56 90 -14
%22 56 86 -20
%22 56 28 -42
%22 56 83 -30
%22 56 15 -100
%22 56 80 -60
%22 56 74 3
%22 56 14 20
%22 56 70 -60
%22 56 13 -109
%22 56 27 -35
%22 56 66 -60
%22 56 34 -60
%22 58 87 -19
%22 58 86 -31
%22 58 28 -40
%22 58 82 -72
%22 58 15 -100
%22 58 81 -37
%22 58 80 -75
%22 58 74 -11
%22 58 14 20
%22 58 70 -78
%22 58 13 -109
%22 58 27 -35
%22 58 66 -79
%22 58 34 -82
%22 71 71 -19
%22 83 82 -14
%22 83 15 -134
%22 83 80 -10
%22 83 79 38
%22 83 78 37
%22 83 14 20
%22 83 73 -20
%22 83 72 -3
%22 83 71 -9
%22 83 70 -15
%22 83 69 -9
%22 83 13 -143
%22 83 68 -8
%23 34 90 -1
%23 34 88 -9
%23 34 87 -8
%23 34 58 -52
%23 34 56 -20
%23 34 55 -68
%23 34 53 -40
%23 39 15 -132
%23 39 13 -130
%23 39 34 -59
%23 45 90 19
%23 45 58 -35
%23 45 56 -41
%23 45 55 -50
%23 45 53 -4
%23 49 15 -128
%23 49 13 -129
%23 49 34 -46
%23 51 90 -8
%23 51 58 -20
%23 51 56 -24
%23 51 55 -29
%23 51 53 -4
%23 53 28 5
%23 53 84 -10
%23 53 83 27
%23 53 15 -122
%23 53 80 -28
%23 53 74 27
%23 53 14 -10
%23 53 70 -29
%23 53 13 -122
%23 53 27 7
%23 53 68 -29
%23 53 66 -24
%23 53 34 -42
%23 55 90 12
%23 55 86 -11
%23 55 28 -38
%23 55 83 -15
%23 55 15 -105
%23 55 80 -79
%23 55 74 15
%23 55 14 -10
%23 55 70 -80
%23 55 13 -103
%23 55 27 -37
%23 55 66 -74
%23 55 34 -88
%23 56 90 12
%23 56 86 -11
%23 56 28 -38
%23 56 83 -15
%23 56 15 -105
%23 56 80 -78
%23 56 74 15
%23 56 14 -10
%23 56 70 -79
%23 56 13 -103
%23 56 27 -37
%23 56 66 -73
%23 56 34 -60
%23 58 87 24
%23 58 86 -13
%23 58 28 -34
%23 58 82 -66
%23 58 15 -105
%23 58 81 -23
%23 58 80 -66
%23 58 74 2
%23 58 14 -10
%23 58 70 -67
%23 58 13 -103
%23 58 27 -32
%23 58 66 -60
%23 58 34 -56
%23 71 71 21
%23 83 82 -9
%23 83 15 -102
%23 83 80 -9
%23 83 79 20
%23 83 78 20
%23 83 14 -10
%23 83 73 -23
%23 83 72 -9
%23 83 71 20
%23 83 70 -10
%23 83 69 -10
%23 83 13 -101
%23 83 68 -9
%24 34 90 20
%24 34 88 20
%24 34 87 20
%24 34 58 -25
%24 34 56 -35
%24 34 55 -40
%24 34 53 -17
%24 39 15 -105
%24 39 13 -98
%24 39 34 -35
%24 45 90 62
%24 45 58 -5
%24 45 56 -15
%24 45 55 -19
%24 45 53 -26
%24 49 15 -105
%24 49 13 -98
%24 49 34 -31
%24 51 90 27
%24 51 58 4
%24 51 56 -4
%24 51 55 -8
%24 51 53 -3
%24 53 90 56
%24 53 88 69
%24 53 86 42
%24 53 28 31
%24 53 84 -1
%24 53 83 41
%24 53 15 -107
%24 53 80 -5
%24 53 74 42
%24 53 14 -20
%24 53 70 -10
%24 53 13 -100
%24 53 27 26
%24 53 68 -8
%24 53 66 -8
%24 53 34 -42
%24 55 90 17
%24 55 86 -1
%24 55 28 -22
%24 55 83 2
%24 55 15 -115
%24 55 80 -50
%24 55 74 32
%24 55 14 -20
%24 55 70 -50
%24 55 13 -137
%24 55 27 -28
%24 55 66 -50
%24 55 34 -50
%24 56 90 -51
%24 56 86 -69
%24 56 28 -81
%24 56 83 -66
%24 56 15 -183
%24 56 80 -100
%24 56 74 -36
%24 56 14 -22
%24 56 70 -100
%24 56 13 -201
%24 56 27 -86
%24 56 66 -100
%24 56 34 -77
%24 58 87 26
%24 58 86 -1
%24 58 28 -4
%24 58 82 -43
%24 58 15 -113
%24 58 80 -41
%24 58 74 20
%24 58 14 -20
%24 58 70 -46
%24 58 13 -106
%24 58 27 -9
%24 58 66 -45
%24 58 34 -30
%24 71 71 10
%24 83 82 -3
%24 83 15 -120
%24 83 80 -1
%24 83 79 39
%24 83 78 39
%24 83 14 -20
%24 83 73 -35
%24 83 72 -23
%24 83 71 42
%24 83 70 -6
%24 83 69 -3
%24 83 13 -113
%24 83 68 -5
%25 34 90 -37
%25 34 88 -25
%25 34 87 -37
%25 34 8 -74
%25 34 119 -74
%25 34 58 -75
%25 34 56 -50
%25 34 55 -75
%25 34 54 -30
%25 34 53 -18
%25 35 15 -37
%25 35 13 -37
%25 35 34 -18
%25 36 15 -37
%25 36 13 -37
%25 36 34 -18
%25 37 15 -37
%25 37 13 -37
%25 37 58 -18
%25 37 55 -18
%25 39 83 -10
%25 39 15 -125
%25 39 80 -55
%25 39 74 -10
%25 39 70 -55
%25 39 13 -125
%25 39 66 -65
%25 39 34 -50
%25 40 15 -37
%25 40 13 -37
%25 43 86 -25
%25 43 15 -74
%25 43 80 -25
%25 43 70 -25
%25 43 13 -74
%25 43 66 -25
%25 43 34 -18
%25 44 90 -25
%25 44 80 10
%25 44 70 10
%25 45 90 -25
%25 45 8 -100
%25 45 119 -100
%25 45 58 -74
%25 45 56 -74
%25 45 55 -91
%25 45 53 -75
%25 47 15 -55
%25 47 13 -55
%25 48 15 -37
%25 48 13 -37
%25 48 58 -18
%25 48 55 -18
%25 48 53 10
%25 49 15 -125
%25 49 80 -37
%25 49 70 -37
%25 49 13 -125
%25 49 66 -37
%25 49 34 -55
%25 50 15 -25
%25 50 13 -25
%25 52 15 -37
%25 52 13 -37
%25 53 28 -37
%25 53 15 -125
%25 53 80 -55
%25 53 14 -100
%25 53 70 -55
%25 53 13 -125
%25 53 27 -37
%25 53 66 -55
%25 53 48 10
%25 53 34 -18
%25 54 15 -100
%25 54 13 -100
%25 54 34 -30
%25 55 86 -75
%25 55 28 -75
%25 55 15 -125
%25 55 80 -75
%25 55 74 -18
%25 55 14 -100
%25 55 70 -75
%25 55 13 -125
%25 55 27 -75
%25 55 66 -85
%25 55 48 -18
%25 55 34 -74
%25 56 90 -55
%25 56 86 -55
%25 56 28 -100
%25 56 15 -125
%25 56 80 -60
%25 56 74 -18
%25 56 14 -100
%25 56 70 -60
%25 56 13 -125
%25 56 27 -100
%25 56 66 -75
%25 56 34 -50
%25 58 86 -91
%25 58 28 -75
%25 58 15 -100
%25 58 80 -100
%25 58 74 -18
%25 58 14 -125
%25 58 70 -100
%25 58 13 -100
%25 58 27 -75
%25 58 66 -100
%25 58 48 -18
%25 58 34 -75
%25 66 90 -10
%25 66 88 -10
%25 66 87 -10
%25 67 15 -18
%25 67 13 -18
%25 68 15 -18
%25 68 77 -7
%25 68 76 -7
%25 68 73 -7
%25 68 13 -18
%25 27 1 -37
%25 13 1 -37
%25 13 8 -37
%25 13 119 -37
%25 70 15 -18
%25 70 13 -18
%25 71 8 100
%25 71 119 100
%25 71 15 -37
%25 71 13 -37
%25 72 15 -25
%25 72 13 -25
%25 80 15 -18
%25 80 13 -18
%25 81 15 -18
%25 81 13 -18
%25 15 1 -37
%25 15 8 -37
%25 15 119 -37
%25 105 34 -74
%25 119 1 -37
%25 65 65 -25
%25 65 34 -74
%25 8 84 -25
%25 8 8 -25
%25 8 69 -37
%25 83 15 -100
%25 83 14 -37
%25 83 13 -100
%25 84 15 -25
%25 84 13 -25
%25 28 1 -37
%25 1 65 -37
%25 1 105 -37
%25 1 58 -37
%25 1 56 -37
%25 1 55 -37
%25 1 53 -37
%25 1 34 -37
%25 87 15 -125
%25 87 13 -125
%25 88 15 -125
%25 88 13 -125
%25 88 66 -18
%25 90 15 -125
%25 90 13 -125
%26 34 90 -55
%26 34 88 -18
%26 34 87 -18
%26 34 86 -18
%26 34 8 -125
%26 34 119 -125
%26 34 58 -55
%26 34 56 -74
%26 34 55 -74
%26 34 54 -37
%26 34 53 -30
%26 34 50 -18
%26 34 48 -18
%26 34 40 -18
%26 34 36 -18
%26 35 15 -50
%26 35 13 -50
%26 36 15 -50
%26 36 13 -50
%26 37 15 -50
%26 37 13 -50
%26 37 58 -18
%26 37 56 -18
%26 37 55 -18
%26 39 83 -55
%26 39 15 -125
%26 39 80 -55
%26 39 74 -10
%26 39 70 -55
%26 39 13 -125
%26 39 66 -55
%26 39 34 -35
%26 40 15 -50
%26 40 13 -50
%26 43 86 -18
%26 43 15 -100
%26 43 80 -37
%26 43 70 -37
%26 43 13 -100
%26 43 66 -37
%26 43 34 -18
%26 45 90 -50
%26 45 8 -125
%26 45 119 -125
%26 45 58 -100
%26 45 56 -100
%26 45 55 -100
%26 45 53 -100
%26 47 15 -60
%26 47 13 -60
%26 48 15 -50
%26 48 13 -50
%26 48 58 -18
%26 48 57 -18
%26 48 55 -18
%26 48 53 18
%26 49 15 -125
%26 49 80 -55
%26 49 70 -55
%26 49 13 -125
%26 49 66 -55
%26 49 34 -50
%26 50 15 -20
%26 50 13 -20
%26 51 58 -18
%26 51 56 -18
%26 51 55 -18
%26 51 54 -18
%26 52 15 -50
%26 52 13 -50
%26 53 90 -50
%26 53 88 -50
%26 53 86 -50
%26 53 28 -50
%26 53 83 -50
%26 53 15 -100
%26 53 80 -74
%26 53 74 -18
%26 53 14 -100
%26 53 73 -25
%26 53 70 -74
%26 53 13 -100
%26 53 27 -50
%26 53 66 -74
%26 53 48 18
%26 54 15 -100
%26 54 13 -100
%26 54 34 -18
%26 55 86 -75
%26 55 28 -75
%26 55 15 -100
%26 55 80 -75
%26 55 74 -50
%26 55 14 -100
%26 55 70 -75
%26 55 13 -100
%26 55 27 -75
%26 55 66 -75
%26 55 34 -37
%26 56 90 -55
%26 56 86 -55
%26 56 28 -75
%26 56 15 -100
%26 56 80 -55
%26 56 74 -20
%26 56 14 -75
%26 56 73 -20
%26 56 70 -55
%26 56 13 -100
%26 56 27 -75
%26 56 66 -55
%26 56 34 -55
%26 58 86 -100
%26 58 28 -75
%26 58 15 -100
%26 58 80 -100
%26 58 74 -25
%26 58 14 -100
%26 58 70 -100
%26 58 13 -100
%26 58 27 -75
%26 58 66 -100
%26 58 34 -55
%26 67 15 -50
%26 67 13 -50
%26 67 67 -10
%26 68 15 -50
%26 68 76 -18
%26 68 73 -18
%26 68 13 -50
%26 27 1 -37
%26 13 1 -37
%26 13 8 -37
%26 13 119 -37
%26 70 15 -37
%26 70 13 -37
%26 71 8 75
%26 71 119 75
%26 71 15 -75
%26 71 80 -10
%26 71 13 -75
%26 72 15 -50
%26 72 13 -50
%26 77 90 -10
%26 80 15 -50
%26 80 13 -50
%26 81 15 -50
%26 81 13 -50
%26 15 1 -37
%26 15 8 -37
%26 15 119 -37
%26 105 34 -75
%26 119 1 -37
%26 65 65 -37
%26 65 34 -75
%26 8 84 -25
%26 8 8 -37
%26 8 69 -37
%26 83 28 -25
%26 83 84 -10
%26 83 15 -125
%26 83 76 -18
%26 83 14 -75
%26 83 13 -125
%26 83 27 -25
%26 84 15 -50
%26 84 13 -50
%26 28 1 -37
%26 1 65 -37
%26 1 105 -37
%26 1 58 -37
%26 1 56 -37
%26 1 55 -37
%26 1 53 -37
%26 1 34 -37
%26 87 15 -75
%26 87 13 -75
%26 88 15 -75
%26 88 13 -75
%26 90 15 -75
%26 90 13 -75
%27 34 90 -18
%27 34 88 -18
%27 34 87 -18
%27 34 8 -74
%27 34 119 -74
%27 34 58 -91
%27 34 56 -74
%27 34 55 -74
%27 34 54 -18
%27 34 53 -55
%27 36 15 -18
%27 36 13 -18
%27 37 15 -25
%27 37 13 -25
%27 39 83 -18
%27 39 15 -125
%27 39 80 -55
%27 39 74 -18
%27 39 70 -55
%27 39 13 -125
%27 39 66 -74
%27 43 86 -18
%27 43 15 -55
%27 43 80 -18
%27 43 70 -18
%27 43 13 -55
%27 43 66 -18
%27 43 34 -18
%27 44 90 -25
%27 44 86 -18
%27 45 90 -25
%27 45 8 -100
%27 45 119 -100
%27 45 58 -74
%27 45 56 -74
%27 45 55 -100
%27 45 53 -100
%27 47 15 -18
%27 47 13 -18
%27 48 15 -25
%27 48 13 -25
%27 48 53 10
%27 49 15 -150
%27 49 80 -55
%27 49 70 -55
%27 49 13 -150
%27 49 66 -55
%27 49 34 -74
%27 52 15 -18
%27 52 13 -18
%27 53 86 -18
%27 53 83 -18
%27 53 15 -100
%27 53 80 -74
%27 53 74 -18
%27 53 14 -125
%27 53 70 -74
%27 53 13 -100
%27 53 66 -74
%27 53 48 10
%27 53 34 -55
%27 54 15 -25
%27 54 13 -25
%27 54 34 -18
%27 55 86 -55
%27 55 28 -37
%27 55 15 -125
%27 55 80 -74
%27 55 74 -18
%27 55 14 -100
%27 55 70 -74
%27 55 13 -125
%27 55 27 -37
%27 55 66 -74
%27 55 34 -74
%27 56 90 -25
%27 56 86 -37
%27 56 28 -55
%27 56 15 -100
%27 56 80 -74
%27 56 74 -18
%27 56 14 -100
%27 56 70 -74
%27 56 13 -100
%27 56 27 -55
%27 56 66 -74
%27 56 34 -74
%27 58 86 -55
%27 58 28 -25
%27 58 15 -100
%27 58 80 -100
%27 58 74 -18
%27 58 14 -125
%27 58 70 -100
%27 58 13 -100
%27 58 27 -25
%27 58 66 -100
%27 58 34 -91
%27 27 1 -18
%27 13 1 -18
%27 13 8 -18
%27 13 119 -18
%27 71 8 75
%27 71 119 75
%27 15 1 -18
%27 15 8 -18
%27 15 119 -18
%27 105 34 -74
%27 119 1 -18
%27 65 34 -74
%27 8 84 -25
%27 8 69 -25
%27 83 15 -74
%27 83 13 -74
%27 28 1 -18
%27 1 65 -18
%27 1 105 -18
%27 1 58 -18
%27 1 56 -18
%27 1 55 -18
%27 1 53 -18
%27 1 34 -18
%27 87 15 -100
%27 87 13 -100
%27 88 15 -100
%27 88 13 -100
%27 90 15 -100
%27 90 13 -100
%28 34 90 -33
%28 34 88 -25
%28 34 87 -10
%28 34 86 -15
%28 34 8 -95
%28 34 119 -95
%28 34 58 -70
%28 34 56 -84
%28 34 55 -100
%28 34 54 -32
%28 34 53 5
%28 34 50 5
%28 34 48 5
%28 34 40 5
%28 34 36 5
%28 35 15 15
%28 35 13 15
%28 35 54 15
%28 35 34 -11
%28 36 34 -5
%28 37 15 -11
%28 37 13 -11
%28 37 58 6
%28 37 56 -11
%28 37 55 -18
%28 39 83 -27
%28 39 15 -91
%28 39 80 -47
%28 39 74 -41
%28 39 70 -41
%28 39 13 -91
%28 39 66 -47
%28 39 34 -79
%28 43 86 -39
%28 43 15 -74
%28 43 80 -40
%28 43 70 -33
%28 43 13 -74
%28 43 66 -40
%28 43 34 -30
%28 44 90 -48
%28 44 86 -4
%28 44 80 -4
%28 44 70 18
%28 45 90 -30
%28 45 8 -100
%28 45 119 -100
%28 45 58 -55
%28 45 56 -69
%28 45 55 -97
%28 45 53 -75
%28 47 15 -49
%28 47 13 -49
%28 48 15 -18
%28 48 13 -18
%28 48 57 -18
%28 48 56 -15
%28 48 55 -24
%28 48 34 -5
%28 49 15 -100
%28 49 80 -40
%28 49 70 -33
%28 49 13 -100
%28 49 66 -40
%28 49 34 -80
%28 51 56 -14
%28 51 55 -24
%28 52 15 -18
%28 52 13 -18
%28 53 90 -30
%28 53 88 -30
%28 53 86 -22
%28 53 83 -9
%28 53 15 -55
%28 53 80 -40
%28 53 74 -22
%28 53 14 -75
%28 53 73 -9
%28 53 70 -33
%28 53 13 -55
%28 53 66 -40
%28 53 48 11
%28 53 34 -60
%28 54 15 -25
%28 54 13 -25
%28 54 34 -42
%28 55 86 -70
%28 55 28 6
%28 55 15 -94
%28 55 80 -71
%28 55 74 -35
%28 55 14 -94
%28 55 70 -66
%28 55 13 -94
%28 55 27 -49
%28 55 66 -55
%28 55 48 -19
%28 55 40 -12
%28 55 34 -100
%28 56 90 -41
%28 56 86 -25
%28 56 28 -22
%28 56 15 -86
%28 56 80 -33
%28 56 74 -27
%28 56 14 -61
%28 56 73 5
%28 56 70 -39
%28 56 13 -86
%28 56 27 -22
%28 56 66 -33
%28 56 48 -11
%28 56 34 -66
%28 58 86 -58
%28 58 28 -55
%28 58 15 -91
%28 58 80 -77
%28 58 74 -22
%28 58 14 -91
%28 58 70 -71
%28 58 13 -91
%28 58 27 -55
%28 58 66 -77
%28 58 34 -79
%28 66 90 -8
%28 66 88 -8
%28 66 87 6
%28 67 90 -6
%28 67 87 8
%28 67 15 6
%28 67 13 6
%28 68 90 -20
%28 68 15 -8
%28 68 77 -13
%28 68 76 -8
%28 68 73 -18
%28 68 13 -8
%28 27 1 -18
%28 13 1 -18
%28 13 8 -18
%28 13 119 -18
%28 69 90 -15
%28 69 88 -15
%28 70 90 -15
%28 70 89 -5
%28 70 88 -15
%28 70 81 -11
%28 70 72 -4
%28 70 67 -8
%28 71 8 105
%28 71 119 105
%28 71 15 -28
%28 71 80 7
%28 71 77 7
%28 71 74 7
%28 71 70 14
%28 71 145 7
%28 71 13 -28
%28 71 66 8
%28 72 90 -11
%28 72 83 11
%28 72 15 -5
%28 72 13 -5
%28 73 90 -20
%28 74 87 7
%28 76 90 -15
%28 76 80 -22
%28 76 70 -16
%28 77 90 -7
%28 77 88 -7
%28 78 90 -20
%28 78 86 -11
%28 79 90 -20
%28 79 87 -7
%28 79 86 -11
%28 80 90 -11
%28 80 88 -8
%28 80 87 6
%28 81 90 -4
%28 81 15 8
%28 81 13 8
%28 15 1 -18
%28 15 8 -18
%28 15 119 -18
%28 105 65 20
%28 105 34 -60
%28 119 1 -18
%28 65 34 -80
%28 8 87 -16
%28 8 85 -22
%28 8 84 -46
%28 8 83 -9
%28 8 77 -22
%28 8 69 -41
%28 83 90 -20
%28 83 87 -7
%28 83 86 -11
%28 83 85 -11
%28 83 28 9
%28 83 84 -20
%28 83 8 9
%28 83 15 -90
%28 83 81 -17
%28 83 80 -11
%28 83 77 -14
%28 83 76 9
%28 83 74 -14
%28 83 14 -16
%28 83 72 -11
%28 83 70 -7
%28 83 69 -7
%28 83 13 -90
%28 83 27 9
%28 83 66 -11
%28 84 15 11
%28 84 13 11
%28 28 1 -18
%28 1 105 -18
%28 1 58 -18
%28 1 56 -33
%28 1 55 -24
%28 1 53 -18
%28 1 34 -22
%28 87 15 -11
%28 87 80 -6
%28 87 13 -11
%28 87 66 -6
%28 88 15 -17
%28 88 80 -14
%28 88 70 -8
%28 88 13 -17
%28 88 66 -14
%28 89 70 5
%28 90 15 -25
%28 90 80 8
%28 90 70 15
%28 90 13 -25
%28 90 66 8
%28 91 70 4
%29 34 90 -32
%29 34 88 -32
%29 34 87 -32
%29 34 86 -24
%29 34 58 -81
%29 34 56 -40
%29 34 55 -56
%29 34 54 -40
%29 34 53 -97
%29 34 50 -24
%29 34 48 -24
%29 34 40 -24
%29 34 36 -24
%29 35 15 -15
%29 35 13 -15
%29 35 54 -7
%29 36 15 -24
%29 36 13 -24
%29 37 15 -56
%29 37 13 -56
%29 37 58 -73
%29 37 56 -32
%29 37 55 -56
%29 37 34 -32
%29 39 83 -36
%29 39 15 -122
%29 39 80 -24
%29 39 70 -24
%29 39 13 -122
%29 39 66 -40
%29 39 34 -65
%29 43 86 -15
%29 43 15 -24
%29 43 13 -24
%29 43 66 -15
%29 43 34 -15
%29 44 90 -40
%29 44 86 -24
%29 44 80 -32
%29 44 70 -32
%29 44 48 -40
%29 45 90 -24
%29 45 8 -130
%29 45 119 -114
%29 45 58 -114
%29 45 56 -56
%29 45 55 -89
%29 45 53 -89
%29 48 15 -32
%29 48 13 -32
%29 48 58 -56
%29 48 57 -48
%29 48 56 -24
%29 48 55 -40
%29 48 53 -32
%29 48 34 -15
%29 49 15 -147
%29 49 80 -40
%29 49 70 -40
%29 49 13 -147
%29 49 66 -32
%29 49 34 -97
%29 50 54 -7
%29 51 58 -40
%29 51 56 -24
%29 51 55 -40
%29 51 54 -32
%29 51 53 -24
%29 51 48 -15
%29 52 15 -15
%29 52 13 -15
%29 53 90 -97
%29 53 88 -97
%29 53 86 -97
%29 53 28 -15
%29 53 83 -97
%29 53 15 -97
%29 53 80 -97
%29 53 14 -114
%29 53 70 -97
%29 53 13 -97
%29 53 27 -15
%29 53 66 -97
%29 53 48 -32
%29 53 34 -97
%29 54 15 -32
%29 54 13 -32
%29 54 34 -32
%29 55 86 -56
%29 55 28 -32
%29 55 15 -102
%29 55 80 -65
%29 55 14 -65
%29 55 70 -65
%29 55 13 -102
%29 55 27 -32
%29 55 66 -56
%29 55 48 -32
%29 55 40 -32
%29 55 34 -65
%29 56 90 -15
%29 56 86 -24
%29 56 15 -65
%29 56 80 -24
%29 56 14 -32
%29 56 70 -24
%29 56 13 -65
%29 56 66 -32
%29 56 48 -15
%29 56 34 -40
%29 58 86 -89
%29 58 28 -48
%29 58 15 -114
%29 58 80 -114
%29 58 74 -15
%29 58 14 -114
%29 58 70 -114
%29 58 13 -114
%29 58 27 -48
%29 58 66 -114
%29 58 48 -69
%29 58 34 -89
%29 66 90 -24
%29 66 88 -15
%29 66 87 -15
%29 67 90 -15
%29 67 87 -15
%29 67 86 -15
%29 67 15 -32
%29 67 77 -15
%29 67 13 -32
%29 67 67 -7
%29 68 76 -15
%29 68 13 -11
%29 27 1 -40
%29 13 8 -81
%29 13 119 -81
%29 70 90 -15
%29 70 89 -24
%29 70 88 -15
%29 70 87 -24
%29 70 15 -11
%29 70 13 -11
%29 71 8 41
%29 71 119 49
%29 71 15 -24
%29 71 80 -24
%29 71 70 -24
%29 71 145 -22
%29 71 13 -24
%29 71 66 -24
%29 72 83 -7
%29 73 90 -24
%29 76 80 -15
%29 76 70 -15
%29 78 90 -11
%29 78 86 -7
%29 79 90 -11
%29 79 87 -15
%29 79 86 -7
%29 80 90 -24
%29 80 89 -24
%29 80 88 -11
%29 80 87 -11
%29 80 15 -32
%29 80 13 -32
%29 147 91 -44
%29 147 90 -56
%29 147 89 -69
%29 147 88 -56
%29 147 87 -56
%29 147 86 -44
%29 147 85 -44
%29 147 84 -44
%29 147 83 -44
%29 147 82 -44
%29 147 15 -77
%29 147 81 -44
%29 147 80 -44
%29 147 79 -44
%29 147 78 -44
%29 147 77 -44
%29 147 76 -44
%29 147 75 -44
%29 147 74 -44
%29 147 73 -44
%29 147 72 -44
%29 147 71 -44
%29 147 70 -44
%29 147 69 -44
%29 147 13 -77
%29 147 68 -44
%29 147 67 -44
%29 147 66 -44
%29 81 90 -24
%29 81 15 -28
%29 81 13 -28
%29 15 1 -48
%29 15 8 -81
%29 15 119 -81
%29 119 1 -32
%29 65 65 -46
%29 8 1 -56
%29 8 84 -40
%29 8 83 -40
%29 8 8 -46
%29 8 69 -40
%29 83 90 25
%29 83 87 25
%29 83 86 12
%29 83 85 33
%29 83 28 25
%29 83 15 -40
%29 83 81 25
%29 83 79 21
%29 83 78 21
%29 83 77 12
%29 83 76 12
%29 83 74 12
%29 83 13 -40
%29 83 27 25
%29 83 66 -7
%29 84 88 -24
%29 84 15 -11
%29 84 13 -11
%29 28 1 -40
%29 1 65 -48
%29 1 105 -24
%29 1 58 -73
%29 1 56 -32
%29 1 55 -40
%29 1 53 -40
%29 87 15 -65
%29 87 80 -20
%29 87 70 -20
%29 87 13 -65
%29 87 66 -20
%29 88 15 -48
%29 88 80 -7
%29 88 70 -7
%29 88 13 -48
%29 88 66 -11
%29 89 70 -24
%29 90 15 -81
%29 90 80 -15
%29 90 70 -15
%29 90 13 -81
%29 90 66 -15
%29 91 80 -11
%29 91 70 -11
%30 34 90 -40
%30 34 88 -40
%30 34 87 -40
%30 34 86 -30
%30 34 58 -100
%30 34 56 -50
%30 34 55 -70
%30 34 54 -50
%30 34 53 -120
%30 34 50 -30
%30 34 48 -30
%30 34 40 -30
%30 34 36 -30
%30 35 15 -20
%30 35 13 -20
%30 35 54 -10
%30 36 15 -30
%30 36 13 -30
%30 37 15 -70
%30 37 13 -70
%30 37 58 -90
%30 37 56 -40
%30 37 55 -70
%30 37 34 -40
%30 39 83 -45
%30 39 15 -150
%30 39 80 -30
%30 39 70 -30
%30 39 13 -150
%30 39 66 -50
%30 39 34 -80
%30 43 86 -20
%30 43 15 -30
%30 43 13 -30
%30 43 66 -20
%30 43 34 -20
%30 44 90 -50
%30 44 86 -30
%30 44 80 -40
%30 44 70 -40
%30 44 48 -50
%30 45 90 -30
%30 45 8 -160
%30 45 119 -140
%30 45 58 -140
%30 45 56 -70
%30 45 55 -110
%30 45 53 -110
%30 48 15 -40
%30 48 13 -40
%30 48 58 -70
%30 48 57 -60
%30 48 56 -30
%30 48 55 -50
%30 48 53 -40
%30 48 34 -20
%30 49 15 -180
%30 49 80 -50
%30 49 70 -50
%30 49 13 -180
%30 49 66 -40
%30 49 34 -120
%30 50 54 -10
%30 51 58 -50
%30 51 56 -30
%30 51 55 -50
%30 51 54 -40
%30 51 53 -30
%30 51 48 -20
%30 52 15 -20
%30 52 13 -20
%30 53 90 -120
%30 53 88 -120
%30 53 86 -120
%30 53 28 -20
%30 53 83 -120
%30 53 15 -120
%30 53 80 -120
%30 53 14 -140
%30 53 70 -120
%30 53 13 -120
%30 53 27 -20
%30 53 66 -120
%30 53 48 -40
%30 53 34 -120
%30 54 15 -40
%30 54 13 -40
%30 54 34 -40
%30 55 86 -70
%30 55 28 -40
%30 55 15 -125
%30 55 80 -80
%30 55 14 -80
%30 55 70 -80
%30 55 13 -125
%30 55 27 -40
%30 55 66 -70
%30 55 48 -40
%30 55 40 -40
%30 55 34 -80
%30 56 90 -20
%30 56 86 -30
%30 56 15 -80
%30 56 80 -30
%30 56 14 -40
%30 56 70 -30
%30 56 13 -80
%30 56 66 -40
%30 56 48 -20
%30 56 34 -50
%30 58 86 -110
%30 58 28 -60
%30 58 15 -140
%30 58 80 -140
%30 58 74 -20
%30 58 14 -140
%30 58 70 -140
%30 58 13 -140
%30 58 27 -60
%30 58 66 -140
%30 58 48 -85
%30 58 34 -110
%30 66 90 -30
%30 66 88 -20
%30 66 87 -20
%30 67 90 -20
%30 67 87 -20
%30 67 86 -20
%30 67 15 -40
%30 67 77 -20
%30 67 13 -40
%30 67 67 -10
%30 68 76 -20
%30 68 13 -15
%30 27 1 -50
%30 13 8 -100
%30 13 119 -100
%30 70 90 -20
%30 70 89 -30
%30 70 88 -20
%30 70 87 -30
%30 70 15 -15
%30 70 13 -15
%30 71 8 50
%30 71 119 60
%30 71 15 -30
%30 71 80 -30
%30 71 70 -30
%30 71 145 -28
%30 71 13 -30
%30 71 66 -30
%30 72 83 -10
%30 73 90 -30
%30 76 80 -20
%30 76 70 -20
%30 78 90 -15
%30 78 86 -10
%30 79 90 -15
%30 79 87 -20
%30 79 86 -10
%30 80 90 -30
%30 80 89 -30
%30 80 88 -15
%30 80 87 -15
%30 80 15 -40
%30 80 13 -40
%30 147 91 -55
%30 147 90 -70
%30 147 89 -85
%30 147 88 -70
%30 147 87 -70
%30 147 86 -55
%30 147 85 -55
%30 147 84 -55
%30 147 83 -55
%30 147 82 -55
%30 147 15 -95
%30 147 81 -55
%30 147 80 -55
%30 147 79 -55
%30 147 78 -55
%30 147 77 -55
%30 147 76 -55
%30 147 75 -55
%30 147 74 -55
%30 147 73 -55
%30 147 72 -55
%30 147 71 -55
%30 147 70 -55
%30 147 69 -55
%30 147 13 -95
%30 147 68 -55
%30 147 67 -55
%30 147 66 -55
%30 81 90 -30
%30 81 15 -35
%30 81 13 -35
%30 15 1 -60
%30 15 8 -100
%30 15 119 -100
%30 119 1 -40
%30 65 65 -57
%30 8 1 -70
%30 8 84 -50
%30 8 83 -50
%30 8 8 -57
%30 8 69 -50
%30 83 90 30
%30 83 87 30
%30 83 86 15
%30 83 85 40
%30 83 28 30
%30 83 15 -50
%30 83 81 30
%30 83 79 25
%30 83 78 25
%30 83 77 15
%30 83 76 15
%30 83 74 15
%30 83 13 -50
%30 83 27 30
%30 83 66 -10
%30 84 88 -30
%30 84 15 -15
%30 84 13 -15
%30 28 1 -50
%30 1 65 -60
%30 1 105 -30
%30 1 58 -90
%30 1 56 -40
%30 1 55 -50
%30 1 53 -50
%30 87 15 -80
%30 87 80 -25
%30 87 70 -25
%30 87 13 -80
%30 87 66 -25
%30 88 15 -60
%30 88 80 -10
%30 88 70 -10
%30 88 13 -60
%30 88 66 -15
%30 89 70 -30
%30 90 15 -100
%30 90 80 -20
%30 90 70 -20
%30 90 13 -100
%30 90 66 -20
%30 91 80 -15
%30 91 70 -15
%31 34 90 -24
%31 34 88 -24
%31 34 87 -32
%31 34 86 -24
%31 34 58 -89
%31 34 56 -48
%31 34 55 -65
%31 34 54 -40
%31 34 53 -73
%31 34 50 -32
%31 34 48 -32
%31 34 40 -40
%31 34 36 -32
%31 35 54 -7
%31 35 34 -24
%31 37 15 -24
%31 37 13 -24
%31 37 58 -56
%31 37 56 -32
%31 37 55 -32
%31 37 34 -32
%31 39 15 -81
%31 39 13 -81
%31 39 66 -15
%31 39 34 -65
%31 43 86 -15
%31 43 15 -15
%31 43 13 -15
%31 43 34 -15
%31 44 90 -32
%31 44 86 -24
%31 44 80 -28
%31 44 70 -11
%31 44 48 -24
%31 45 90 -24
%31 45 8 -114
%31 45 119 -114
%31 45 58 -97
%31 45 56 -65
%31 45 55 -89
%31 45 53 -73
%31 48 15 -32
%31 48 13 -32
%31 48 58 -56
%31 48 57 -40
%31 48 56 -40
%31 48 55 -40
%31 48 53 -32
%31 48 34 -40
%31 49 15 -97
%31 49 80 -32
%31 49 70 -24
%31 49 13 -97
%31 49 66 -24
%31 49 34 -81
%31 50 15 16
%31 50 13 16
%31 50 54 -7
%31 51 58 -40
%31 51 56 -32
%31 51 55 -40
%31 51 54 -15
%31 51 53 -15
%31 51 48 -15
%31 53 90 -48
%31 53 88 -48
%31 53 86 -73
%31 53 28 -32
%31 53 83 -65
%31 53 15 -65
%31 53 80 -65
%31 53 14 -97
%31 53 70 -48
%31 53 13 -65
%31 53 27 -32
%31 53 66 -65
%31 53 48 -32
%31 53 34 -73
%31 54 15 -24
%31 54 13 -24
%31 54 34 -40
%31 55 86 -48
%31 55 28 -32
%31 55 15 -97
%31 55 80 -73
%31 55 14 -65
%31 55 70 -40
%31 55 13 -97
%31 55 27 -32
%31 55 66 -48
%31 55 48 -40
%31 55 40 -40
%31 55 34 -65
%31 56 90 -15
%31 56 86 -36
%31 56 28 -7
%31 56 15 -65
%31 56 80 -48
%31 56 14 -32
%31 56 70 -28
%31 56 13 -65
%31 56 27 -7
%31 56 66 -32
%31 56 48 -15
%31 56 34 -48
%31 58 86 -81
%31 58 28 -40
%31 58 15 -81
%31 58 80 -81
%31 58 70 -65
%31 58 13 -81
%31 58 27 -40
%31 58 66 -73
%31 58 48 -56
%31 58 34 -89
%31 66 90 -15
%31 66 88 -11
%31 66 87 -11
%31 66 72 -7
%31 67 90 -15
%31 67 87 -15
%31 67 86 -15
%31 67 77 -7
%31 68 90 -7
%31 68 77 -15
%31 68 76 -15
%31 68 73 -7
%31 27 1 -32
%31 13 1 -32
%31 13 8 -97
%31 13 119 -97
%31 69 90 -11
%31 69 88 -11
%31 69 87 -11
%31 69 69 -7
%31 70 90 -11
%31 70 89 -11
%31 70 88 -11
%31 70 87 -11
%31 70 15 16
%31 70 13 8
%31 71 8 25
%31 71 119 25
%31 71 15 -7
%31 71 80 -15
%31 71 70 -7
%31 71 13 -7
%31 72 72 -7
%31 72 70 8
%31 73 90 -15
%31 76 80 -11
%31 77 90 -11
%31 77 88 -11
%31 78 90 -24
%31 78 86 -15
%31 79 90 -15
%31 79 87 -32
%31 79 86 -7
%31 80 90 -15
%31 80 89 -24
%31 80 88 -11
%31 80 87 -15
%31 81 90 -11
%31 15 1 -32
%31 15 8 -97
%31 15 119 -97
%31 119 1 -65
%31 65 65 -37
%31 8 87 -15
%31 8 1 -65
%31 8 84 -48
%31 8 83 -32
%31 8 8 -37
%31 8 77 -15
%31 8 69 -65
%31 83 90 8
%31 83 87 8
%31 83 85 16
%31 83 84 -11
%31 83 82 -15
%31 83 15 -48
%31 83 80 -15
%31 83 14 -15
%31 83 72 -11
%31 83 69 -15
%31 83 13 -48
%31 83 68 -15
%31 84 88 -11
%31 28 1 -32
%31 1 65 -48
%31 1 105 -65
%31 1 58 -97
%31 1 56 -65
%31 1 55 -65
%31 1 53 -81
%31 87 15 -65
%31 87 80 -24
%31 87 13 -65
%31 87 66 -15
%31 88 15 -32
%31 88 80 -15
%31 88 13 -32
%31 89 70 -7
%31 90 15 -65
%31 90 80 -20
%31 90 70 -7
%31 90 13 -65
%31 90 66 -24
%31 91 70 8
%32 34 90 -30
%32 34 88 -30
%32 34 87 -40
%32 34 86 -30
%32 34 58 -110
%32 34 56 -60
%32 34 55 -80
%32 34 54 -50
%32 34 53 -90
%32 34 50 -40
%32 34 48 -40
%32 34 40 -50
%32 34 36 -40
%32 35 54 -10
%32 35 34 -30
%32 37 15 -30
%32 37 13 -30
%32 37 58 -70
%32 37 56 -40
%32 37 55 -40
%32 37 34 -40
%32 39 15 -100
%32 39 13 -100
%32 39 66 -20
%32 39 34 -80
%32 43 86 -20
%32 43 15 -20
%32 43 13 -20
%32 43 34 -20
%32 44 90 -40
%32 44 86 -30
%32 44 80 -35
%32 44 70 -15
%32 44 48 -30
%32 45 90 -30
%32 45 8 -140
%32 45 119 -140
%32 45 58 -120
%32 45 56 -80
%32 45 55 -110
%32 45 53 -90
%32 48 15 -40
%32 48 13 -40
%32 48 58 -70
%32 48 57 -50
%32 48 56 -50
%32 48 55 -50
%32 48 53 -40
%32 48 34 -50
%32 49 15 -120
%32 49 80 -40
%32 49 70 -30
%32 49 13 -120
%32 49 66 -30
%32 49 34 -100
%32 50 15 20
%32 50 13 20
%32 50 54 -10
%32 51 58 -50
%32 51 56 -40
%32 51 55 -50
%32 51 54 -20
%32 51 53 -20
%32 51 48 -20
%32 53 90 -60
%32 53 88 -60
%32 53 86 -90
%32 53 28 -40
%32 53 83 -80
%32 53 15 -80
%32 53 80 -80
%32 53 14 -120
%32 53 70 -60
%32 53 13 -80
%32 53 27 -40
%32 53 66 -80
%32 53 48 -40
%32 53 34 -90
%32 54 15 -30
%32 54 13 -30
%32 54 34 -50
%32 55 86 -60
%32 55 28 -40
%32 55 15 -120
%32 55 80 -90
%32 55 14 -80
%32 55 70 -50
%32 55 13 -120
%32 55 27 -40
%32 55 66 -60
%32 55 48 -50
%32 55 40 -50
%32 55 34 -80
%32 56 90 -20
%32 56 86 -45
%32 56 28 -10
%32 56 15 -80
%32 56 80 -60
%32 56 14 -40
%32 56 70 -35
%32 56 13 -80
%32 56 27 -10
%32 56 66 -40
%32 56 48 -20
%32 56 34 -60
%32 58 86 -100
%32 58 28 -50
%32 58 15 -100
%32 58 80 -100
%32 58 70 -80
%32 58 13 -100
%32 58 27 -50
%32 58 66 -90
%32 58 48 -70
%32 58 34 -110
%32 66 90 -20
%32 66 88 -15
%32 66 87 -15
%32 66 72 -10
%32 67 90 -20
%32 67 87 -20
%32 67 86 -20
%32 67 77 -10
%32 68 90 -10
%32 68 77 -20
%32 68 76 -20
%32 68 73 -10
%32 27 1 -40
%32 13 1 -40
%32 13 8 -120
%32 13 119 -120
%32 69 90 -15
%32 69 88 -15
%32 69 87 -15
%32 69 69 -10
%32 70 90 -15
%32 70 89 -15
%32 70 88 -15
%32 70 87 -15
%32 70 15 20
%32 70 13 10
%32 71 8 30
%32 71 119 30
%32 71 15 -10
%32 71 80 -20
%32 71 70 -10
%32 71 13 -10
%32 72 72 -10
%32 72 70 10
%32 73 90 -20
%32 76 80 -15
%32 77 90 -15
%32 77 88 -15
%32 78 90 -30
%32 78 86 -20
%32 79 90 -20
%32 79 87 -40
%32 79 86 -10
%32 80 90 -20
%32 80 89 -30
%32 80 88 -15
%32 80 87 -20
%32 81 90 -15
%32 15 1 -40
%32 15 8 -120
%32 15 119 -120
%32 119 1 -80
%32 65 65 -46
%32 8 87 -20
%32 8 1 -80
%32 8 84 -60
%32 8 83 -40
%32 8 8 -46
%32 8 77 -20
%32 8 69 -80
%32 83 90 10
%32 83 87 10
%32 83 85 20
%32 83 84 -15
%32 83 82 -20
%32 83 15 -60
%32 83 80 -20
%32 83 14 -20
%32 83 72 -15
%32 83 69 -20
%32 83 13 -60
%32 83 68 -20
%32 84 88 -15
%32 28 1 -40
%32 1 65 -60
%32 1 105 -80
%32 1 58 -120
%32 1 56 -80
%32 1 55 -80
%32 1 53 -100
%32 87 15 -80
%32 87 80 -30
%32 87 13 -80
%32 87 66 -20
%32 88 15 -40
%32 88 80 -20
%32 88 13 -40
%32 89 70 -10
%32 90 15 -80
%32 90 80 -25
%32 90 70 -10
%32 90 13 -80
%32 90 66 -30
%32 91 70 10
%33 34 8 -40
%33 34 119 -40
%33 34 54 -10
%33 34 53 10
%33 34 50 10
%33 34 48 10
%33 34 40 -30
%33 34 36 20
%33 37 15 -30
%33 37 13 -20
%33 37 58 10
%33 37 34 -10
%33 39 15 -40
%33 39 74 10
%33 39 13 -30
%33 40 15 -20
%33 40 13 -10
%33 43 15 -20
%33 43 13 -10
%33 44 86 -20
%33 44 80 -20
%33 44 70 -20
%33 45 90 -10
%33 45 8 -25
%33 45 119 -25
%33 45 56 -10
%33 45 55 -20
%33 48 15 -20
%33 48 13 -10
%33 48 58 10
%33 48 53 20
%33 48 34 -20
%33 49 15 -50
%33 49 80 -10
%33 49 70 -10
%33 49 13 -40
%33 49 66 -20
%33 49 34 -10
%33 50 54 -10
%33 51 58 10
%33 51 56 10
%33 51 53 20
%33 53 80 -20
%33 53 74 20
%33 53 14 -20
%33 53 73 20
%33 53 70 -20
%33 53 66 -20
%33 53 48 30
%33 53 34 10
%33 55 15 -100
%33 55 80 -20
%33 55 70 -20
%33 55 13 -90
%33 55 66 -20
%33 55 48 10
%33 55 40 -20
%33 56 15 -50
%33 56 80 -20
%33 56 74 10
%33 56 73 10
%33 56 70 -20
%33 56 13 -40
%33 56 66 -20
%33 56 48 10
%33 58 86 -20
%33 58 15 -50
%33 58 80 -50
%33 58 74 10
%33 58 70 -40
%33 58 13 -40
%33 58 66 -60
%33 67 15 -30
%33 67 77 -20
%33 67 13 -20
%33 67 67 -20
%33 68 76 -10
%33 13 8 -70
%33 13 119 -70
%33 69 88 -20
%33 69 87 -10
%33 69 69 -40
%33 70 90 10
%33 71 8 30
%33 71 119 30
%33 71 15 -50
%33 71 71 -50
%33 71 70 -10
%33 71 13 -40
%33 71 66 -20
%33 72 90 10
%33 72 15 -30
%33 72 74 10
%33 72 70 10
%33 72 13 -20
%33 72 66 10
%33 76 90 10
%33 76 80 -10
%33 76 70 -20
%33 78 90 10
%33 78 86 10
%33 79 90 20
%33 80 15 -30
%33 80 13 -20
%33 81 15 -30
%33 81 81 -10
%33 81 13 -20
%33 15 8 -80
%33 15 119 -80
%33 105 65 20
%33 105 34 10
%33 65 65 -115
%33 65 34 10
%33 8 87 30
%33 8 85 20
%33 8 84 -25
%33 8 83 30
%33 8 8 -115
%33 8 119 20
%33 8 77 20
%33 83 15 -50
%33 83 74 10
%33 83 13 -40
%33 84 15 -20
%33 84 13 -10
%33 87 15 -30
%33 87 13 -20
%33 88 15 -30
%33 88 80 10
%33 88 73 20
%33 88 13 -20
%EndKernData
%
%% EncodingOrder:
%%  Symbol
%%  ZapfDingbats
%%  MacEncoding
%%  WindowsLatin1Encoding
%%  ISOLatin1Encoding
%
%BeginEncodings 0 5
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%0 0 0 0 0
%1 1 1 1 1
%2 2 2 2 2
%3 3 3 3 3
%4 4 4 4 4
%5 5 5 5 5
%6 6 6 6 6
%7 7 7 7 7
%8 8 104 104 8
%9 9 9 9 9
%10 10 10 10 10
%11 11 11 11 11
%12 12 12 12 12
%13 13 13 13 13
%14 14 14 14 212
%15 15 15 15 15
%16 16 16 16 16
%17 17 17 17 17
%18 18 18 18 18
%19 19 19 19 19
%20 20 20 20 20
%21 21 21 21 21
%22 22 22 22 22
%23 23 23 23 23
%24 24 24 24 24
%25 25 25 25 25
%26 26 26 26 26
%27 27 27 27 27
%28 28 28 28 28
%29 29 29 29 29
%30 30 30 30 30
%31 31 31 31 31
%32 32 32 32 32
%33 33 33 33 33
%34 34 34 34 34
%35 35 35 35 35
%36 36 36 36 36
%37 37 37 37 37
%38 38 38 38 38
%39 39 39 39 39
%40 40 40 40 40
%41 41 41 41 41
%42 42 42 42 42
%43 43 43 43 43
%44 44 44 44 44
%45 45 45 45 45
%46 46 46 46 46
%47 47 47 47 47
%48 48 48 48 48
%49 49 49 49 49
%50 50 50 50 50
%51 51 51 51 51
%52 52 52 52 52
%53 53 53 53 53
%54 54 54 54 54
%55 55 55 55 55
%56 56 56 56 56
%57 57 57 57 57
%58 58 58 58 58
%59 59 59 59 59
%60 60 60 60 60
%61 61 61 61 61
%62 62 62 62 62
%63 63 63 63 63
%64 64 64 64 64
%65 65 124 124 65
%66 66 66 66 66
%67 67 67 67 67
%68 68 68 68 68
%69 69 69 69 69
%70 70 70 70 70
%71 71 71 71 71
%72 72 72 72 72
%73 73 73 73 73
%74 74 74 74 74
%75 75 75 75 75
%76 76 76 76 76
%77 77 77 77 77
%78 78 78 78 78
%79 79 79 79 79
%80 80 80 80 80
%81 81 81 81 81
%82 82 82 82 82
%83 83 83 83 83
%84 84 84 84 84
%85 85 85 85 85
%86 86 86 86 86
%87 87 87 87 87
%88 88 88 88 88
%89 89 89 89 89
%90 90 90 90 90
%91 91 91 91 91
%92 92 92 92 92
%93 93 93 93 93
%94 94 94 94 94
%95 95 95 95 95
%0 0 0 0 0
%0 193 225 0 0
%0 196 205 0 0
%0 199 185 117 0
%0 198 214 101 0
%0 195 181 118 0
%0 200 186 121 0
%0 192 211 112 0
%0 190 208 113 0
%0 197 176 126 0
%0 189 167 122 0
%0 194 190 187 0
%0 202 153 107 0
%0 191 178 142 0
%0 201 151 0 0
%0 0 160 0 0
%0 0 158 0 0
%0 0 156 0 145
%0 0 169 65 124
%0 0 207 8 125
%0 0 221 105 126
%0 0 154 119 127
%0 0 206 116 128
%0 0 177 111 129
%0 0 219 137 130
%0 0 172 127 131
%0 0 163 171 0
%0 0 218 173 132
%0 0 161 108 0
%0 0 175 148 0
%0 0 170 0 134
%0 0 182 0 135
%0 0 165 193 136
%0 0 112 1 1
%96 96 220 96 96
%97 97 97 97 97
%98 98 98 98 98
%99 99 102 103 103
%100 100 116 100 100
%101 101 115 227 227
%102 102 149 102 102
%103 103 194 131 131
%104 104 216 216 216
%105 105 171 139 139
%106 106 125 106 106
%107 107 131 204 204
%108 108 0 14 14
%109 109 138 194 194
%110 110 141 128 128
%111 111 0 220 220
%112 112 209 209 209
%113 113 0 159 159
%114 114 0 155 155
%115 115 100 125 125
%116 116 222 222 222
%117 117 0 115 115
%118 118 0 114 114
%119 119 0 133 0
%120 120 0 213 213
%121 121 0 143 143
%122 122 139 120 120
%123 123 143 196 196
%124 124 0 228 228
%125 125 144 166 166
%126 126 147 123 123
%127 127 123 217 217
%128 128 96 162 162
%129 129 204 215 215
%130 130 0 201 201
%131 131 101 225 225
%132 132 0 205 205
%133 133 0 138 138
%134 134 106 185 0
%135 135 120 192 192
%136 136 121 214 214
%137 137 1 183 183
%138 138 217 188 188
%139 139 201 189 189
%140 140 195 184 184
%141 141 142 180 180
%142 142 148 174 174
%143 143 111 168 168
%144 144 137 181 181
%145 145 105 191 191
%146 146 119 223 223
%147 147 65 203 203
%148 148 8 195 195
%149 149 200 186 186
%150 150 0 210 210
%151 151 152 141 141
%152 152 193 197 197
%153 153 99 202 202
%154 154 103 198 198
%155 155 107 211 211
%156 156 108 226 226
%157 157 109 199 199
%158 158 110 149 149
%159 159 113 176 176
%160 160 114 208 208
%161 161 117 167 167
%162 162 118 153 153
%163 163 122 190 190
%164 164 215 178 178
%165 165 183 144 144
%166 166 162 151 0
%167 167 188 158 158
%168 168 192 160 160
%169 169 184 156 156
%170 170 180 169 169
%171 171 174 221 221
%172 172 189 207 207
%173 173 223 154 154
%174 174 203 206 206
%189 0 0 224 224
%175 175 191 177 177
%176 176 202 172 172
%177 177 198 219 219
%178 178 197 163 163
%179 179 145 161 161
%180 180 126 218 218
%181 181 127 200 200
%182 182 128 147 147
%183 183 129 170 170
%184 184 130 175 175
%185 185 132 182 182
%186 186 133 165 165
%187 187 134 164 164
%188 188 135 157 157
%0 0 136 152 152
%EndEncodings
%
%BeginVertAlign 35
%1.010 0.689 0.3445 0 -0.293
%0.820 0.706 0.3530 0 -0.143
%0.898 0.676 0.3380 0 -0.218
%0.935 0.692 0.3460 0 -0.218
%0.883 0.668 0.3340 0 -0.217
%0.921 0.685 0.3425 0 -0.218
%0.931 0.737 0.3685 0 -0.225
%0.962 0.737 0.3685 0 -0.228
%0.931 0.737 0.3685 0 -0.225
%0.962 0.737 0.3685 0 -0.228
%0.927 0.709 0.3545 0 -0.283
%0.924 0.695 0.3475 0 -0.266
%0.918 0.706 0.3530 0 -0.276
%0.926 0.695 0.3475 0 -0.271
%0.805 0.580 0.2900 0 -0.157
%0.801 0.582 0.2910 0 -0.206
%0.805 0.580 0.2900 0 -0.157
%0.801 0.582 0.2910 0 -0.206
%0.955 0.753 0.3765 0 -0.222
%1.021 0.755 0.3775 0 -0.251
%0.955 0.753 0.3765 0 -0.222
%1.021 0.755 0.3775 0 -0.251
%0.928 0.698 0.3490 0 -0.251
%0.934 0.698 0.3490 0 -0.243
%0.893 0.698 0.3490 0 -0.222
%0.941 0.698 0.3490 0 -0.220
%0.980 0.737 0.3685 0 -0.215
%1.007 0.737 0.3685 0 -0.221
%0.968 0.737 0.3685 0 -0.227
%0.990 0.737 0.3685 0 -0.220
%0.931 0.737 0.3685 0 -0.225
%0.962 0.737 0.3685 0 -0.228
%0.931 0.737 0.3685 0 -0.225
%0.962 0.737 0.3685 0 -0.228
%0.831 0.723 0.3615 0 -0.314
%EndVertAlign
fclose(fout);

disp(' ## Installing: "stitle.m" (text)')
fout = fopen('stitle.m', 'w');
%function stitle(str,p1,v1,p2,v2,p3,v3,p4,v4,p5,v5,p6,v6,p7,v7,p8,v8)
%%STITLE Styled text plot titles.
%%	STITLE('styled text') adds styled text title at top of plot on the
%%	current axis.
%%	
%%	STITLE('text','Property1',PropertyValue1,'Property2',PropertyValue2,...)
%%	sets the values of the specified properties of the stitle.
%%	
%%	See also TITLE, STEXT, SXLABEL, SYLABEL, SZLABEL, DELSTEXT,
%%	PRINTSTO, SETSTEXT, FIXSTEXT.
%
%%	Requires functions STEXT and DELSTEXT.
%%	Requires MATLAB Version 4.2 or greater.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%if ~rem(nargin,2)
%	error('Incorrect number of input arguments.')
%end
%
%ax = gca;
%
%% Delete any existing title.
%title('')
%stitleH = findobj(ax,'Tag','stext title');
%if ~isempty(stitleH)
%	delstext(stitleH)
%end
%
%if isempty(str), return, end
%
%% Get title characteristics.
%titleH = get(ax,'Title');
%set(titleH,'Units','normalized')
%pos = get(titleH,'Position');
%hor = get(titleH,'HorizontalAlignment');
%ver = get(titleH,'VerticalAlignment');
%
%% Build stext command.
%numPairs = (nargin - 1)/2;
%command = '';
%for i = 1:numPairs
%	command = [command,',p',num2str(i),',v',num2str(i)];
%end
%stitleH = eval(['stext(pos(1),pos(2),str,''Units'',''normalized'',',...
%		'''HorizontalAlignment'',hor,''VerticalAlignment'',ver',...
%		command,')']);
%
%% Set type of styled text object.
%userData = get(stitleH,'UserData');
%userData(1) = 4;
%set(stitleH,'Tag','stext title','UserData',userData)
fclose(fout);

disp(' ## Installing: "stodemo.m" (text)')
fout = fopen('stodemo.m', 'w');
%function stodemo
%%STODEMO Demonstrates some of the capabilities of STEXT.
%%	STODEMO will run the demo.
%%
%%	See also STEXT, SXLABEL, SYLABEL, SZLABEL, STITLE, DELSTEXT,
%%	PRINTSTO, SETSTEXT, FIXSTEXT.
%
%%	Requires functions STEXT, SXLABEL, SYLABEL, STITLE, DELSTEXT.
%%	Requires MATLAB Version 4.2 or greater.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%%begin demo data
%%\14\times Subscripts and superscripts: \Omega_1, s^2.
%%\14\times The font size can be changed: \20M\17ATLAB
%%\14\times Words can be emphasized with {\bold bold} and {\italic italics}.
%%\14 Colors! {\red RED} {\green GREEN} {\blue BLUE} {\cyan CYAN} {\magenta MAGENTA} {\yellow YELLOW}
%%\14 Backslash:\courier  A = B\\C;
%%\14\times Braces: \{\}
%%\14 Here is the Greek alphabet: {\symbol abgdezhqiklmnxoprstufcyw}
%%\14\times{\italic E} \= {\italic mc}^2
%%\18 A more complicated example:  \times{\i y} \= {\i e}^{\-{\i t}_{max}^2}
%%\36\times{\i y} \= \sum{{\i i} \= 1}{{\i N}}{\i x_i}
%%\36\times{\i y} \= \sum{\rdown{.9}\rleft{1.5}{\i i} \= 1}{\rleft{.85}\rup{.7}{\i N}}{\i x_i}
%%end demo data
%
%% Note: The last example above may require some tweaking of the shift
%%       parameters to make it look right on your system.
%
%% Open this file.
%fid = fopen('stodemo.m');
%if fid == -1
%	error('This M-file must be named ''stodemo.m''')
%end
%
%% Clear the current figure and define the axes.
%clf reset
%axis([0 1 0 1])
%set(gca,'Box','on')
%ver5 = cmdmatch(version,'5');
%
%% Skip lines until we find the beginning of the demo data.
%while ~strcmp(fgetl(fid),'%begin demo data'), end
%
%% Read demo data one line at a time, display the raw data and use it
%% in stext.  Do this until the end of the data is read.
%while 1
%	str = fgetl(fid);
%	if strcmp(str,'%end demo data'), break, end
%	str(1) = '';
%	t = text(0.02,0.7,str,'FontName','courier','FontSize',10);
%	if ver5
%		set(t,'Interpreter','none')
%	end
%	h = stext(0.02,0.5,str);
%	pause
%	delstext(h)
%	delete(t)
%end
%
%% Close this file.
%fclose(fid);
%
%% Some more examples of stext.
%stext(0.5,0.95,'\16\times{\ital Left} justified','Horiz','left')
%stext(0.5,0.85,'\16\times{\ital Center} justified','Horiz','center')
%stext(0.5,0.75,'\16\times{\ital Right} justified','Horiz','right')
%line([0.5 0.5],[0 1])
%drawnow
%
%stext(0.1,0.6,'\16\times bottom','Vert','bottom','Horiz','center')
%stext(0.3,0.6,'\16\times baseline','Vert','baseline','Horiz','center')
%stext(0.5,0.6,'\16\times middle','Vert','middle','Horiz','center')
%stext(0.7,0.6,'\16\times cap','Vert','cap','Horiz','center')
%stext(0.9,0.6,'\16\times top','Vert','top','Horiz','center')
%line([0 1],[0.6 0.6])
%drawnow
%
%stext(0.7,0.3,'\12\helv{\bold Left} justified','Horiz','left','Rot',90)
%stext(0.75,0.3,'\12\helv{\bold Center} justified','Horiz','center','Rot',90)
%stext(0.8,0.3,'\12\helv{\bold Right} justified','Horiz','right','Rot',90)
%line([0.5 1],[0.3 0.3])
%drawnow
%
%stext(0.25,0.3,'\14\times   0 {\ital degrees}','Rot',0)
%stext(0.25,0.3,'\14\times   90 {\ital degrees}','Rot',90)
%stext(0.25,0.3,'\14\times   180 {\ital degrees}','Rot',180)
%stext(0.25,0.3,'\14\times   270 {\ital degrees}','Rot',270)
%if ver5
%	line(0.25,0.3,'LineStyle','none','Marker','.','MarkerSize',24)
%else
%	line(0.25,0.3,'LineStyle','.','MarkerSize',24)
%end
%drawnow
%
%sxlabel('\14\times Axis {\ital\red labels} can be styled, too!')
%sylabel('\12\helvetica This label was created with {\courier\blue sylabel}.')
%stitle('\16\helv{\red S}{\green T}{\blue E}{\mag X}{\cyan T} Demo')
fclose(fout);

disp(' ## Installing: "strncmp.m" (text)')
fout = fopen('strncmp.m', 'w');
%function m = strncmp(a,b,n)
%%STRNCMP String comparison.
%%	STRNCMP(A,B,N) returns 1 if strings A and B each have at least
%%	N characters and the first N characters of A and B match, otherwise
%%	it returns 0.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%%	This function is only needed in MATLAB 4 as it is already available
%%	in MATLAB 5 as a built-in function.
%
%if length(a) >= n  &  length(b) >= n
%	m = all( a(1:n) == b(1:n) );
%else
%	m = 0;
%end
fclose(fout);

disp(' ## Installing: "sxlabel.m" (text)')
fout = fopen('sxlabel.m', 'w');
%function sxlabel(str,p1,v1,p2,v2,p3,v3,p4,v4,p5,v5,p6,v6,p7,v7,p8,v8)
%%SXLABEL X-axis styled text labels.
%%	SXLABEL('styled text') adds styled text label near the X-axis on the
%%	current axis.
%%
%%	SXLABEL('text','Property1',PropertyValue1,'Property2',PropertyValue2,...)
%%	sets the values of the specified properties of the sxlabel.
%%
%%	See also XLABEL, STEXT, SYLABEL, SZLABEL, STITLE, DELSTEXT,
%%	PRINTSTO, SETSTEXT, FIXSTEXT.
%
%%	Requires functions STEXT and DELSTEXT.
%%	Requires MATLAB Version 4.2 or greater.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%if ~rem(nargin,2)
%	error('Incorrect number of input arguments.')
%end
%
%ax = gca;
%
%% Delete any existing xlabel.
%xlabel('')
%sxlab = findobj(ax,'Tag','stext xlabel');
%if ~isempty(sxlab)
%	delstext(sxlab)
%end
%
%if isempty(str), return, end
%
%% Get xlabel characteristics.
%xlab = get(ax,'XLabel');
%set(xlab,'Units','normalized')
%pos = get(xlab,'Position');
%hor = get(xlab,'HorizontalAlignment');
%ver = get(xlab,'VerticalAlignment');
%rot = get(xlab,'Rotation');
%
%% Build stext command.
%numPairs = (nargin - 1)/2;
%command = '';
%for i = 1:numPairs
%	command = [command,',p',num2str(i),',v',num2str(i)];
%end
%sxlab = eval(['stext(pos(1),pos(2),str,''Units'',''normalized'',',...
%		'''HorizontalAlignment'',hor,''VerticalAlignment'',ver,',...
%		'''Rotation'',rot',command,')']);
%
%% Set type of styled text object.
%userData = get(sxlab,'UserData');
%userData(1) = 1;
%set(sxlab,'Tag','stext xlabel','UserData',userData)
fclose(fout);

disp(' ## Installing: "sylabel.m" (text)')
fout = fopen('sylabel.m', 'w');
%function sylabel(str,p1,v1,p2,v2,p3,v3,p4,v4,p5,v5,p6,v6,p7,v7,p8,v8)
%%SYLABEL Y-axis styled text labels.
%%	SYLABEL('styled text') adds styled text label near the Y-axis on the
%%	current axis.
%%
%%	SYLABEL('text','Property1',PropertyValue1,'Property2',PropertyValue2,...)
%%	sets the values of the specified properties of the sylabel.
%%
%%	See also YLABEL, STEXT, SXLABEL, SZLABEL, STITLE, DELSTEXT,
%%	PRINTSTO, SETSTEXT, FIXSTEXT.
%
%%	Requires functions STEXT and DELSTEXT.
%%	Requires MATLAB Version 4.2 or greater.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%if ~rem(nargin,2)
%	error('Incorrect number of input arguments.')
%end
%
%ax = gca;
%
%% Delete any existing ylabel.
%ylabel('')
%sylab = findobj(ax,'Tag','stext ylabel');
%if ~isempty(sylab)
%	delstext(sylab)
%end
%
%if isempty(str), return, end
%
%% Get ylabel characteristics.
%ylab = get(ax,'YLabel');
%set(ylab,'Units','normalized')
%pos = get(ylab,'Position');
%hor = get(ylab,'HorizontalAlignment');
%ver = get(ylab,'VerticalAlignment');
%rot = get(ylab,'Rotation');
%
%% Build stext command.
%numPairs = (nargin - 1)/2;
%command = '';
%for i = 1:numPairs
%	command = [command,',p',num2str(i),',v',num2str(i)];
%end
%sylab = eval(['stext(pos(1),pos(2),str,''Units'',''normalized'',',...
%		'''HorizontalAlignment'',hor,''VerticalAlignment'',ver,',...
%		'''Rotation'',rot',command,')']);
%
%% Set type of styled text object.
%userData = get(sylab,'UserData');
%userData(1) = 2;
%set(sylab,'Tag','stext ylabel','UserData',userData)
fclose(fout);

disp(' ## Installing: "szlabel.m" (text)')
fout = fopen('szlabel.m', 'w');
%function szlabel(str,p1,v1,p2,v2,p3,v3,p4,v4,p5,v5,p6,v6,p7,v7,p8,v8)
%%SZLABEL Z-axis styled text labels for 3-D plots.
%%	SZLABEL('styled text') adds styled text label near the Z-axis on the
%%	current axis.
%%
%%	SZLABEL('text','Property1',PropertyValue1,'Property2',PropertyValue2,...)
%%	sets the values of the specified properties of the szlabel.
%%
%%	See also ZLABEL, STEXT, SXLABEL, SYLABEL, STITLE, DELSTEXT,
%%	PRINTSTO, SETSTEXT, FIXSTEXT.
%
%%	Requires functions STEXT and DELSTEXT.
%%	Requires MATLAB Version 4.2 or greater.
%
%%	Version 3.2b, 10 March 1997
%%	Part of the Styled Text Toolbox
%%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%%	schwarz@kodak.com
%
%if ~rem(nargin,2)
%	error('Incorrect number of input arguments.')
%end
%
%ax = gca;
%
%% Delete any existing zlabel.
%zlabel('')
%szlab = findobj(ax,'Tag','stext zlabel');
%if ~isempty(szlab)
%	delstext(szlab)
%end
%
%if isempty(str), return, end
%
%% Get zlabel characteristics.
%zlab = get(ax,'ZLabel');
%set(zlab,'Units','normalized')
%pos = get(zlab,'Position');
%hor = get(zlab,'HorizontalAlignment');
%ver = get(zlab,'VerticalAlignment');
%rot = get(zlab,'Rotation');
%
%% Build stext command.
%numPairs = (nargin - 1)/2;
%command = '';
%for i = 1:numPairs
%	command = [command,',p',num2str(i),',v',num2str(i)];
%end
%szlab = eval(['stext(pos(1),pos(2),str,''Units'',''normalized'',',...
%		'''HorizontalAlignment'',hor,''VerticalAlignment'',ver,',...
%		'''Rotation'',rot',command,')']);
%
%% Set type of styled text object.
%userData = get(szlab,'UserData');
%userData(1) = 3;
%set(szlab,'Tag','stext zlabel','UserData',userData)
fclose(fout);
cd ('..')
