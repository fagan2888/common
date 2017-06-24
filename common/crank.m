function r=crank(x)
%Syntax: r=crank(x)
%__________________
%
% Assigns ranks on a data series x. 
%
% r is the vector of the ranks
% x is the data series. It must be sorted.
%
%
% Reference:
% Press W. H., Teukolsky S. A., Vetterling W. T., Flannery B. P.(1996):
% Numerical Recipes in C, Cambridge University Press. Page 642.
%
%
% Alexandros Leontitsis
% Department of Education
% University of Ioannina
% 45110- Dourouti
% Ioannina
% Greece
% 
% University e-mail: me00743@cc.uoi.gr
% Lifetime e-mail: leoaleq@yahoo.com
% Homepage: http://www.geocities.com/CapeCanaveral/Lab/1421
% 
% 3 Feb 2002.

x(end+1)=max(x)+1;

for i=1:size(x,2)
    
    [x(:,i),z1]=sort(x(:,i));
    [z1,z2]=sort(z1);
    
    if var(x(:,i))==0
        r=1:size(x,1);
        return
    end
    
    j=1;
    while j<size(x,1)
        
        if x(j+1)>x(j)
            
            r(j)=j;
            
        else
            
            jt=0;
            while x(j+1)==x(j)
                
                jt=jt+1;
                j=j+1;
            end
            
            r1=mean(j-jt:j);
            
            r(j-jt:j)=r1;
        end
        
        j=j+1;
        
    end
    
    if j==size(x,1)
        
        r(size(x,1))=size(x,1);
        
    end
    
    
end

r=r(z2);
r(find(r==max(r)))=[];
