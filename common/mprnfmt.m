function mfprnfmt(fp,dum,fmt);
for i=1:size(dum);
fprintf(fp,fmt,dum(i,:));
fprintf(fp,'\n');
end;
