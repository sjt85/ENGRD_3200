% The code calculates the time it take to solve Ax = b using LU
% factorization and back/forward substitution via MATLAB's LU factorization
% function lu()

% time_BF stores the average time needed for MATLAB to do back/forward
% substitution

% time_Fact stores the average time needed for MATLAB to do LU
% factorization

% Ratio stores the ratio of the time taken to compute LU factorization vs.
% back/forward substitution

N = [10 50 100 500 1000];
time_Fact = [];
time_BF = [];
Ratio = [];
for k = 1:length(N)
    FactTime = 0;
    SubTime = 0;
    A = rand(N(k),N(k));        % Generate a random N * N matrix
    b = rand(N(k),1);           % Generate a random vector
    for j = 1:100               % Solve this linear system for 100 times
        tic
        [L, U, P] = lu(A);
        time_elapsed1 = toc;    % Time used for factorization
        FactTime = FactTime + time_elapsed1;
        tic
        x = U \ (L \ ( P * b));
        time_elapsed2 = toc;    % Time used for substitution
        SubTime = SubTime + time_elapsed2;
    end
    FactAve = FactTime/ 100;    % Compute the average time for factorization
    SubAve = SubTime / 100;     % Compute the average time for substitution
    time_BF = [time_BF SubAve];
    time_Fact = [time_Fact FactAve];
    Ratio = [Ratio FactAve / SubAve]; % Compute the ratio
end
figure
box on
plot(N,time_BF,'-ro',N,time_Fact,'-.b')
title ('Average time vs N')
legend ('back/forward substitution time','LU factorization time')
xlabel('Size of the matrix (N by N)')
ylabel('Time to solve the linear system')

figure(2)
box on
plot(N,Ratio)
xlabel('Size of the matrix (N by N)')
ylabel('Ratio of Factorization time divided by Substitution time')
title ('Ratio of time used vs N')
