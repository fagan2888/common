function mfprintf3(fp,dum);
for i=1:size(dum);
fprintf(fp,'%7.3f ',dum(i,:));
fprintf(fp,'\n');
end;
