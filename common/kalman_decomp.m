function [F,G,H]=kalman_decomp(A,B,C);
dim_A = max(size(A));
CC = ctrb(A,B);  % calculate controllability matrix
OO = obsv(A,C);  % calculate observability matrix

V = orth(CC);  % find basis for controllable subspace
W = null(OO);  % find basis for unobservable subspace

dim_c = min(size(V)); % compute dimension of contr. subspace
dim_no = min(size(W)); % compute dimension of unobs. subspace

U = V*[eye(dim_c) zeros(dim_c,dim_no)]*null([V W]);
     % find a basis for the intersection of the two subspaces
     % extra credit: explain why this works!!!
     
dim_c_int_no = min(size(U)); % compute dimension of the intersection of the two subspaces
% Form P 
P = [ V(:,1:(dim_c-dim_c_int_no)) ...
      U(:,1:dim_c_int_no) ... 
      randn(dim_A,dim_A-dim_c-dim_no+dim_c_int_no) ... 
      W(:,dim_c_int_no+1:dim_no) ]
F = P\A*P G = P\B H = C*P
