% Plot the average time to solve a linear system with Gaussian Elimination
% and LU factorization and back/forward substitution on the same plot
% versus N
N = [10 50 100 500 1000];
time_BF = [];
time_GE = [];
for k = 1:length(N)
    TotalTime1 = 0;
    TotalTime2 = 0;
    for j = 1:100
        A = rand(N(k),N(k));
        b = rand(N(k),1);
        [L, U, P] = lu(A);
        tic
        x1 = U \ (L \ ( P * b));
        time_elapsed1 = toc;
        TotalTime1 = TotalTime1 + time_elapsed1;
        tic
        x2 = A \ b;
        time_elapsed2 = toc;
        TotalTime2 = TotalTime1 + time_elapsed2;
    end
    Ave1 = TotalTime1 / 100;
    time_BF = [time_BF Ave1];
    Ave2 = TotalTime2 / 100;
    time_GE = [time_GE Ave2];
end
figure
title ('Average time vs N')
xlabel('Size of the matrix')
ylabel('Time to solve the linear system')
plot(N,time_GE)
hold on
plot(N,time_BF)
hold off
