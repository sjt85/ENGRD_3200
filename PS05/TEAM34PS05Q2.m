function TEAM34PS05Q2
% This function loads the daaset that represents what a tidal gauge
% measures on a windy day and draws a scatter plot of the data with the
% least-squares fit overlaid on top of the data

load ('noisier_tide')
close all

figure
hold on
box on
xlabel ('Time')
ylabel('Change in the Sea Level')
title('Time vs. Change in the Sea Level')
scatter(x,y)             % Generate a scatter plot of the data points
[nr,nc] = size(x);
[a,ConNum,theta] = polylsq(x,y,nr,3);
fprintf('The angle theta between the last two columns is %s \n',theta)
Reala = [-11 55/3 -17/2 7/6];
PredY = polyval(flip(a),x);
plot(x,PredY)            % Plot the least squares fit

% Create a vector that stores the absolute error for each of the polynomial
% fit coefficients with respect to the given coefficients
if length(a) == length (Reala)
AbsError = zeros(length(a),1);
for j = 1:length(a)
    AbsError(j) = abs(a(j)-Reala(j));
end
end

end
