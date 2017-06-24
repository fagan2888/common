function Out=mprint1(x,info,fid)
%---------------------------------------------------------------
% PURPOSE: Pretty-prints a matrix
%---------------------------------------------------------------
% USAGE: Out = mprint1(x,info,fid)
%
%  x         data
%  info      structure variable (all optional)       [default]
%   .fmt     format string for matrix                ['%8.4f']
%   .vspc    number of blank lines between blocks    [1]
%   .hspc    spacing between colums                  [3]
%   .ldum    set to 1 for LaTeX version              [0]
%   .rnames  k-vector of row names                   (optional)
%             can incl. col heading if using cnames
%   .cnames  k-vector of column names                (optional)
%   .swidth  width of the display                    [80]
%  fid       set to 0 to suppress display results    [1]
%              1 is screen, higher is fid
%---------------------------------------------------------------

% Written by  Mike Cliff,  UNC Finance   mcliff@unc.edu
% CREATED  12/15/98
% UPDATED 10/27/99 (minor: 1st elmt of rnames optional)

%======================================================================
%  INITIALIZATIONS
%======================================================================

if nargin == 1,  info.null = 1; end
if nargin < 3, fid = 1; end 

[R,C] = size(x);
if ~isfield(info,'vspc'), info.vspc = 0; end
if ~isfield(info,'hspc'), info.hspc = 3; end
if ~isfield(info,'ldum'), info.ldum = 0; end
if ~isfield(info,'swidth'), info.swidth = 80; end

if ~isfield(info,'fmt'), info.fmt = '%7.4f'; end
if rows(info.fmt) == 1, info.fmt = repmat(info.fmt,C,1); end


if isfield(info,'cnames'), cdum = 1; 
else cdum =0; end
if isfield(info,'rnames'), rdum = 1; 
else rdum =0; info.rnames = []; end

if (cdum == 1 & rdum == 1)
  if rows(info.rnames) == R
    info.rnames = strvcat(' ',info.rnames);
  end
end

ldum = info.ldum;
if ldum == 1
  amp = repmat(' & ',R*(1 + info.vspc)-info.vspc+cdum,1);
  eol = repmat(' \\',R*(1 + info.vspc)-info.vspc+cdum,1);
else
  amp = repmat(' ',R*(1 + info.vspc)-info.vspc+cdum,info.hspc);
  eol = repmat(' ',R*(1 + info.vspc)-info.vspc+cdum,1);  
end

out = repmat(' ',R*(1 + info.vspc)-info.vspc+cdum,1);
Out = out;

%======================================================================
%  BUILD UP OUTPUT
%======================================================================

for c = 1:C  
  temp = num2str(x(:,c),info.fmt(c,:));
  if cdum == 1, temp = strvcat(deblank(info.cnames(c,:)),temp); end
  temp = strjust(temp);
  Out = [Out amp temp];  
  if cols([info.rnames out amp temp]) > info.swidth
    if fid > 0
      prtout = [info.rnames out];
      if ldum == 0
        for r = 1:rows(out)
          fprintf(fid,'%s\n',prtout(r,:));
        end
        fprintf(fid,' \n');
      end
      if c == C
        prtout = [info.rnames amp temp];
        if ldum == 0
          for r = 1:rows(out)
            fprintf(fid,'%s\n',prtout(r,:));
          end
          fprintf(fid,' \n');
        end
      end
    end
    out = [amp temp];
  else
    out = [out amp temp];
    if c == C
      if fid > 0
        prtout = [info.rnames out];
        if ldum == 0
          for r = 1:rows(out)
            fprintf(fid,'%s\n',prtout(r,:));
          end
          fprintf(fid,' \n');
        end
      end
    end
  end
end

Out = [info.rnames Out eol];
if ldum == 1
  for r = 1:rows(Out)
    fprintf(fid,'%s\n',Out(r,:));
  end
end
