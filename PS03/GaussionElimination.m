% The code calculates the time it takes to solve Ax = b using Gaussian
% Elimination
N = [10 50 100 500 1000];
time_GE = [];
for k = 1:length(N)
    TotalTime = 0;
    for j = 1:100
    A = rand(N(k),N(k));
    b = rand(N(k),1);
    tic
    x = A \ b;
    time_elapsed = toc;
    TotalTime = TotalTime + time_elapsed;
    end
    Ave = TotalTime / 100;
    time_GE = [time_GE Ave];
end
    