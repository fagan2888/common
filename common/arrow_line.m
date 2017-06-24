function arrow_plot(abt,abh,encoding,mapname,headsize)
% arrow_plot: plots arrows with heads for set of points
% usage: arrow_plot(tails,heads,[encoding],[mapname],[headsize])
%
% arguments:
%  tails,heads - (2xn) - arrays of points corresponding
%         to the heads and tails of the arrows to be
%         plotted. Green arrow heads to be drawn at
%         the head of the arrows. Arrows themselves
%         will be in red.
%  encoding (optional) - n vector - allows for color encoding
%    of individual arrows.  Encoding is assumed to be a vector
%    with elements in the range [0,1]
%  mapname (optional) - name of colormap to be used (default is 'jet')
%  headsize (optional) - scalar - relative length of arrow heads to the
%    arrow length (default headsize = 0.2)
%

% subordinate functions: none
%
% author: John R. D'Errico

% save hold on/off state of plot (1 --> was on)
h=ishold;

if (nargin<5)
  headsize=0.2;
end

axis('equal')
[rt,ct]=size(abt);
[rh,n]=size(abh);
if (ct~=n)
  error('must have same number of points in each set')
end
if (rt~=2)|(rh~=2)
  error('arrow_plot requires 2xn arrays')
end

% form vector from tail to head of arrow
h_t=abh-abt;

% the cross product with this vector and a unit vector
% orthogonal to the plane yields a new vector in the plane
% but orthogonal to the head to tail vector.
c=[1 0 0]';
c=cross(c(:,ones(1,n)),[zeros(1,n);h_t]);
c=c(2:3,:);   % strips off the out of plane part

% take an appropriate linear combination with the
% h_t vector to get the arrow heads.
c1=abh+(c/3-h_t)*headsize;
c2=abh+(-c/3-h_t)*headsize;

if (nargin<3)

% plot body of arrow in red
  a=[abh(1,:);abt(1,:)];
  b=[abh(2,:);abt(2,:)];
  plot(a,b,'r-')

% plot heads in green
  hold on
  a=[c1(1,:);abh(1,:);c2(1,:)];
  b=[c1(2,:);abh(2,:);c2(2,:)];
  plot(a,b,'g-')
  hold off
else
  if nargin<4
    mapname=[];
  end
  if isempty(mapname)
    mapname='jet';
  end
  colormap(mapname)
  map=colormap;
  encoding=encoding(:);
  encoding=1+encoding.*(size(map,1)-1);
  encoding=round(encoding);
  hold off
  for i=1:n
    a=[abt(1,i),c1(1,i),c2(1,i);abh(1,i)*ones(1,3)];
    b=[abt(2,i),c1(2,i),c2(2,i);abh(2,i)*ones(1,3)];
    plot(a,b,'color',map(encoding(i),:))
    if i==1
      hold on
    end
  end
  hold off
end

% restore hold state of plot to prior value
if h
  hold on
else
  hold off
end 