function m = cmdmatch(a,b)
%CMDMATCH String matching.
%	CMDMATCH(A,B) returns 1 if B matches the first length(B) characters
%	of A and 0 otherwise.

%	Version 3.2b, 10 March 1997
%	Part of the Styled Text Toolbox
%	Copyright 1995-1997 by Douglas M. Schwarz.  All rights reserved.
%	schwarz@kodak.com

nb = length(b);

if length(a) >= nb
	m = all(a(1:nb) == b);
else
	m = 0;
end
