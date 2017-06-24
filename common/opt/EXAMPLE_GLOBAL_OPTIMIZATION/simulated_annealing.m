function [X,FVAL,EXITFLAG] = simulated_annealing(FUN,X,BOUNDARIES,OPTIONS,varargin)
% simulated_annealing: Minimization by simulated annealing. Algorithm partly 
% based on section 10.4 in "Numerical Recipes in C", ISBN 0-521-43108-5.
% 
% USAGE:
% ======
%     [X,FVAL,EXITFLAG] = simulated_annealing(FUN,X, BOUNDARIES, OPTIONS)
%
% FUNCTION ARGUMENTS 
%===================
%     FUN: Function to be optimized.
%     X:   Starting Guess of optimal solution. For PE: initial parameter guess
%     BOUNDARIES: Matrix to specify upper and lower boundary of X. 
%                   - Col 1 contains upper boundary, col 2 lower boundary
%                   - Row i contains boundaries for i'th component of X
%                     (In PE: i'th param to be estimated)
%     OPTIONS: cell array with options for the algorithm. This is optinal:
%              if unspecified, default parameter values will be used.
%              Format: OPTIONS = {TempStart, TempEnd, TempFactor, ...
%                   MaxIterTemp, MaxIterTempEnd, MaxIterTotal, MaxTime, TolX, ...
%                   TolFun, parameterSigns, optimizerOutputFunction}
%              - TempStart: Starting temperature
%              - TempEnd: Ending temperature (below temperature is set to 0)
%              - coolRate: Reduction factor for temperature after running
%                   through all iterations for current temperature
%              - MaxIterTemp0: number of iterations to carry out in preliminary
%                   'initial temperature identification round'
%              - MaxIterTemp: number of iterations to carry out for each non-zero
%                   temperature
%              - MaxIterTempEnd: number of iterations to carry out for 0
%                   temperature
%              - MaxIterTotal: maximum number of total iterations
%              - MaxTime: Maximum time (in minutes) for optimization
%              - TolFun:  Tolerance for difference between best and worst
%                   function evaluation in simplex
%              - TolX: Tolerance for max difference between the coordinates of
%                   the vertices.
%              - parameterSigns: vector of same length as X, indicating the signs of the
%                   parameters to estimate. 1 = pos, -1 = neg, 0 = either
%                   if this vector is empty, the default setting will be used.
%              - optimizerOutputFunction: string with output function name. If
%                   not given or if empty then no output function will be used.
%
% DEFAULT VALUES:
% ===============
%     TempStart = calculated by initial temp loop
%     TempEnd = 0.1
%     TempFactor = 0.1
%     MaxIterTemp0 = 100 * number of variables
%     MaxIterTemp = 50 * number of variables
%     MaxIterTempEnd = 200 * number of variables
%     MaxIterTotal = 1000 * number of variables
%     MaxTime = 120
%     TolX = 1e-5
%     TolFun = 1e-5
%     parameterSigns: signs changes are allowed
%     optimizerOutputFunction: no output function ('')
%
% Output Arguments:
% =================
%     X: Found solution
%     FVAL: Value of the function FUN at X
%     EXITFLAG: 1=success, 0=not found

% Information:
% ============
%     Algorithm used: 
%       - Original publication: 
%           Cardoso et. al (1996). The Simplex-Simulated annealing
%           approach to continuous non-linear optimization
%       - C code: section 10.4 in "Numerical Recipes in C", ISBN 0-521-43108-5.
% 
%     Authors: 
%       - Original Matlab implementation: 2005 Henning Schmidt, FCC,
%         henning@fcc.chalmers.se
%       - Modified by Aditya Bhagwat on 22/06/2006. 
%         e.g. routine to calculate initial temperature
% 
%     Copyright:
%         This program is free software; you can redistribute it and/or
%         modify it under the terms of the GNU General Public License
%         as published by the Free Software Foundation; either version 2
%         of the License, or (at your option) any later version.
% 
%         You should have received a copy of the GNU General Public License
%         along with this program; if not, write to the Free Software
%         Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307,
%         USA.
% 
%     Warranty:
%         This program is distributed in the hope that it will be useful,
%         but WITHOUT ANY WARRANTY; without even the implied warranty of
%         MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%         GNU General Public License for more details. 
% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GLOBAL VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % declaration
    global ndim nfunk Xguess parameterSigns Temp ybest pbest
    
    % initialization
    ndim = length(X);  % (no of variables to be optimized)
    EXITFLAG = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HANDLE OPTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% default options
%----------------
    TempStart = [];
    coolRate = 2; % small values (<1) means slow convergence, large values (>1) means fast convergence
    initialAcceptanceRatio = 0.95;
    TempEnd = 1;

    MaxIterTemp0    = 50*ndim;
    MaxIterTemp1  	= 50*ndim;
    MaxIterTemp     = 10*ndim;
    MaxIterTempEnd  = 100*ndim;
    MaxIterTotal    = 3000*ndim;
    MaxTime = 2500; 

    TolX = 1e-3;
    TolFun = 1e-6;
    parameterSigns = ones(1,ndim);
    optimizerOutputFunction = '';

% check whether FUN, X & BOUNDARIES entered correctly
%----------------------------------------------------
if ~ ischar(FUN),
    error('''FUN'' incorrectly specified in ''simulated_annealing''');      
end
if ~ isfloat(X),
    error('''X'' incorrectly specified in ''simulated_annealing''');      
end
if ~ isfloat(BOUNDARIES),
    error('''BOUNDARIES'' incorrectly specified in ''simulated_annealing''');      
end
if ~ length(X) == size(BOUNDARIES, 1),
    error('''BOUNDARIES'' and X haven''t got a compatible size in ''simulated_annealing''');  
end

% check whether options given correctly
%---------------------------------------
    if length(OPTIONS) > 0 && length(OPTIONS) <= 12,
        % TempStart
            if ~isempty(OPTIONS{1}) && OPTIONS{1} ~= 0,   TempStart       = OPTIONS{1};  
            else disp('Warning: Option ''TempStart'' in simulated_annealing not specified (properly). Using default instead.');
            end
        % TempEnd
            if ~isempty(OPTIONS{2}) && OPTIONS{2} ~= 0,   TempEnd         = OPTIONS{2};  
            else disp('Warning: Option ''TempEnd'' in simulated_annealing not specified (properly). Using default instead.');
            end
        % coolRate
            if ~isempty(OPTIONS{3}) && OPTIONS{3} ~= 0,   coolRate        = OPTIONS{3};  
            else disp('Warning: Option ''coolRate'' in simulated_annealing not specified (properly). Using default instead.');
            end
        % MaxIterTemp0
            if ~isempty(OPTIONS{4}) && OPTIONS{4} ~= 0,   MaxIterTemp0  = OPTIONS{4};  
            else disp('Warning: Option ''MaxIterTemp0'' in simulated_annealing not specified (properly). Using default instead.');
            end
        % MaxIterTemp
            if ~isempty(OPTIONS{5}) && OPTIONS{5} ~= 0,   MaxIterTemp     = OPTIONS{5};  
            else disp('Warning: Option ''MaxIterTemp'' in simulated_annealing not specified (properly). Using default instead.');
            end
        %MaxIterTempEnd
             if ~isempty(OPTIONS{6}) && OPTIONS{6} ~= 0,  MaxIterTempEnd    = OPTIONS{6};  
             else disp('Warning: Option ''MaxIterTempEnd'' in simulated_annealing not specified (properly). Using default instead.');
             end
        %MaxIterTotal
            if ~isempty(OPTIONS{7}) && OPTIONS{7} ~= 0,   MaxIterTotal    = OPTIONS{7};  
            else disp('Warning: Option ''MaxIterTotal'' in simulated_annealing not specified (properly). Using default instead.');
            end
        %MaxTime
            if ~isempty(OPTIONS{8}) && OPTIONS{8} ~= 0,   MaxTime         = OPTIONS{8};  
            else disp('Warning: Option ''MaxTime'' in simulated_annealing not specified (properly). Using default instead.');
            end
        %TolX 
            if ~isempty(OPTIONS{9}) && OPTIONS{9} ~= 0,   TolX            = OPTIONS{9};  
            else disp('Warning: Option ''TolX'' in simulated_annealing not specified (properly). Using default instead.');
            end
        %TolFun
            if ~isempty(OPTIONS{10}) && OPTIONS{10} ~= 0, TolFun          = OPTIONS{10}; 
            else disp('Warning: Option ''TolFun'' in simulated_annealing not specified (properly). Using default instead.');
            end
        %parameterSigns
            if ~isempty(OPTIONS{11}), parameterSigns  = OPTIONS{11}; 
            else disp('Warning: Option ''parameterSigns'' in simulated_annealing not specified (properly). Using default instead.');
            end
        %optimizerOutputFunction
            if ~isempty(OPTIONS{12}) && ischar(OPTIONS{12}),   optimizerOutputFunction = OPTIONS{12}; 
            else disp('Warning: Option ''parameterSigns'' in simulated_annealing not specified (properly). Using default instead.');
            end
    elseif length(OPTIONS) == 0,
        disp('Warning: No options vector supplied. Using default options.');
    else
        disp('Warning: Options vector for simulated_annealing has incorrect size. Using default options instead.');
    end
    if length(parameterSigns) ~= ndim,
        error('Wrong number of parameter sign vector in options.');
    end

%%%%%%%%%%%%%
% INITIALIZE 
%%%%%%%%%%%%%

% Seed the random number generator
rand('state',sum(100*clock));

% set specified boundaries
%--------------------------
lowerBound = BOUNDARIES(:,1);
upperBound = BOUNDARIES(:,2);

% Initialize simplex data
%-------------------------
    % create empty simplex matrix p (location of vertex i in row i)
    % and empty cost vector (cost of vertex i in row i)
        p = zeros(ndim+1,ndim);
        y = zeros(ndim+1,1);
    % set best vertex of initial simplex = initial parameterguess
    % and calculate correponding cost
        pbest = X(:)';
        ybest = costFunction(FUN,pbest,varargin{:});

% Initialize temp loop
%---------------------
    TempLoopNo=0;
    Temp = ybest*1e5;

% Initialize iteration data
%--------------------------
    tic % start timer
    nfunk = 1;
    nriterations = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEMPERATURE LOOP: RUN SIMPSA TILL STOP TEMPERATURE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

while(1),

    % SET MAXITERTEMP: MAX NUMBER OF ITERATIONS AT CURRENT TEMPERATURE
    %-----------------------------------------------------------------
    if TempLoopNo==0
        display(sprintf('--------------------------------------\n'));
        display(sprintf('This is the initial temperature loop\n'));
        display(sprintf('--------------------------------------\n'))
        MAXITERTEMP = MaxIterTemp0;
    elseif TempLoopNo==1
        MAXITERTEMP = MaxIterTemp1;
    elseif Temp < TempEnd,
        Temp = 0;
        MAXITERTEMP = MaxIterTempEnd;
    else 
        MAXITERTEMP = MaxIterTemp;
    end

    % CONSTRUCT INITIAL SIMPLEX
    %---------------------------
        % 1ST POINT OF INITIAL SIMPLEX
        % - - - - - - - - - - - - - - -
        overallOpt = sprintf('%4.2e ', pbest); 
        disp(sprintf(' Overall optimum till now: [%s]',overallOpt));
        Xguess = pbest;
        p(1,:) = Xguess;
        y(1) = costFunction(FUN,Xguess,varargin{:});
        
        currOpt     = sprintf('%4.2e ', p(1,:));
        disp(' Nr Iter  Nr Fun Eval    Min function       Best function       Temp      Algorithm Step');
        % disp(' Nr Iter             currOpt                         overallOpt                  Cost currOpt     Cost overallOpt            Temp         Algorithm Step');        
        if Temp == TempStart,
            disp(sprintf(' %5.0f   %5.0f       %12.6g       %12.6g   %12.6g       %s', nriterations, nfunk, y(1), ybest, Temp, 'initial guess'));
            % disp(sprintf(' %5d        [%s]   [%s]     %12.6g       %12.6g          %12.6g       %s', nriterations, currOpt, overallOpt, y(1), ybest, Temp, 'initial guess'));
        else
            disp(sprintf(' %5.0f   %5.0f       %12.6g       %15.6g   %12.6g       %s', nriterations, nfunk, y(1), ybest, Temp, 'best point'));
            % disp(sprintf(' %5d        [%s]    [%s]     %12.6g       %15.6g         %12.6g       %s', nriterations, currOpt, overallOpt, y(1), ybest, Temp, 'best point'));            
        end
        % if output function given then run output function to plot
        % intermediate result
        if length(optimizerOutputFunction) ~= 0,
            feval(optimizerOutputFunction,p(1,:), y(1));
        end

        % REMAINING POINTS OF INITIAL SIMPLEX
        % - - - - - - - - - - - - - - - - - -
        % original SB technique: construct vertices by modifying one element each
        % relative changes in case that elements are non-zero,
        % absolute changes in case that elements are zero
        relativeDelta = 0.25;
        absoluteDelta = 0.5;
        for k = 1:ndim
            
            Xmodify = Xguess;
            % for the first two loops, use Dirks 'full span technique'
            if TempLoopNo == 0 || TempLoopNo==1
                Xmodify(k) = lowerBound(k) + rand*(upperBound(k)-lowerBound(k));
            % for the other loops use the original SB technique
            else
%                  if Xmodify(k) == 0
%                     % absolute change
%                     if parameterSigns(k) >= 0,
%                         Xmodify(k) = absoluteDelta;
%                     else
%                         Xmodify(k) = -absoluteDelta;
%                     end
%                 else
%                     % relative change
%                     Xmodify(k) = (1 + relativeDelta)*Xmodify(k);
%                 end
%             end
            % technique found in Cardoso et al. (1996)
            Xmodify = p(1,:)+(0.5*ones(1,ndim)-rand(1,ndim)).*2.*p(1,:);
            end
            p(k+1,:) = Xmodify;
            y(k+1) = costFunction(FUN,Xmodify,varargin{:});

        end
        algostep = 'initial simplex';
        nriterations = nriterations + 1;
        nfunk = nfunk + ndim + 1;
    
    % RUN FULL METROPOLIS CYCLE ( = MAXITERTEMP SIMPLEX CYCLES) AT CURRENT TEMP
    %-----------------------------------------------------------------------
    nSuccesses = 0; nFailures = 0; costFailures=0;
    nVerticesExamined=length(y); costsVertices = zeros(MAXITERTEMP, 1); costsVertices(1:length(y)) = y(:);
    
    for itertemp = 1:MAXITERTEMP,

        % Add random thermal fluctuations
        yfluct = y + Temp*abs(log(rand(ndim+1,1)));
        
        % Reorder y and p so that the first row corresponds to the
        % lowest function value (do sorting instead of determining the
        % indices of the best, worst, next worst
        help = sortrows([yfluct,y,p],1);
        yfluct = help(:,1);
        y = help(:,2);
        p = help(:,3:end);
        
        overallOpt = sprintf('%4.2e ', pbest); 
        currOpt     = sprintf('%4.2e ', p(1,:));
        
        disp(sprintf(' %5.0f   %5.0f       %12.6g       %15.6g   %12.6g       %s', nriterations, nfunk, y(1), ybest, Temp, algostep));

        % If output function given then run output function to plot
        % intermediate result
        if length(optimizerOutputFunction) ~= 0,
            feval(optimizerOutputFunction,p(1,:), y(1));
        end
        
        % End the optimization if one of the stop conditions reached
            % 1. There is a convergence to the optimal parameter set: 
            %       1) the difference between best and worst function
            %          evaluation in simplex is smaller than TolFun 
            %       2) the max difference between the coordinates of the
            %          vertices is less than TolX
            if abs(max(y)-min(y)) < TolFun && max(max(abs(p(2:ndim+1)-p(1:ndim)))) < TolX,
                solutionExplanation = 'simplex converged';
                break;
            end
            % 2. Not a convergence, but max. number of tries has been
            % reached (either in iterations or in maximum time)
            if nriterations >= MaxIterTotal,
                EXITFLAG = 0;
                disp('Exceeded maximum number of iterations.');
                break;
            end
            if toc/60 > MaxTime,
                EXITFLAG = 0;
                disp('Exceeded maximum time.');
                break;
            end
            
        % Start a new iteration.
            % First extrapolate by a factor -1 through the face of the
            % simplex across from the high point, i.e., reflect the simplex
            % from the high point.
            [yftry, ytry,ptry] = amotry(FUN, p, -1,varargin{:});

            % Continue, depending on result
                % If reflected point better than best point: try additional
                % extrapolation by a factor 2.
                if yftry <= yfluct(1),
                    [yftryexp, ytryexp,ptryexp] = amotry(FUN, p, -2,varargin{:});
                    if yftryexp < yftry,
                        p(end,:) = ptryexp; 
                        if TempLoopNo==0
                            [nSuccesses, nFailures, costFailures] = update(y(end), ytryexp, nSuccesses, nFailures, costFailures);
                        end
                        y(end) = ytryexp; 
                        algostep = 'extrapolation';
                    else
                        p(end,:) = ptry;
                        if TempLoopNo==0
                            [nSuccesses, nFailures, costFailures] = update(y(end), ytry, nSuccesses, nFailures, costFailures);
                        end
                        y(end) = ytry;
                        algostep = 'reflection';
                    end
                    
                    if TempLoopNo==0
                            [nSuccesses, nFailures, costFailures] = update(y(end), ytry, nSuccesses, nFailures, costFailures);
                    end
                    
                    nVerticesExamined = nVerticesExamined+1; costsVertices(nVerticesExamined) = y(end);

                % If reflected point is worse than the second-highest, look
                % for an intermediate lower point, i.e., do a one-dimensional
                % contraction.
                elseif yftry >= yfluct(ndim),
                    [yftrycontr,ytrycontr,ptrycontr] = amotry(FUN, p, -0.5,varargin{:});
                    if yftrycontr < yfluct(end),
                        p(end,:) = ptrycontr;   
                        if TempLoopNo==0
                            [nSuccesses, nFailures, costFailures] = update(y(end), ytrycontr, nSuccesses, nFailures, costFailures);
                        end
                        y(end) = ytrycontr;
                        nVerticesExamined = nVerticesExamined+1; costsVertices(nVerticesExamined) = y(end);
                        algostep = 'one dimensional contraction';
                    else
                        % Can't seem to get rid of that high point. Better contract
                        % around the lowest (best) point.
                        x = ones(ndim,ndim)*diag(p(1,:));
                        p(2:end,:) = 0.5*(p(2:end,:)+x);
                        for k=2:ndim,
                            if TempLoopNo==0
                                [nSuccesses, nFailures, costFailures] = update(y(k), costFunction(FUN,p(k,:),varargin{:}), nSuccesses, nFailures, costFailures);
                            end
                            y(k) = costFunction(FUN,p(k,:),varargin{:});
                            nVerticesExamined = nVerticesExamined+1; costsVertices(nVerticesExamined) = y(k);
                        end
                        algostep = 'contraction around best point';
                    end

                % If reflected point better than second-highest point then use this point
                else
                    p(end,:) = ptry; 
                    if TempLoopNo==0
                        [nSuccesses, nFailures, costFailures] = update(y(end), ytry, nSuccesses, nFailures, costFailures);
                    end
                    y(end) = ytry;
                    nVerticesExamined = nVerticesExamined+1; costsVertices(nVerticesExamined) = y(end);
                    algostep = 'reflection';
                end

        % Increment iteration number
        nriterations = nriterations + 1;
    end

    % STOP IF PREVIOUS FOR LOOP WAS BROKEN (DUE TO SOME STOP CRITERION)
    %---------------------------------------------------------------
    if itertemp < MAXITERTEMP,
        break;
    end

    % RENEW TEMP & REPEAT SIMPLEX CYCLE FOR NEW TEMP
    %-----------------------------------------------
    if TempLoopNo==0
        Temp = - costFailures / log( ( (nSuccesses+nFailures)*initialAcceptanceRatio - nSuccesses)/nFailures);
        display(sprintf('------------------------------\n'));
        display(sprintf('Initial temperature loop ended\n'));
        display(sprintf('The starting temperature is: %f', Temp));
        display(sprintf('--------------------------------------\n'));
    else
        stdev_y = std(costsVertices);
        Temp = Temp / (1 + Temp*log(1+coolRate)/(3*stdev_y));
    end
    TempLoopNo = TempLoopNo+1;
