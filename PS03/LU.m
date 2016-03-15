% The code calculates the time it take to solve Ax = b using LU
% factorization and back/forward substitution via MATLAB's LU factorization
% function lu()
N = [10 50 100 500 1000];
time_BF = [];
for k = 1:length(N)
    TotalTime = 0;
    for j = 1:100
        A = rand(N(k),N(k));
        b = rand(N(k),1);
        [L, U, P] = lu(A);
        tic
        x = U \ (L \ ( P * b));
        time_elapsed = toc;
        TotalTime = TotalTime + time_elapsed;
    end
    Ave = TotalTime / 100;
    time_BF = [time_BF Ave];
end
