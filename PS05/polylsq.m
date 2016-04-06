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


