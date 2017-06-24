function [c,d]=findmaxpos(A);
b=max(A(:));
[c,d]=ind2sub(size(A),find(A==b));