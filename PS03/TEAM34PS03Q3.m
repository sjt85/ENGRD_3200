function [ ] = TEAM34PS03Q3(N)
%Calls Tridiag to perform the Thomas algorithm
%   N is number of nodes
%   Uses vectors of length N even though this is wrong

% Setting up inputs
e = zeros(N,1);  %Subdiagonal
e(:) = -1;
f = zeros(N,1);  %Diagonal
f(:) = 2;
g = zeros(N,1);  %Superdiagonal
g(:) = -1;

% Form RHS vector and exact solution
r = zeros(N,1);
x_exact = zeros(N,1);
h = 1/N;
for i = 1 : N
    r(i) = h^2 * sin(pi*h*i);
    x_exact(i) = sin(pi*h*i)/pi^2;
end

r_err = abs(x_exact - r);
r_err_max = max(r_err);

fprintf('The maximum error for N = %6.0f is %2.2s \n',N,r_err_max);

end

