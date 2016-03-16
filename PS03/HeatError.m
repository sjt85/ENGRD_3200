function [] = HeatError()

% Forms the tridiagonal matrix A
% Uses the previously-developed LU factorization and substitution methods
% to solve this matrix
% Finds the associated error norm
% Solves using the Thomas algorithm and compares

ErrMatrix = zeros(2,9);   % Set up a matrix to store N vs. max error
ErrMatrix(1,:) = [5 10 20 40 80 200 500 1000 2000];

for j = 1:length(ErrMatrix(1,:))  % Populate error matrix
    N = ErrMatrix(1,j);
    [A,b,x_exact] = formA(N);     % Call subroutine to construct A
    
    % Gauss
    xg = A\b;
    xg_err = abs(x_exact - xg);
    xg_err_max = max(xg_err);
    
    % LU
    [L,U,P] = lu(A);
    xlu = U \ ( L \ ( P * b ) );
    xlu_err = abs(x_exact - xlu);
    xlu_err_max = max(xlu_err);
    
    ErrMatrix(2,j) = max(xg_err_max,xlu_err_max);
end

close all
figure(1)
loglog(ErrMatrix(1,:),ErrMatrix(2,:),'-s')
hold on
xlabel('Number of nodes (N)')
ylabel('Absolute error E_t^{(max)}')
legend('Error from LU and Gauss elimination')
grid on
hold off






function [A,b,x] = formA(N)
% Subroutine for heat equation matrix
% Creates the tridiagonal matrix A found using the heat equation
% Creates the RHS vector b from the sine function
% Returns the exact solution as a vector x
% N is the number of nodes

A = zeros(N-1,N-1);  % Initialize matrix with all zeros
b = zeros(N-1,1);      % Initialize RHS vector
x = zeros(N-1,1);      % Initialize exact solution
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

end


