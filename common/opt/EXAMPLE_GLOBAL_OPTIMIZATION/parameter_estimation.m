function [p,J] = parameter_estimation(p0,data,measurement_times,init,lb,ub,method)

% start parameter estimation with requested optimization algorithm

switch method
    
    case 'fmincon'
        
        % set options for optimisation algorithm
        
        options = optimset('LargeScale','off','Display','iter');
        
        % start optimisation
        
        [p,J] = fmincon(@objective_function,p0,[],[],[],[],lb,ub,[],options,data,measurement_times,init)
        
    case 'SIMPSA'
        
        % use default options
        
        options = SIMPSASET('display','iter');
        
        % start optimization
        
        [p,J] = SIMPSA('objective_function',p0,lb,ub,options,data,measurement_times,init)

    case 'SCE'

        % use default options

        options = SCESET('display','iter');

        % start optimization

        [p,J] = SCE('objective_function',p0,lb,ub,options,data,measurement_times,init)

    case 'PSO'

        % use default options

        options = PSOSET('display','iter');

        % start optimization

        [p,J] = PSO('objective_function',p0,lb,ub,options,data,measurement_times,init)

end