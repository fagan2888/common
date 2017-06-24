function b = olssvd(y,ly);

% **********************************************************************************
%                               OLS ESTIMATOR (SVD)
% **********************************************************************************
% FUNCTION: olssvd.m 
%           Computes the OLS estimator (Handles system of equations) using
%           singular value decomposition
%
% REQUIRES: - Inputs: y  = T x k matrix      -- LHS of the VAR
%                     ly = T x k*p+1 matrix  -- constant + lags of y
%
% Program by Jean Boivin and Marc Giannoni
% Program may be used provided that full credit is given to the source
% Created 11/08/01
% **********************************************************************************

[vl,d,vr] = svd(ly,0);

d = 1./diag(d);
b = (vr.*repmat(d',size(vr,1),1))*(vl'*y);