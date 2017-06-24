function [fh,xh,gh,H,itct,fcount,retcodeh] = csminwel(fcn,x0,H0,grad,crit,nit, ...
             P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16,P17,...
             P18,P19,P20)
% [fhat,xhat,ghat,Hhat,itct,fcount,retcodehat] = csminwel(fcn,x0,H0,grad,crit,nit, ...
%                                                   P1,P2,P3,P4)
%
% x0(estimated parameter)
%
% fcn and grad are strings naming functions.  If grad is null, numerical
% derivatives are used.  The P parameters need not be present.  They are passed
% to fcn as additional arguments.
%
% Reindented and modified to allow compilation (comment out use of tailstr, eval) by CAS,
% 7/22/96
%
[nx,no]=size(x0);
nx=max(nx,no);
Verbose=1;
NumGrad= ( ~isstr(grad) | length(grad)==0);
done=0;
itct=0;
fcount=0;
snit=100;
tailstr = ')';
stailstr = [];
% Lines below make the number of Pi's optional.  This is inefficient, though, and precludes
% use of the matlab compiler.  Without them, we use feval and the number of Pi's must be
% changed with the editor for each application.  Places where this is required are marked
% with ARGLIST comments
for i=nargin-6:-1:1
   tailstr=[ ',P' num2str(i)  tailstr];
   stailstr=[' P' num2str(i) stailstr];
end
f0 = eval([fcn '(x0' tailstr]);
%ARGLIST
%f0 = feval(fcn,x0,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13);
% disp('first fcn in csminwel.m ----------------') % Jinill on 9/5/95
if f0 > 1e50, disp('Bad initial parameter.'), return, end
if NumGrad
   if length(grad)==0
      [g badg] = eval(['numgrad(fcn, x0' tailstr]);
      %ARGLIST
      %[g badg] = numgrad(fcn,x0,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13);
   else
      badg=any(find(grad==0));
      g=grad;
   end
   %numgrad(fcn,x0,P1,P2,P3,P4);
else
   [g badg] = eval([grad '(x0' tailstr]);
   %ARGLIST
   %[g badg] = feval(grad,x0,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13);
