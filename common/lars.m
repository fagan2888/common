function [bstar,loc,BIC,pos]=lars(y,x);

% X is standardized and Y is demeaned
   Y=demean(y);
 X=standard(x);
  
  
[T,N]=size(X);
N1=ceil(sqrt(N));
betamat=zeros(N,N);
fit=zeros(rows(Y),1); k=1; pos=[]; s_j=[];done=0; 
X_k=[]; one=[];drop=[]; keep=X; 
NN=(1:1:N)';A =[]; 
A_c=NN;
while   k < N ;
chat=X'*(Y-fit);
chat_Ac=chat(A_c);
[C,t2]=max(abs(chat_Ac));
j=A_c(t2);
A_c(t2)=[];
A=[A ;j];
%dummy=find(abs(abs(chat)-C) < 1e-4);


s_j=sign(chat_Ac(t2));
 X_k= [X_k  s_j*X(:,j)]; one=[one ;1];    
G_k=X_k'*X_k;
A_k=1/sqrt((one'*inv(G_k)*one));
w_k=A_k*inv(G_k)*one;
u_k=X_k*w_k;
a=X'*u_k;


if rows(A_c) > 1;
  temp1= (C-chat(A_c))./(A_k-a(A_c));
  temp2= (C+chat(A_c))./(A_k+a(A_c));
%temp=max([ temp1  temp2  zeros(rows(temp1),1)]')';
GAM=[temp1  ;temp2; C/A_k];
%GAM=min(temp)';
gam=min(GAM(GAM > 0));
newfit=fit+gam*u_k;
fit=newfit;
else;
gam=1;
pos=[A ;A_c];
end;
k=k+1;
end; % end done



reg=X(:,pos');bic=zeros(N,1);

for i=1:N;
beta=reg(:,1:i)\Y;
e=Y-reg(:,1:i)*beta;
bic(i)=log(e'*e/T)+ i*log(T)/T;
end;


BIC=bic;
[a,b]=min(bic);
beta=reg(:,1:b)\Y;
e=Y-reg(:,1:b)*beta;
bic=log(e'*e/T)+b*log(T)/T;


bstar=zeros(N,1);
loc=zeros(1,N);
bstar(pos(1:b))=beta;
loc(pos(1:b))=1;




