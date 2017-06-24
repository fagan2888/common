function stfixps(filename)
%STFIXPS Modifies MATLAB PostScript files to produce Symbol-Oblique.
%	STFIXPS(PSFILE) takes a MATLAB PostScript file containing Styled
%	Text Objects with italic or oblique Symbol characters and modifies
%	it so that the Symbol characters are slanted.
%
%	See also STFIXPS, STEXT, PRINTSTO.

%	Version 3.2b, 10 March 1997
%	Part of the Styled Text Toolbox
%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%	schwarz@kodak.com

% Define slant angle.  12 degrees matches slant of Times-Italic.
slantAngle = 12*pi/180;
mtx = sprintf('[1 0 %.6f -1 0 0]',tan(slantAngle));
wtfmt = ['/Symbol findfont %d scalefont ',mtx,' makefont setfont'];
rdfmt = '/Symbol /%*s %d';

comp = computer;
if cmdmatch(comp,'PC') | cmdmatch(comp,'VAX')
	fid = fopen(filename,'rt+');
else
	fid = fopen(filename,'r+');
end

% Determine end-of-line sequence.
line = fgets(fid);
eol = line(find(line == 10 | line == 13));
neol = length(eol);

last1changed = 0;
pos = 0;
space = ' ';
while isstr(line)
	if strncmp(line,'/Symbol /',9)
		lastsympos = pos;
		beginsave = ftell(fid);
		fs = sscanf(line,rdfmt);
	elseif strncmp(line,'(\11) s',7)
		len = length(lastline);
		if len >= 16
			substr = lastline(len-5-neol:len);
			if strncmp(substr,'rotate',6)
				n = 7;
			else
				n = 4;
			end
		else
			n = 4;
		end
		for i = 1:n, fgets(fid); end
		newpos = ftell(fid);
		if lastsympos ~= last1changed
			newsym = sprintf([wtfmt,eol],fs);
			fseek(fid,beginsave,'bof');
			saved = fread(fid,[1,lastpos - beginsave],'char');
			numSpaces = (newpos - lastsympos) ...
					- (length(newsym) + lastpos - beginsave) - neol;
			spaces = space(ones(1,numSpaces));
			newblock = [newsym,saved,spaces,eol];
			fseek(fid,lastsympos,'bof');
			last1changed = lastsympos;
		else
			spaces = space(ones(1,newpos - lastpos - neol));
			newblock = [spaces,eol];
			fseek(fid,lastpos,'bof');
		end
		fwrite(fid,newblock,'char');
		fseek(fid,newpos,'bof');
	end
	lastline = line;
	lastpos = pos;
	pos = ftell(fid);
	line = fgets(fid);
end
fclose(fid);
