function [t,y] = ForwardEuler(dydt,tspan,y0,h)
% Forward Euler ODE solver
% input:
%   dydt = name of the M-file that evaluates the ODEs
%   tspan = final time
%   y0 = initial values of dependent variables
%   h = step size

num_steps = tspan/h;  % Number of timesteps
t = linspace(0,tspan,num_steps);
num_variables = length(dydt);
y = zeros(num_steps,num_variables);
y(1,:) = y0;  % Initial conditions

for i = 2:num_steps
    % Evaluate y vector at current time
    for j = 1:num_variables
        y(i,j) = dydt(t(i),y(i-1,:));  % Evaluate from previous timestep
    end
end


end

