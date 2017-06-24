function displaymatrix(A,d1,d2);
fmt=['%' num2str(d1) '.' num2str(d2) 'f & '];
fmt1=[repmat(fmt,1,cols(A)) '\\\\ \n'];
for k=1:length(A)
    fprintf(fmt1, A(k,:))
end