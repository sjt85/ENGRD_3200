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

for i = 1:num_steps-1
    % Evaluate y vector for the next time
    slopes = transpose(dydt(t(i),y(i,:)));
    % Evaluate new values based on those from previous timestep
    % Use special h formula to allow for nonuniform timesteps
    y(i+1,:) = y(i,:) + (t(i+1)-t(i))*slopes;
end


end

