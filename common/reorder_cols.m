function Y=switch_cols(X,id);
%id1=id ; id2=flipud(id')';
Z=X;
Z(:,id)=[];
Y=X(:,id);
Y=[Y Z];