end

%%%%%%%%%%%%%%%%%%%%%%%
% RETURN FOUND SOLUTION
%%%%%%%%%%%%%%%%%%%%%%%

X = pbest;
FVAL = ybest;
% disp( sprintf('Reason for solution: %s', solutionExplanation) );
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AMOTRY FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [yftry,ytry,ptry] = amotry(FUN, p, fac,varargin)
% Extrapolates by a factor fac through the face of the simplex across from 
% the high point, tries it, and replaces the high point if the new point is 
% better.

    global ndim nfunk parameterSigns Temp
    
    psum = sum(p(1:ndim,:))/ndim;
    ptry = psum*(1-fac) + p(end,:)*fac;
    
    % quick fix to deal with sign changes
        index = find(parameterSigns(:).*ptry(:) < 0);
        if ~isempty(index),
            %    disp(sprintf('Sign-change conflict detected.\nYou might want to try a different starting guess.'));
                ptry(index) = 0.8*p(index);
        end

    % deal with unwanted exact 0 values
        index = intersect(find(ptry == 0), find(parameterSigns ~=0));
        if ~isempty(index),
            ptry(index) = 0.1*p(index);
        end

    % Evaluate the function at the trial point.
        ytry = costFunction(FUN,ptry,varargin{:});
        yftry = ytry - Temp*abs(log(rand(1)));
        nfunk = nfunk + 1;
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COST FUNCTION EVALUATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ytry] = costFunction(FUN,ptry,varargin)
    global ybest pbest
    ytry = feval(FUN,ptry,varargin{:});
    % save the best point ever
    if ytry < ybest,
        ybest = ytry;
        pbest = ptry;
    end    
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UPDATE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [noOfSuccesses, noOfFailures, costOfFailures] = update(yOld, yNew, noOfSuccesses, noOfFailures, costOfFailures)
    if yNew < yOld 
        noOfSuccesses = noOfSuccesses +1;
    else
        noOfFailures = noOfFailures +1;
        costOfFailures = costOfFailures + (yNew-yOld);
    end
return