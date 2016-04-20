function [fout] = TEAM34PS06Q2
% Sets up the problem
% Calls subroutine to compute the lagrange IP and plot everything


xdata = linspace(1,11);  %time
f_i = [65.7; 84.8; 78.2; 78; 94.1; 82.9; 81.9; 95.8; 71.9; 86.9; 88.3]; %temperature
n = length(f_i) -1;
xout = linspace(1,11,21);

c_p = interphomecooked(xdata,f_i,n,xout);
fout = zeros(2,length(xout));
fout(1,:) = transpose(xout);
fout(2,:) = transpose(c_p);



end