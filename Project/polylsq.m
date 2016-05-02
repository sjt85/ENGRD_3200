function [a,ConNum,theta] = polylsq(x,y,n,m)
% This function polylsq computes the m-th order polynomial least squares
% model of a set of data points (xi,yi) where i = 1,2,...n.
% x, and y store the data point
% n is the number of data points in that set
% m represents m-th order polynomial least squares model
% output a is a vector stores the coefficients aj where j = 0,...m
% output ConNum is the condition number of Gram's matrix
% output theta is the generalized angle between the (k-1)th and kth column
% of matrix X
bigX = ones (n,m);
for k = 1:m
    for j = 1:n
        bigX (j,k) = x(j)^(k); % Create the X matrix
    end
end
LHS = transpose(bigX) * bigX;
RHS = transpose(bigX) * y;
a = LHS \ RHS;                 % Use the backslash command to find vector a 
ConNum = norm (LHS, Inf);      % Condition Number of Gram's matrix
T = dot(bigX(:,m),bigX(:,m));
B = (norm(bigX(:,m),2)* norm (bigX(:,m),2));
theta = acos (T/B);
end



