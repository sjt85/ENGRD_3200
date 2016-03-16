% Forms the tridiagonal matrix A
% Uses the previously-developed LU factorization and substitution code 
% to solve this matrix
% Finds the associated error norm
% Solves using the Thomas algorithm and compares




function [A b x] = formA(N)
% Creates the tridiagonal matrix A found using the heat equation
% Creates the RHS vector b from the sine function
% Returns the exact solution as a vector x
% N is the number of nodes

A = zeros(N-1,N-1);  % Initialize matrix with all zeros
b = zeros(N-1);      % Initialize RHS vector
x = zeros(N-1);      % Initialize exact solution
h = 1/N;

% Form the diagonal
for i = 1 : N-1 
    A(i,i) = 2;
end

% Form the subdiagonal and superdiagonal
for i = 1 : N-2
    A(i+1,i) = -1;   % Subdiagonal
    A(i,i+1) = -1;   % Superdiagonal
end

% Form RHS vector and exact solution
for i = 1 : N-1
    b(i) = h^2 * sin(pi*h*i);
    x(i) = sin(pi*h*i)/pi^2;
end



end


