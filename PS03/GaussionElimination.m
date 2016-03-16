% The code calculates the time it takes to solve Ax = b using Gaussian
% Elimination

N = [10 50 100 500 1000];
time_GE = [];
for k = 1:length(N)
    TotalTime = 0;
    A = rand (N(k),N(k));     % Generate a random N * N matrix
    b = rand(N(k),1);         % Generate a random vector
    for j = 1:100             % Solve this linear system for 100 times
        tic
        x = A \ b;
        time_elapsed = toc;
        TotalTime = TotalTime + time_elapsed;
    end
    Ave = TotalTime / 100;    % Compute the average time
    time_GE = [time_GE Ave];  % Store the average time in this vector
end
