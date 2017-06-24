function J = objective_function(p,data,measurement_times,init,lb,ub)

% When optimization algorithm proposes parameter values that violate the boundaries, 
% a high value is given to J. The further the proposed parameter values is located 
% from a boundary, the higher J. This will ensure that high gradients are formed in
% that area and that the optimizer will "fall back into the pitt". (see below)
    
%   ^   \            /
% v |    \          /
% a |     \        /
% l |      |      |
% u |      |      |
% e |      |      |
%   |      |      |
% J |      --------
%   |     lb      ub

% for i = 1:length(p),
%     if p(i) < lb(i),
%         J = 1e12 + (lb(i)-p(i))*1e6;
%         return
%     elseif p(i) > ub(i),
%         J = 1e12 + (p(i)-ub(i))*1e6;
%         return
%     end
% end

% simulate with model two and parameters p

options = odeset('AbsTol',1e-9,'RelTol',1e-12,'NonNegative',[1 2]); % set solver options

[t,x2] = ode45(@model_one,measurement_times,init,options,p);

% calculate objective (sse) value

J = 0; % initialization

for i = 1:size(data,2),
    J = J + (data(:,i)-x2(:,i))'*(data(:,i)-x2(:,i));
end
        
end