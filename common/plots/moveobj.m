function Children=moveobj(Size,Rotation);
%--------------------------------------------------------------------
% moveobj function        move nearest object to new location
%                       (and properties) using the mouse.
%                       Use right botton to mark nearest object.
%                       Left botton to set object to new location.
%                       (second left click to exit).
% Input  : - set size of font/marker to new size.
%            (default for marker is 6, for font is 10).
%            In case size is a vector, the first cell is taken
%            as the MarkerSize and the second as the FontSize.
%          - Set rotation of text to new rotation.
%            (default is 0).
% Output : - vector of all objects handle.
% Tested : Matlab 5.2
%     By : Eran O. Ofek           October 1999
%    URL : http://wise-obs.tau.ac.il/~eran/matlab.html
%--------------------------------------------------------------------
if (nargin==0),
   MarkerSize = 6;
   FontSize   = 10;
   Rotation   = 0;
elseif (nargin==1),
   Rotation   = 0;
elseif (nargin==2),
   if (length(Size)==1),
      MarkerSize = Size;
      FontSize   = Size;
   else
      MarkerSize = Size(1);
      FontSize   = Size(2);
   end      
else
   error('Illigal number of input arguments');
end

LeftClickNo = 0;
while (LeftClickNo<2),
   [X,Y,Button] = ginput(1);
   if (Button==3),
      LeftClickNo = 0;
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
   elseif (Button==1),
      LeftClickNo = LeftClickNo + 1;
      if (LeftClickNo==1),
         if (Type=='line'),
            set(Children(MinDistIndex),'XData',X,'YData',Y,'MarkerSize',MarkerSize);
         elseif (Type=='text'),
            set(Children(MinDistIndex),'Position',[X,Y],'FontSize',FontSize,'Rotation',Rotation);
         else
            error('Unknown Type');
         end
      end
   else
      % do nothing
   end
end
      

