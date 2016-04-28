function [simp,booles] = TEAM34PS08Q1()

% Numerically integrates sin(x) from [0,pi]
% Computes for composite trapezoidal rule, Simpson's 1/3 rule, and Boole's
% rule
% Divides into N subintervals from 20 to 152 in increments of 4



% Call with @sin
steps = linspace(0,pi,1000);
simp = Simpson(@sin,steps);

booles = Boole(@sin,steps);



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