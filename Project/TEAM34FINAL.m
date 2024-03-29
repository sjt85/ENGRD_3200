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

% Make spring and damper constants global so we can see them later

global k
global c

% Perform fit from function in PS05
% Polylsq was modified to force the curves to pass through (0,0)
[k,ConNum_k,theta_k] = polylsq(Fsp(2,:)',Fsp(1,:)',11,3);  %Cubic fit

[c,ConNum_c,theta_c] = polylsq(Fd(2,:)',Fd(1,:)',11,2);    %Quadratic fit

% Begin graphing spring and dashpot fits

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


% Perform first order linear fit on experimental spring and dashpot data
% in order to do the Laplace Transformation
[knew,ConNum_k,theta_k] = polylsq(Fsp(2,:)',Fsp(1,:)',11,1); % Linear fit

[cnew,ConNum_c,theta_c] = polylsq(Fd(2,:)',Fd(1,:)',11,1);  % Linear fit

knew_vals = knew(1) .* k_pts;
cnew_vals = cnew(1) .* c_pts;


figure(3)
hold on
scatter(Fsp(2,:),Fsp(1,:))
plot(k_pts,knew_vals)
box on
xlabel('Spring Displacement [m]')
ylabel('Spring Force [N]')
legend('Original Data','First Order Linear Fit','Location','NorthWest')
hold off

figure(4)
hold on
scatter(Fd(2,:),Fd(1,:))
plot(c_pts,cnew_vals)
box on
xlabel('Damper Velocity [m/s]')
ylabel('Damping Force [N]')
legend('Original Data','First Order Linear Fit','Location','NorthWest')
hold off


%%% Part 2:  Simulation %%%

% Vector x stores the initial conditions for Xu, Vu, Xs, Vs
x = [0 0 0 0];                     % V is the velocity
L = 5.2;  
V = 40;              % Velocity of the car
L = 5.2;               % Length
T = L/(V*1000/3600);
omega = pi/T;

% Run the simulation with two different step size h0, and h1
h0 = T/100;
number0 = 4/h0;
% h1 = T/200;
% number1 = 5*T/h1;
% Call the fourth-order Runge-Kutta function to solve a system of ODEs
% [t1,y1] = rk4sys(@dydtsys,linspace(0,5*T,number1),x,h1);



[t,y] = rk4sys(@dydtsys,linspace(0,4,number0),x,h0);
xs = y(:,1);

% Extract the solution for Vs into xsv
xsv = y(:,2);                 
xsa(1) = 0;
for j = 2:length(xsv)-1
    % Apply the finite difference formula
    % Store the acceleration in a vector xsa
    xsa(j) = (xsv(j)-xsv(j-1))/(h0);
end
MaxAcc = max(abs(xsa));

figure(5)
subplot(4,1,1),plot(t,y(:,3))
xlabel('Time [s]')
ylabel('Xu [m]')

subplot(4,1,2),plot(t,y(:,1))
xlabel('Time [s]')
ylabel('Xs [m]')

subplot(4,1,3),plot(t,y(:,4))
xlabel('Time [s]')
ylabel('Vu [m/s]')

subplot(4,1,4),plot(t,y(:,2))
xlabel('Time [s]')
ylabel('Vs [m/s]')


% figure(3)
% box on
% plot(t0,y0(:,1),'r',t1,y1(:,1))
% xlabel('Time [s]')
% ylabel('Displacement of Sprung Mass [m]')
% legend('Step Size T/100','Step Size T/200','Location','NorthEast')
% hold off
% 
% hold on
% figure(4)
% box on
% plot(t0,y0(:,3),'r',t1,y1(:,3))
% xlabel('Time [s]')
% ylabel('Displacement of Unsprung Mass [m]')
% legend('Step Size T/100','Step Size T/200','Location','NorthEast')
% hold off

%%% Forward Euler %%%
% Show Euler solution at first stable stepsize

[t_euler,y_euler] = ForwardEuler(@dydtsys,4,[0,0,0,0],T/120);

figure(6)
subplot(4,1,1),plot(t_euler,y_euler(:,3))
set(gca,'xticklabel',[])
ylabel('X_u [m]')

