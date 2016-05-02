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
[k,ConNum_k,theta_k] = polylsq(Fsp(2,:),Fsp(1,:),11,3);  %Cubic fit

[c,ConNum_c,theta_c] = polylsq(Fd(2,:),Fd(1,:),11,2);    %Quadratic fit


end