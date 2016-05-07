function [ ] = TEAM34FINAL( )
% Master function for ENGRD 3200 Final Project
% Is broken into 3 parts:
%   1)  Quarter Car Model
%   2)  Simulation
%   3)  Data Analysis


%%% Part 1:  Quarter Car Model %%%

% Perform least squares fit on experimental spring and dashpot data

% Bring in experimental data
load('springforce.mat')
load('dampingforce.mat')

% Perform fit from function in PS05
% Polylsq was modified to force the curves to pass through (0,0)
[k,ConNum_k,theta_k] = polylsq(Fsp(2,:)',Fsp(1,:)',11,3);  %Cubic fit

[c,ConNum_c,theta_c] = polylsq(Fd(2,:)',Fd(1,:)',11,2);    %Quadratic fit

% Begin graphing

k_pts = linspace(-.11,.11,300);
c_pts = linspace(-1.1,1.1,300);

k_vals = k(1) .* k_pts + k(2) .* k_pts .^2 + k(3) .* k_pts .^3;
c_vals = c(1) .* c_pts + c(2) .* c_pts .^2;

close all
figure(1)
hold on
scatter(Fsp(2,:),Fsp(1,:))
plot(k_pts,k_vals)
box on
xlabel('Spring Displacement [m]')
ylabel('Spring Force [N]')
legend('Original Data','Least Squares Cubic Fit','Location','NorthWest')
hold off

figure(2)
hold on
scatter(Fd(2,:),Fd(1,:))
plot(c_pts,c_vals)
box on
xlabel('Damper Velocity [m/s]')
ylabel('Damping Force [N]')
legend('Original Data','Least Squares Quadratic Fit','Location','NorthWest')
hold off

%%%
[t y1 y2 y3 y4] = rk4sys(@dydtsys,[0,100],
end

function xdot = dydtsys(x,t)
%You cannot change function name
%
ms = 236.12;
mu = 23.61;
kt = 181818.88;
ct = 13.854;
V = 40;
% % %  T = 
if t>T;
    qdot = 0;
    q = 0;
else
    qdot= 0.1 * pi/(5.2/V*1000/3600)* cos(pi/(5.2/V*1000/3600)*t);
    q = 0.1 * sin(pi/(5.2/V*1000/3600)*t);
end
Fsp = 0.0124 * ((x(3)-x(1)) + (-0.0737) * ((x(3)-x(1))^2 + 3.1704 * ((x(3)-x(1))^3;
Fd = 905.2896 * ((x(3)-x(1)) + 254.2550 * ((x(3)-x(1))^2;

xdot(1,1)=x(2);
xdot(2,1)=-1/ms*(Fsp+Fd);
xdot(3,1)=x(3);
xdot(4,1)=(1/mu)*(kt*(q-x(1))+ct*(qdot-x(2))+Fsp+Fd);

end