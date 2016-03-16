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
    for j = 1:100
        A = rand(N(k),N(k));
        b = rand(N(k),1);
        tic
        [L, U, P] = lu(A);
        time_elapsed1 = toc;
        FactTime = FactTime + time_elapsed1;
        tic
        x = U \ (L \ ( P * b));
        time_elapsed2 = toc;
        SubTime = SubTime + time_elapsed2;
    end
    FactAve = FactTime/ 100;
    SubAve = SubTime / 100;
    time_BF = [time_BF SubAve];
    time_Fact = [time_Fact FactAve];
    Ratio = [Ratio FactAve / SubAve];
end
figure
plot(N,time_BF,'-ro',N,time_Fact,'-.b')
legend ('back/forward substitution time','LU factorization time')

figure(2)
plot(N,Ratio)