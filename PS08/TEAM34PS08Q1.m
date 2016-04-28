function [trap,simp,booles] = TEAM34PS08Q1()

% Numerically integrates sin(x) from [0,pi]
% Computes for composite trapezoidal rule, Simpson's 1/3 rule, and Boole's
% rule
% Divides into N subintervals from 20 to 152 in increments of 4



% Call with @sin

i = 0;  % Iteration counter for setting up plotting
trap = zeros(33,3);  % Column 1 is spacing, 2 is value, 3 is error
simp = trap;
booles = trap;
sub_ints = zeros(33,1);

for N = 20 : 4 : 152    % Evaluate integral at each N value
    i = i + 1;
    sub_ints(i,1) = N;    % Number of subintervals
    steps = linspace(0,pi,N);
    trap(i,2) = trapz(steps,sin(steps));
    simp(i,2) = Simpson(@sin,steps);
    booles(i,2) = Boole(@sin,steps);
end

trap(:,1) = pi ./ sub_ints(:,1);
simp(:,1) = pi ./ (2*sub_ints(:,1));   % Spacing
booles(:,1) = pi ./ (2*sub_ints(:,1));

trap(:,3) = abs(2-trap(:,2));
simp(:,3) = abs(2-simp(:,2));         % Error
booles(:,3) = abs(2-booles(:,2));


close all
figure
hold on
scatter(trap(:,1),trap(:,3))
scatter(simp(:,1),simp(:,3))
scatter(booles(:,1),booles(:,3))
hold off




function I = Simpson(f,steps)
    % Numerically integrates using Simpson's rule
    % Inputs function f and a vector of sub-intervals steps
    
    % initialize
    sum_even = 0;
    sum_odd = 0;
    N = length(steps)-1;  % Difference in indices
    
    for k = 3 : 2 : N-1
       sum_even = sum_even + f(steps(k));        
    end
    
    for k = 2 : 2 : N
        sum_odd = sum_odd + f(steps(k));
    end
    
    I = (steps(N+1) - steps(1))*(f(steps(1)) + 4*sum_odd + 2*sum_even + ...
        f(steps(N+1)))/(3*N);

end



function I = Boole(f,steps)
    % Numerically integrates using Boole's rule
    % Inputs function f and a vector of sub-intervals steps

    
    I = 0;               % initialize
    
    for k = 1 : 4 : length(steps)-4
        I = I + (steps(k+4) - steps(k)) * (7*f(steps(k)) + ...
            32*f(steps(k+1)) + 12*f(steps(k+2)) + ...
            32*f(steps(k+3)) + 7*f(steps(k+4)))/90;
    end
    
    
    
end


end