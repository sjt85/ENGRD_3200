function TEAM34PS05Q2
% This function loads the daaset that represents what a tidal gauge
% measures on a windy day and draws a scatter plot of the data with the
% least-squares fit overlaid on top of the data

load ('noisier_tide')
figure
hold on
box on
xlabel ('Time')
ylabel('Change in the Sea Level')
title('Time vs. Change in the Sea Level')
scatter(x,y)             % Generate a scatter plot of the data points
[nr,nc] = size(x);
[a,ConNum] = polylsq(x,y,nr,3);
PredY = zeros(nr,1);
Reala = [-11 55/3 -17/2 7/6];
for k = 1:1:nr
PredY(k) = a(1)+a(2)*x(k)+a(3)*x(k)^2+a(4)*x(k)^3;
end
plot(x,PredY)            % Plot the least squares fit

% Create a vector that stores the absolute error for each of the polynomial
% fit coefficients with respect to the given coefficients
AbsError = zeros(length(a),1);
for j = 1:length(a)
    AbsError(j) = abs(a(j)-Reala(j));
end

end

function [a,ConNum] = polylsq(x,y,n,m)
% This function polylsq computes the m-th order polynomial least squares
% model of a set of data points (xi,yi) where i = 1,2,...n.
% x, and y store the data point
% n is the number of data points in that set
% m represents m-th order polynomial least squares model
% output a is a vector stores the coefficients aj where j = 0,...m
% output ConNum is the condition number of Gram's matrix
bigX = ones (n,m+1);
for k = 2:m+1
    for j = 1:n
        bigX (j,k) = x(j)^(k-1); % Create the X matrix
    end
end
LHS = transpose(bigX) * bigX;
RHS = transpose(bigX) * y;
a = LHS \ RHS;                 % Use the backslash command to find vector a 
ConNum = norm (LHS, Inf);      % Condition Number of Gram's matrix

end

