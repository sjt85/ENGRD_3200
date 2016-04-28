function [I] = TEAM34PS08Q1()

% Numerically integrates sin(x) from [0,pi]
% Computes for composite trapezoidal rule, Simpson's 1/3 rule, and Boole's
% rule
% Divides into N subintervals from 20 to 152 in increments of 4



% Call with @sin
steps = linspace(0,pi,100);
I = Simpson(@sin,steps);



function I = Simpson(f,steps)
    % Numerically integrates using Simpson's rule
    % Inputs function f and a vector of sub-intervals steps
    
    % initialize
    sum_even = 0;
    sum_odd = 0;
    N = length(steps);  % Difference in indices
    
    for k = 3 : 2 : N-2
       sum_even = sum_even + f(steps(k));        
    end
    
    for k = 2 : 2 : N-1
        sum_odd = sum_odd + f(steps(k));
    end
    
    I = (steps(N) - steps(1))*(f(steps(1)) + 4*sum_odd + 2*sum_even + ...
        f(steps(N)))/(3*N);

end



function I = Boole(f,steps)
    % Numerically integrates using Boole's rule
    % Inputs function f and a vector of sub-intervals steps

end


end