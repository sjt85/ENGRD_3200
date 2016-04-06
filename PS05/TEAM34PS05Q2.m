function TEAM34PS05Q2
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load ('noisier_tide')
figure
hold on
scatter(x,y)
[nr,nc] = size(x);
[a,ConNum] = polylsq(x,y,nr,3);
PredY = zeros(nr,1);
Reala = [-11 55/3 -17/2 7/6];
for k = 1:1:nr
PredY(k) = a(1)+a(2)*x(k)+a(3)*x(k)^2+a(4)*x(k)^3;
end
plot(x,PredY)
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
bigX = ones (n,m+1);
for k = 2:m+1
    for j = 1:n
        bigX (j,k) = x(j)^(k-1);
    end
end
LHS = transpose(bigX) * bigX;
RHS = transpose(bigX) * y;
a = LHS \ RHS;
ConNum = norm (LHS, Inf);

end
