%%% Generates plot comparing Lagrange global IP and spline
% PS07 question 3


% Set up the data
x = linspace(1,11,11);  % Given
y = [65.7; 84.8; 78.2; 78; 94.1; 82.9; 81.9; 95.8; 71.9; 86.9; 88.3];

t = linspace(1,11,501); % Desired

% Compute Lagrange IP
n = length(x) -1;
lagrange = interphomecooked(x,y,n,t);

% Compute spline fit
[spline,dy,d2] = natspline(x,y,t);

% Plot everything

close all
figure
hold on
box on
grid on
scatter(x,y);
plot(t,lagrange,t,spline,'g')
xlabel('Time')
ylabel('Temperature [^0F]')
axis([0 12 20 160]);
ax = gca;
ax.XTick = [0 x 12];
ax.XTickLabel = {'','1pm','2pm','3pm','4pm','5pm','6pm','7pm','8pm','9pm','10pm','11pm',''};
legend('Original data','Lagrange global IP','Cubic spline','Location','NorthWest')
hold off