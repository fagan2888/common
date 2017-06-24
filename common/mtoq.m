function qdata= mtoq(mdata,caldsm,caldsq,imeth);

% -- Converts monthly observations to quarterly observations --
%      
%      mdata == monthly data series
%      caldsm == Tx2 vector of dates (yr,mth) for monthly obs
%      caldsq == Nx2 vector of dates (Yr,qtr) for quarterly obs
%
%      imeth == 0  Average over quarter
%               1  First Month of Quarter
%               2  Second Month of Quarter
%               3  Third month of Quarter


qdata=zeros(rows(caldsq),1);

% -- Check to make sure that mdata has correct number of observations -- %
if rows(mdata) ~= rows(caldsm);
 error('Error in Procedure MTOQ -- wrong number of elements in mdata');
 disp(sprintf('Rows of Mdata',rows(mdata)));
 disp(sprintf('Rows of Caldsm',rows(caldsm)));
 return;
end;

% -- Check to make imeth is in the correct bounds -- %
if imeth > 3;
 error('Error in Procedure MTOQ -- Invalid Value for Imeth');
 disp(sprintf('meth',imeth));
 return;
end;


temp=mdata;

if imeth == 0; % Form averages %
 temp=zeros(rows(mdata),1);
 for i=3:rows(mdata);
  temp(i,1)=mean(mdata(i-2:i,1));
 end; 
 imeth=3;
end;



for i =1:rows(caldsq);
 iy=caldsq(i,1); % Year %
 iq=caldsq(i,2); % Quarter %
 im=(3*(iq-1)) + imeth;    % Month to use %
 itemp=(caldsm(:,1) == iy) .* (caldsm(:,2) == im);
 a=find(itemp==1);
 qdata(i,1)=temp(a);
end;



