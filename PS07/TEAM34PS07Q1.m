function TEAM34PS07Q1
Temp = [100 200 300 400 500 600];
ThermCon = [9.4 18.4 26.2 33.3 39.7 45.7];
PTherm = [];
NewTemp = [];
for k = 50:50:600
    NewTemp = [NewTemp k];
    Predicted = Newtint(Temp,ThermCon,k);
    PTherm = [PTherm Predicted];
end
disp(PTherm)
figure
hold on
box on
xlabel('Temperature (K)')
ylabel('Thermal Conductivity (m W/m*K)')
plot(Temp,ThermCon)
plot(NewTemp,PTherm)
legend ('Original six points','Newton Interpolating Polynomial')
hold off
% Part (C)
NTemp = [100 200 300 400 500 600 150];
NThermCon = [9.4 18.4 26.2 33.3 39.7 45.7 13.9];
Conductivity125 = Newtint(NTemp,NThermCon,125);
disp(Conductivity125)

end
function yint = Newtint(x,y,xx)
% Newtint: Newton interpolating polynomial
% yint = Newtint(x,y,xx): Uses an (n - 1)-order Newton
% interpolating polynomial based on n data points (x, y) to determine a value of the dependent variable (yint) at a given value of the independent variable, xx.
% input:
% x = independent variable
% y = dependent variable
% xx = value of independent variable at which
% interpolation is calculated
% output:
% yint = interpolated value of dependent variable

% compute the finite divided differences in the form of a
% difference table
n = length(x);
if length(y)~=n, error('x and y must be same length'); end
b = zeros(n,n);
% assign dependent variables to the first column of b.
b(:,1) = y(:); % the (:) ensures that y is a column vector.
for j = 2:n
    for i = 1:n-j+1
        b(i,j) = (b(i+1,j-1)-b(i,j-1))/(x(i+j-1)-x(i));
    end
end
% use the finite divided differences to interpolate 
xt = 1;
yint = b(1,1);
for j = 1:n-1
    xt = xt*(xx-x(j));
    yint = yint+b(1,j+1)*xt;
end
end

