function TEAM34PS05Q2
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load ('noisier_tide')
[nr,nc] = size(x);
a = polylsq(x,y,nr,3);

end


function a = polylsq(x,y,n,m)
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
        [p,q] = size(y)
        [pp,qq] = size(bigX)
%         a = y / bigX;
%         Gram = transpose(bigX) * bigX;
%         ConNum = norm (Gram, Inf);
%         figure one
%         scatter(x,y)     
        
    end

