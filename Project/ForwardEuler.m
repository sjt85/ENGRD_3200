function [t,y] = ForwardEuler(dydt,tspan,y0,h)
% Forward Euler ODE solver
% input:
%   dydt = name of the M-file that evaluates the ODEs
%   tspan = final time
%   y0 = initial values of dependent variables, row vector
%   h = step size

% Assumes that tspan is a multiple of h

num_steps = round(tspan/h);  % Number of timesteps
t = linspace(0,tspan,num_steps);
y = zeros(num_steps,4);
y(1,:) = y0;  % Initial conditions

for i = 2:num_steps
    % Evaluate y vector at current time
    slopes = transpose(dydt(t(i-1),y(i-1,:)));
    y(i,:) = y(i-1,:) + (t(i)-t(i-1))*slopes;  % Evaluate from previous timestep
end


end

