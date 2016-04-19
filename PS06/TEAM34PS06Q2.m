function [fout] = TEAM34PS06Q2
% Sets up the problem
% Calls subroutine to compute the lagrange IP and plot everything


xdata = [5.88; 12.3; 27.3; 45.8; 69.6; 100];  %phi
f_i = [0.995; 0.98; 0.92; 0.83; 0.726; 0.617]; %c_p
n = 5;
xout = linspace(10,100,19);

fout = interphomecooked(xdata,f_i,n,xout);


end