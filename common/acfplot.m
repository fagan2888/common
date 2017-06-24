function acfplot(acf,n,type)
% ACFPLOT2(ACF,N,TYPE) produces Splus-style plot of
% ACF if TYPE = 1 and PACF if TYPE = 2,
% complete with white noise bars based on sample size N.
% Input ACF must be a column vector
w=2/sqrt(n);
if type == 1
   na=length(acf)-1;
   plot(0:na,acf,'o')
   hold on
   plot([0 na] , [0 0], 'r')
   plot([0 na] , [w w], 'c--')
   plot([0 na] , [-w -w], 'c--')
   for i=0:na
      plot([i i],[0 acf(i+1)])
   end
   xlabel('Lag')
   ylabel('ACF')
   hold off
end
if type == 2
   na=length(acf);
   plot(1:na,acf,'o')
   hold on
   plot([0 na] , [0 0], 'r')
   plot([1 na] , [w w], 'c--')
   plot([1 na] , [-w -w], 'c--')
   for i=1:na
      plot([i i],[0 acf(i)])
   end
   xlabel('Lag')
   ylabel('PACF')
   hold off
end