end
retcode3=101;
x=x0;
f=f0;
H=H0;
cliff=0;
while ~done
   g1=[]; g2=[]; g3=[];
   %addition fj. 7/6/94 for control
   disp('-----------------')
   disp('-----------------')
   %disp('f and x at the beginning of new iteration')
   disp(sprintf('f at the beginning of new iteration, %20.10f',f))
   %if size(x,1)>size(x,2)
   %   x'
   %else
   %   x
   %end
   %-------------------------
   itct=itct+1;
   [f1 x1 fc retcode1] = eval(['csminit(fcn,x,f,g,badg,H' tailstr]);
   %ARGLIST
   %[f1 x1 fc retcode1] = csminit(fcn,x,f,g,badg,H,P1,P2,P3,P4,P5,P6,P7,...
   %           P8,P9,P10,P11,P12,P13);
   % itct=itct+1;
   fcount = fcount+fc;
   % erased on 8/4/94
   % if (retcode == 1) | (abs(f1-f) < crit)
   %    done=1;
   % end
   % if itct > nit
   %    done = 1;
   %    retcode = -retcode;
   % end
   if retcode1 ~= 1
      if retcode1==2 | retcode1==4
         wall1=1; badg1=1;
      else
         if NumGrad
            [g1 badg1] = eval(['numgrad(fcn, x1' tailstr]);
            %ARGLIST
            %[g1 badg1] = numgrad(fcn, x1,P1,P2,P3,P4,P5,P6,P7,P8,P9,...
            %                P10,P11,P12,P13);
         else
            [g1 badg1] = eval([grad '(x1' tailstr]);
            %ARGLIST
            %[g1 badg1] = feval(grad, x1,P1,P2,P3,P4,P5,P6,P7,P8,P9,...
            %                P10,P11,P12,P13);
         end
         wall1=badg1;
         % g1
         eval(['save g1 g1 x1 f1 ' stailstr]);
         %ARGLIST
         %save g1 g1 x1 f1 P1 P2 P3 P4 P5 P6 P7 P8 P9 P10 P11 P12 P13;
      end
      if wall1 % & (~done) by Jinill
         % Bad gradient or back and forth on step length.  Possibly at
         % cliff edge.  Try perturbing search direction.
         %
         %fcliff=fh;xcliff=xh;
         Hcliff=H+diag(diag(H).*rand(nx,1));
         disp('Cliff.  Perturbing search direction.')
         [f2 x2 fc retcode2] = eval(['csminit(fcn,x,f,g,badg,Hcliff' tailstr]);
         %ARGLIST
         %[f2 x2 fc retcode2] = csminit(fcn,x,f,g,badg,Hcliff,P1,P2,P3,P4,...
         %     P5,P6,P7,P8,P9,P10,P11,P12,P13);
         fcount = fcount+fc; % put by Jinill
         if  f2 < f
            if retcode2==2 | retcode2==4
                  wall2=1; badg2=1;
            else
               if NumGrad
                  [g2 badg2] = eval(['numgrad(fcn, x2' tailstr]);
                  %ARGLIST
                  %[g2 badg2] = numgrad(fcn, x2,P1,P2,P3,P4,P5,P6,P7,P8,...
                  %      P9,P10,P11,P12,P13);
               else
                  [g2 badg2] = eval([grad '(x2' tailstr]);
                  %ARGLIST
                  %[g2 badg2] = feval(grad,x2,P1,P2,P3,P4,P5,P6,P7,P8,...
                  %      P9,P10,P11,P12,P13);
               end
               wall2=badg2;
               % g2
               badg2
               eval(['save g2 g2 x2 f2 ' stailstr]);
               %ARGLIST
               %save g2 g2 x2 f2 P1 P2 P3 P4 P5 P6 P7 P8 P9 P10 P11 P12 P13;
            end
            if wall2
               disp('Cliff again.  Try traversing')
               if norm(x2-x1) < 1e-13
                  f3=f; x3=x; badg3=1;retcode3=101;
               else
                  gcliff=((f2-f1)/((norm(x2-x1))^2))*(x2-x1);
                  [f3 x3 fc retcode3] = eval(['csminit(fcn,x,f,gcliff,0,eye(nx)' tailstr]);
                  %ARGLIST
                  %[f3 x3 fc retcode3] = csminit(fcn,x,f,gcliff,0,eye(nx),P1,P2,P3,...
                  %         P4,P5,P6,P7,P8,...
                  %      P9,P10,P11,P12,P13);
                  fcount = fcount+fc; % put by Jinill
                  if retcode3==2 | retcode3==4
                     wall3=1; badg3=1;
                  else
                     if NumGrad
                        [g3 badg3] = eval(['numgrad(fcn, x3' tailstr]);
                        %ARGLIST
                        %[g3 badg3] = numgrad(fcn, x3,P1,P2,P3,P4,P5,P6,P7,P8,...
                        %                        P9,P10,P11,P12,P13);
                     else
                        [g3 badg3] = eval([grad '(x3' tailstr]);
                        %ARGLIST
                        %[g3 badg3] = feval(grad,x3,P1,P2,P3,P4,P5,P6,P7,P8,...
                        %                         P9,P10,P11,P12,P13);
                     end
                     wall3=badg3;
                     % g3
                     badg3
                     eval(['save g3 g3 x3 f3 ' stailstr]);
                     %ARGLIST
                     %save g3 g3 x3 f3 P1 P2 P3 P4 P5 P6 P7 P8 P9 P10 P11 P12 P13;
                  end
               end
            else
               f3=f; x3=x; badg3=1; retcode3=101;
            end
         else
            f3=f; x3=x; badg3=1;retcode3=101;
         end
      else
         % normal iteration, no walls, or else we're finished here.
         f2=f; f3=f; badg2=1; badg3=1; retcode2=101; retcode3=101;
      end
   end
   %how to pick gh and xh
   if f3<f & badg3==0
      ih=3
      fh=f3;xh=x3;gh=g3;badgh=badg3;retcodeh=retcode3;
   elseif f2<f & badg2==0
      ih=2
      fh=f2;xh=x2;gh=g2;badgh=badg2;retcodeh=retcode2;
   elseif f1<f & badg1==0
      ih=1
      fh=f1;xh=x1;gh=g1;badgh=badg1;retcodeh=retcode1;
   else
      [fh,ih] = min([f1,f2,f3]);
      disp(sprintf('ih = %d',ih))
      %eval(['xh=x' num2str(ih) ';'])
      if size(x1,2)>1
         xi=[x1;x2;x3];
         xh=xi(ih,:);
      else
         xi=[x1 x2 x3];
         xh=xi(:,ih);
      end
      %eval(['gh=g' num2str(ih) ';'])
      %eval(['retcodeh=retcode' num2str(ih) ';'])
      retcodei=[retcode1,retcode2,retcode3];
      retcodeh=retcodei(ih);
      if gh==[]
         if NumGrad
            [gh badgh] = eval(['numgrad(fcn, xh' tailstr]);
            %ARGLIST
            %[gh badgh] = numgrad(fcn,xh,P1,P2,P3,P4,P5,P6,P7,P8,...
            %            P9,P10,P11,P12,P13);
         else
            [gh badgh] = eval([grad '(xh' tailstr]);
            %ARGLIST
            %[gh badgh] = feval(grad,xh,P1,P2,P3,P4,P5,P6,P7,P8,...
            %                              P9,P10,P11,P12,P13);
         end
      end
      badgh=1;
   end
   %end of picking
   %ih
   %fh
   %xh
   %gh
   %badgh
   stuck = (abs(fh-f) < crit);
   if (~badg)&(~badgh)&(~stuck)
      H = bfgsi(H,gh-g,xh-x);
   end
   if Verbose
      disp('----')
      disp(sprintf('Improvement on iteration %d = %18.9f',itct,f-fh))
   end
   if Verbose
      if itct > nit
         disp('iteration count termination')
         done = 1;
      elseif stuck
         disp('improvement < crit termination')
         done = 1;
      end
      rc=retcodeh;
      if rc == 1
         disp('zero gradient')
      elseif rc == 6
         disp('smallest step still improving too slow, reversed gradient')
      elseif rc == 5
         disp('largest step still improving too fast')
      elseif (rc == 4) | (rc==2)
         disp('back and forth on step length never finished')
      elseif rc == 3
         disp('smallest step still improving too slow')
      elseif rc == 7
         disp('warning: possible inaccuracy in H matrix')
      end
   end
   f=fh;
   x=xh;
   g=gh;
   badg=badgh;
end
% what about making an m-file of 10 lines including numgrad.m
% since it appears three times in csminwel.m