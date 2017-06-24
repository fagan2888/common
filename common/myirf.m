function [out1,out2,outdata1,outdata2,PHI]=myirf(results,S,odum,Vnames)
% PURPOSE: Calculates Impulse Response Function for VAR
%-------------------------------------------------------------
% USAGE: irf(results,S,odum)   
%  results structure returned by VARE
%  S       scalar for number of periods in IRF
%  odum    dummy variable for type of cov factorizations
%            'o1' is a Cholesky decomp for orthog IRF
%            'o2' is a triangular factorization, orthog IRF
%             anything else is a non-orthogonalized IRF
%  Vnames  variable names, 1 per row (optional)
%-------------------------------------------------------------
% RETURNS: two matrices of outputs, both (N*S x 2N+2) with
%      [S eq_n {psi_i} {irf_i} ] on each line. i = {1,...,N}
%    out1  is sorted by S then eq.
%    out2  is sorted by eq then S.  Used to plot IRF.
%    The psi and irf terms are the impact of shocks to the 
%    i-th equation on the n-th equation
% outdata1 is response of one variable to all shocks
% outdata2 is response of all variables to one shock
% ------------------------------------------------------------
% SEE ALSO: VARE
%-------------------------------------------------------------
% REFERENCES: Hamilton, Time Series Analysis (1994)
%-------------------------------------------------------------

% written by: Mike Cliff, UNC Finance  mcliff@unc.edu
% CREATED:  12/08/98
% MODIFIED: 12/18/98
  
% LeSage fixed the legend and plotting

%============================================================
%    SET UP PARMS AND CALC ERROR COV MATRIX
%============================================================


if isstruct(results)
 N = results(1).neqs;
  p = results(1).nlag;
  PHI = zeros(N*p,N);
  se=[];
 for i=1:N;
  err=results(i).resid;
  se=[se; std(err)];
end;

  for i = 1:N
    err(:,i) = results(i).resid;
    for j = 1:N
      temp(:,j) = results(i).beta((j-1)*p+1:j*p);      
    end
    for k = 1:p
      PHI((k-1)*N+i,:) = temp(k,:);
    end  
  end
  omega = err'*err/rows(err);
else
  error('YOU MUST INPUT A VAR RESULTS STRUCTURE')
end


%=============================================================
%  INITIALIZE NAMES, P MATRIX, PHI & PSI
%=============================================================

% ----If no variable names supplied --------------------------
if nargin  == 3 
  Vnames = [];  
  for i=1:N
    Vnames = strvcat(Vnames,['Y' int2str(i)]);
  end
end


% ---- Determine decomposition of Cov matrix -----------------

    if odum==1;
    msg=('Orthog. IRF: 1 \sigma changes');
    P=chol(omega)';     
    end;
    if odum==2;     % triangular fact. omega = A*D*A'
    msg=('Orthog. IRF: 1 unit changes');
    Dsr = diag(sqrt(diag(omega)));
    P=chol(omega)'*inv(Dsr);
  end
if odum > 2;
  msg=('Unorthog. IRF: 1 unit changes');
  P = eye(N);
end


% ---- Rearrange PHI: Need 'block' transpose ----------------------
for i = 1:p  
  PHI2(N*(p-i)+1:N*(p-i+1),:) = PHI((i-1)*N+1:i*N,:)';
end

% ---- Initialize PSI: p blocks to start + S blocks to add --------
% ----   first p blocks are p-1 zeros and one I. (p+S)*n x n ------
PSI = [zeros(N*(p-1),N);eye(N);zeros(N*S,N)];
IRF = zeros(S*N,N);

for s = 1:S
  i = s+p;
  PSI2=PSI((i-p-1)*N+1:(i-1)*N,:);
  psi = PHI2'*PSI2;
  PSI((i-1)*N+1:i*N,:) = psi;
  IRF((s-1)*N+1:N*s,:) = psi*P;
end


indx=[kron([1:S]',ones(N,1)) kron(ones(S,1),[1:N]')];
out1 = [indx PSI(p*N+1:(S+p)*N,:) IRF];
out2=sortrows(out1,[2 1]);

%============================================================
%  NOW DRAW SOME GRAPHS
% showing response of equation n to shocks to each variable in turn
i = 0;
x=[1:S]';
plotct = 0;     

do_plot=0;
outdata1=[];
outdata2=[];

for i=1:N;
    plotct = plotct + 1;
    plotdata1 = out1(find(out1(:,2)==plotct),3+N:cols(out1));
    outdata1{plotct}=[P(i,:); plotdata1];
    if do_plot==1;    
    plot(x,plotdata1);
    title(msg)
    ylabel(Vnames(plotct,:));
    xlabel(['Response of all variables to shock in equation ' num2str(plotct)]);    
    legend(Vnames,-1);
end;
    if plotct == N, break,  end
end

res=[];
    temp=[];
    for j=1:N;
    temp=[temp outdata1{j}];  
    res=[res results(j).resid];
    end;
    
    vcv=chol(res'*res/rows(res));
% outdata 2{j} are the responses to shock j
outdata2=[];
list=1:N:N^2-N+1;
pick=list;
 for i=1:N;
%  outdata2{i}=[vcv(i,:); temp(:,pick)];
%   outdata2{i}=[P(:,i)'; temp(:,pick)];
    outdata2{i}=temp(:,pick);
       pick=i+list;
end;

