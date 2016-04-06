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
[a,ConNum,theta] = polylsq(x,y,nr,3);
disp(theta)
disp(a)
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