subplot(4,1,2),plot(t_euler,y_euler(:,1))
set(gca,'xticklabel',[])
ylabel('X_s [m]')

subplot(4,1,3),plot(t_euler,y_euler(:,4))
set(gca,'xticklabel',[])
ylabel('V_u [m/s]')

subplot(4,1,4),plot(t_euler,y_euler(:,2))
xlabel('Time [s]')
ylabel('V_s [m/s]')


%%% Compare Forward Euler and RK4 %%%

% Find stepsize needed to reduce error to 10^-3

% Get the basis off of which to compare
    % If all we're interested in is x(2*T), that's all the further we need
    % to evaluate
    
% Make sure we're evaluating at 40 kph

T = 5.2/(40*1000/3600);
    
[t_rk,y_rk] = rk4sys(@dydtsys,[0,2*T],[0,0,0,0],T/50);

error = 1;  % Initialize
h = T/108;

clear t_euler y_euler

while error
    % Diminish the stepsize, find new error
    h = h*.9;
    [t_euler,y_euler] = ForwardEuler(@dydtsys,2*T,[0,0,0,0],h);
    errors = abs(y_rk(length(t_rk),:) - y_euler(length(t_euler),:));
    error = max(errors) > 10^(-3);
end

disp(h)

%%% Find Zero Crossing %%%

% Start first at 10 kph
% Clear old rk4 data
clear t_rk y_rk T
T = 5.2/(10*1000/3600);

% Solve the ODE real quick
[t_rk,y_rk] = rk4sys(@dydtsys10,[0,4],[0,0,0,0],T/100);

% Package up the 6 data points around our crossing
sampled_t = transpose(t_rk(1,99:104));
sampled_x = y_rk(99:104,1);

params = {sampled_t,sampled_x,5};

% Use bisection and interpolation to find root
root = bisect(@interphomecooked,sampled_t(1),sampled_t(6),.001,50,params);


fprintf('The first zero crossing for the sprung mass at 10 kph is at %f seconds \n',root)


% Now simulate at 40 kph

% Clear old rk4 data
clear t_rk y_rk T
T = 5.2/(40*1000/3600);

% Solve the ODE real quick
[t_rk,y_rk] = rk4sys(@dydtsys40,[0,4],[0,0,0,0],T/50);

% Package up the 6 data points around our crossing
sampled_t = transpose(t_rk(1,57:62));
sampled_x = y_rk(57:62,1);

params = {sampled_t,sampled_x,5};

% Use bisection and interpolation to find root
root = bisect(@interphomecooked,sampled_t(1),sampled_t(6),.001,50,params);


fprintf('The first zero crossing for the sprung mass at 40 kph is at %f seconds \n',root)


%%% Compute how much energy is lost due to damping %%%

% First simulate at 10 kph

% Clear old rk4 data
clear t_rk y_rk T
T = 5.2/(10*1000/3600);

% Solve the ODE real quick
[t_rk,y_rk] = rk4sys(@dydtsys10,[0,T],[0,0,0,0],T/100);

delta_x = y_rk(:,2) - y_rk(:,4);
F_d = c(1)*delta_x + c(2) * delta_x .^2;
Fd_deltax = F_d .* delta_x;
energy_trap = trapz(transpose(t_rk),Fd_deltax);
energy_simp = simpson(transpose(t_rk),Fd_deltax);

fprintf('Energy using trapz at 10 kph is %f \n',energy_trap);
fprintf('Energy using simpson at 10 kph is %f \n',energy_simp);


% Now simulate at 40 kph

% Clear old rk4 data
clear t_rk y_rk T F_d Fd_deltax
T = 5.2/(40*1000/3600);

% Solve the ODE real quick
[t_rk,y_rk] = rk4sys(@dydtsys40,[0,T],[0,0,0,0],T/50);

delta_x = y_rk(:,2) - y_rk(:,4);
F_d = c(1)*delta_x + c(2) * delta_x .^2;
Fd_deltax = F_d .* delta_x;
energy_trap = trapz(transpose(t_rk),Fd_deltax);
energy_simp = simpson(transpose(t_rk),Fd_deltax);

fprintf('Energy using trapz at 40 kph is %f \n',energy_trap);
fprintf('Energy using simpson at 40 kph is %f \n',energy_simp);



 end

