function fout = interphomecooked(xdata,f,n,xout)
% Computes and plots the Lagrange form of the global interpolating
% polynomial
% Computes Lagrange interpolant functions for an arbitrary dataset
% Plots L_N,i for i = 0,1,2 and i = 3,4,5
% Plots the global interpolating polynomial along with original data
% Performs a second run, sampling at xout and returns xdata


% Set up spacing for use with the plots to have 200 points
x_points = linspace(xdata(1),xdata(length(xdata)),200);

% Evaluate those Lagrange interpolant functions at the x_points
% Set up a matrix to contain these values, where the column vector
% L(:,j+1) corresponds to L_n,j

L_matrix = zeros(length(x_points),n+1);

for j = 0:n
   for k = 1:length(x_points)
       L_matrix(x_points(k),j+1) = Lagrange(xdata,x_points(k),j);
   end
end



end




function L = Lagrange(x_vect,x_new,j)
% Computes the value of the Lagrange interpolant term L_n,j at x_new 
% based off of the values in x_vect

n = length(x_vect);
num = 1;
den = 1;

for i = 1:n
    if i ~= j
        num = num*(x_new - x_vect(i));
        den = den*(x_vect(j) - x_vect(i));
    end
end

L = num/den;

end