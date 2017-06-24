function Y=switch_rows(X,id);
id=id';
Z=X;
Z(id,:)=[];
Y=[X(id,:); Z];


