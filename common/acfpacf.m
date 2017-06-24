function [ac,pac]=acfpacf(x,nac,npac,plfg,acalpha,pacalpha,descriptor)
%
%   [ac,pac]=acfpacf(x,nac,npac,plfg,acalpha,pacalpha,descriptor)
%
% x = data vector (column)
% nac = no. acf values to return (<= length(x))
% npac = no. pacf values to return (<=length(x))
% plfg >0 to plot
% acalpha = alpha for acf plot
% pacalpha alpha for pacf plot
% descriptor for plots

if nargin == 3
    plfg=0;acalpha=.1;pacalpha=.1;descriptor='';
end
nx=length(x);
if nac <1 | npac < 1
    error('nac or npac must be positive');
end
if nac > nx
    nac = nx;
end
if npac > nx
    npac=nx;
end
ac=acf(x,3);       % "3" to normalize by sample variance and N-k
pac=pacf(x,npac,0); % 0 for no plot by pacf, compute npac values


%figure;
if plfg
    subplot(211);
    
    ac=ac(1:nac);   % take only the first half
    stem(ac,'.');	        % a stem plot with dot marker
    hold on;
    plot(zeros(1,nac));    % makes a line at y=0
    thr=norminv(1-acalpha/2,0,1/sqrt(nx));
    thrmh=norminv(1-(acalpha/2)/nac,0,1/sqrt(nx));
    plot([1:nac],thr*ones(1,nac),'--r',[1:nac],-thr*ones(1,nac),'--r');
    plot([1:nac],thrmh*ones(1,nac),'--m',[1:nac],-thrmh*ones(1,nac),'--m');
    title([descriptor,' acf  n= ',int2str(nx),' alpha = ',num2str(acalpha)]);
    hold off;
    % the pacf
    subplot(212);
    
    npac=length(pac);
    stem(pac,'.');	        % a stem plot with dot marker
    hold on;
    plot(zeros(1,npac));    % makes a line at y=0
    thr=norminv(1-pacalpha/2,0,1/sqrt(nx));
    thrmh=norminv(1-(acalpha/2)/npac,0,1/sqrt(nx));
    plot([1:npac],thr*ones(1,npac),'--r',[1:npac],-thr*ones(1,npac),'--r');
    plot([1:npac],thrmh*ones(1,npac),'--m',[1:npac],-thrmh*ones(1,npac),'--m');
    title([descriptor,' pacf  n= ',int2str(nx),' alpha = ',num2str(pacalpha)]);
    hold off;
end