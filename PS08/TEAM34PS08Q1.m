function [trap,simp,booles] = TEAM34PS08Q1()

% Numerically integrates sin(x) from [0,pi]
% Computes for composite trapezoidal rule, Simpson's 1/3 rule, and Boole's
% rule
% Divides into N subintervals from 20 to 152 in increments of 4



% Call with @sin

i = 0;  % Iteration counter for setting up plotting
trap = zeros(34,3);  % Column 1 is spacing, 2 is value, 3 is error
simp = trap;
booles = trap;
sub_ints = zeros(34,1);

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


% To get least squares fits, take log of both sides

traplog = zeros(34,2);
traplog(:,1) = log(trap(:,1));
traplog(:,2) = log(trap(:,3));

simplog = zeros(34,2);
simplog(:,1) = log(simp(:,1));
simplog(:,2) = log(simp(:,3));

booleslog = zeros(34,2);
booleslog(:,1) = log(booles(:,1));
booleslog(:,2) = log(booles(:,3));

% Now perform least squares on transformed variables

trapfit = polyfit(traplog(:,1),traplog(:,2),1);
simpfit = polyfit(simplog(:,1),simplog(:,2),1);
boolesfit = polyfit(booleslog(:,1),booleslog(:,2),1);

% Back substitute

trapfitnew = [exp(trapfit(1)), trapfit(2)];
simpfitnew = [exp(simpfit(1)), simpfit(2)];
boolesfitnew = [exp(boolesfit(1)), boolesfit(2)];

% Evaluate least squares polynomials

%trapvals = trapfitnew(2).*trap(:,1).^trapfitnew(1);
trapvals = exp(trapfit(2)).*trap(:,1).^trapfit(1);

%trapvals = polyval(trapfitnew,trap(:,1));
%simpvals = polyval(simpfitnew,simp(:,1));
%boolesvals = polyval(boolesfitnew,booles(:,1));




close all
figure
loglog(trap(:,1),trap(:,3),'o')
hold on
loglog(simp(:,1),simp(:,3),'o')
loglog(booles(:,1),booles(:,3),'o')

%plot least squares too
plot(trap(:,1),trapvals)
%plot(simp(:,1),simpvals)
%plot(booles(:,1),boolesvals)

%legend('Trapezoidal','Simpsons','Booles')
xlabel('Integration Segment Length')
ylabel('Absolute Error')
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