% scales a variable from [xmin, xmax] to [ymin,ymax];

function y = scaledn(x,xmin,xmax,ymin,ymax);

[r,c]=size(x);
Ymax=repmat(ymax,r,c);
D=repmat((ymax-ymin)/(xmax-xmin),r,c);
denom=repmat(xmax-xmin,r,c);
num=x-repmat(xmax,r,c);

y =Ymax+D.*num;

