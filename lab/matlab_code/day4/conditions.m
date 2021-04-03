function [c,ceq] = conditions(x)
%NONLCON Summary of this function goes here
%   Detailed explanation goes here
alpha = 0.2;
beta = 20;
lambda_t = 2*pi/3;
states = x(1:((length(x)+2)* 6)/8);
x_array = reshape(states,6, length(states)/6);
c = zeros(size(x_array, 2),1);

cfun = @(state)(alpha*exp(-beta*(state(1)-lambda_t).^2)-state(5));

for counter = 1:size(x_array,2)
    c(counter) = cfun(x_array(:,counter));
    
end

ceq = [];
end
