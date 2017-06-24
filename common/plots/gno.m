function Handle=gno();
%--------------------------------------------------------------------
% gno function        get handle for neastest object.
%                   Click right mouse button to collect
%                   handle into vector of handles.
%                   left mouse botton to exit.
% Output : - vector of all objects handle.
% Tested : Matlab 5.2
%     By : Eran O. Ofek           October 1999
%    URL : http://wise-obs.tau.ac.il/~eran/matlab.html
%--------------------------------------------------------------------

Index = 0;
Button = 3;
while (Button~=1),
   [X,Y,Button] = ginput(1);
   if (Button==3),
      Index = Index + 1;
      % search nearest object.
      H_a = gca;
      Children = get(H_a,'Children');
      Dist = zeros(size(Children));
      Xpos = zeros(size(Children));
      Ypos = zeros(size(Children));
      for I=1:1:length(Children),
         Type = get(Children(I),'Type');
         if (Type=='line'),
            Xpos(I) = get(Children(I),'XData');
            Ypos(I) = get(Children(I),'YData');
         elseif (Type=='text'),
            Pos = get(Children(I),'Position');
            Xpos(I) = Pos(1);
            Ypos(I) = Pos(2);
         else
            error('Unknown Type');
         end
      end
      Dist = sqrt((X-Xpos).^2 + (Y-Ypos).^2);
      [MinDist,MinDistIndex] = min(Dist);
      Type = get(Children(MinDistIndex),'Type');
      Handle(Index) = Children(MinDistIndex);
   end
end
      

