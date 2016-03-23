% The script generates a Hilbert matrix H and multiply it by a vector of
% ones to get a vector b
% Then uses the backslash to get the solution and finds the maximum
% absolute error
% The code generates a plot to illustrate the relationship between the
% error and the condition number of a matrix
error = [];       % Generate a vector to store the error
CondNumber = [];  % Generate a vector to store the condition numbers
for k = 5:5:100       
    H = hilb (k); % Used MATLAB built-in command to generate the matrix H
    CondNumber = [CondNumber cond(H,inf)]; % We find condition number for matrix H
    actual = ones(k,1);
    b = H*actual;
    solution = H\b;
    error(k/5) = max(abs (actual-(solution)));
end
figure(1)
loglog(CondNumber,error,'-s')
hold on
title ('Condition Number of Hilbert matrix vs. True Absolute Error');
xlabel ('Condition Number of Hilbert matrix');
ylabel ('True Absolute Error');
hold off


