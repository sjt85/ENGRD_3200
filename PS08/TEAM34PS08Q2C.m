function TEAM34PS08Q2C
% Use the Simpson's rule to draw a log-log plot

f = @(x) 1/(1+x^2);
i = 0;
for n = 20:4:160
    i = i+1;
    steps = linspace(0,1,n);
    Simp(i) = Simpson(f,steps);
   
end
SimpError = abs(pi/4 - Simp);
Simpxlabel = linspace(20,160,36)*3;

figure
loglog(Simpxlabel,SimpError)
hold on
box on
grid on
xlabel ('The Total Number of Intergration Points')
ylabel ('The Absolute Value of the True Error')
title ('Loglog plot of Simpsons rule')
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

end

