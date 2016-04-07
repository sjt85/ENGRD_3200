function TEAM34PS05Q3
% This function finds the least squares curve fitting with Sine/Cosine

Days = zeros (12,1);
for k = 1:12
    Days(k) = 30*(k-1)+15;
end
Rad = [144; 188; 245; 311; 351; 359; 308; 287; 260; 211; 159; 131];


% Generate the matrix X
X = ones (12,3);
for j = 1:12
    X(j,2) = cos((1/360) * Days(j));
    X(j,3) = sin((1/360) * Days(j));
end
LHS = transpose(X) * X;
RHS = transpose(X) * Rad;
a = LHS \ RHS;            % Use the backslash to find vector a

Time = linspace(1,360,360);
Pred = a(1)+a(2)*cos(1/360*Time)+a(3)*sin(1/360*Time);

% Augsix represents the number of days of Aug 6th
Augsix = 7*30+6;
PreRad = a(1)+a(2)*cos(1/360*Augsix)+a(3)*sin(1/360*Augsix);
fprintf('The predicted radiation on the 6th of August is %s W/m^2 \n',PreRad)

close all

figure
hold on
box on
xlabel ('Time in Days')
ylabel('Solar Radiation in Tucson, Arizona')
title('Time vs. Solar Radiation')
scatter(Days,Rad)   % Generate a scatter plot of the data sets
plot(Time,Pred)  %Plot the the least squares fit of the function
hold off

end

