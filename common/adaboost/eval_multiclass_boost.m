function [error accuracy yest]=eval_multiclass_boost(xtest,ytest,multiclass_model,num_iter,thresh)
% This function takes in the test data and the multi class labels of the
% test data and evaluates the test data.

for j = 1 : size(multiclass_model,2)    
    h_est(:,j) = eval_boost(multiclass_model{j},xtest);          
end    

if size(multiclass_model,2) == 1
    yest = sign(h_est);
else    
    [h_val yest] = max(h_est,[],2);
end

err = sum(yest ~= ytest);

error = err/size(ytest,1);
accuracy = 1-error;