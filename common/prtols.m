% print ols results

function prtols(results,fp,series);
nvar=rows(results.beta);
if cols(fp)==0;
disp(sprintf('\n      Rbar-sq %7.3f DW %7.3f T %3d',results.rbar,results.dw,results.nobs));
if cols(series) ==0;
disp(sprintf('\n              beta     t-stat'));
mymprint([(1:1:nvar)' results.beta results.tstat]);
else;
disp(sprintf(' Variable         beta      t-stat'));  
fmt=[' %s' repmat('%7.3f   ',1,nvar)];
for i=1:rows(results.beta);
disp(sprintf(fmt,series(i,:),results.beta(i), results.tstat(i)));
end;  % end i  
end;  % end if series
end;  % end if cols(fp);



if cols(fp) >0;
fprintf(fp,'\n Rbar-sq %7.3f DW %7.3f T %3d\n',results.rbar,results.dw,results.nobs);

if cols(series)==0;
fprintf(fp,'    beta     t-stat\n');
in.fid=fp;
fmt='%7.3f ';
in.fmt=fmt;
mymprint([results.beta results.tstat],in);
else;
fprintf(fp,' Variable         beta      t-stat');  
fmt=['\n %s' repmat('%7.3f   ',1,nvar)];
for i=1:rows(results.beta);
fprintf(fp,fmt,series(i,:),results.beta(i), results.tstat(i));
end;  % end i  
end;  % end if series

end;

