% Plot the average time to solve a linear system with Gaussian Elimination
% and LU factorization and back/forward substitution on the same plot
% versus N
% Plot the ratio of the time using Gaussian Elimination divided by the time
% using LU factorization versus N

N = [10 50 100 500 1000];
time_BF = [];
time_GE = [];
Ratio = [];
for k = 1:length(N)
    TotalTime1 = 0;
    TotalTime2 = 0;
    A = rand(N(k),N(k));    % Generate a random N * N matrix
    b = rand(N(k),1);       % Generate a random vector
    for j = 1:100           % Solve this linear system for 100 times
        tic
        x2 = A \ b;
        time_elapsed1 = toc;
        TotalTime1 = TotalTime1 + time_elapsed1;
        [L, U, P] = lu(A);
        tic
        x1 = U \ (L \ ( P * b));
        time_elapsed2 = toc;
        TotalTime2 = TotalTime2 + time_elapsed2;
    end
    AveGE = TotalTime1 / 100;     % Compute the average time for GE
    time_GE = [time_GE AveGE];    % Store the average time using GE method
    AveBF = TotalTime2 / 100;     % Compute the average time for BF
    time_BF = [time_BF AveBF];    % Store the average time using LU method
    ratio = AveGE / AveBF;        % Compute the ratio
    Ratio = [Ratio ratio];        % Store the ratio into this vector
end

% Part (c) of Question 2
figure
hold on
title ('Average time vs N')
xlabel('Size of the matrix (N by N)')
ylabel('Time to solve the linear system')
plot(N,time_GE,'-ro',N,time_BF,'-.b')
legend ('Gaussian Elimination','LU factorization')
hold off

% Part (d) of Question 2
figure (2)
plot (N, Ratio)
xlabel('Size of the matrix (N by N)')
ylabel('Ratio of time GE divided by time BF')
title ('Ratio of time used vs N')
