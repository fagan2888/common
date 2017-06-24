function mfprintf(fp,dum);
for i=1:size(dum);
fprintf(fp,'%7.4f ',dum(i,:));
fprintf(fp,'\n');
end;
%fprintf(fp,'\n');
