% newtraph: Newton-Raphson root location zeroes
% uses Newton-Raphson method to find the root of func

func = @(x) tanh(x^2-9);           % name of function
dfunc = @(x) 2*x*(sech(9-x^2)^2);  % name of derivative of function
xr = 3.2;                          % initial guess
maxit = 4;                         % maximum allowbale iterations
es = 0.0001;                       % desired relative error

cell = {'Iteration','Previous estimate','New estimate','Percent approx error'};
iter = 0;                          % nmber of iterations

while (1)
    xrold = xr;
    cell{iter+2,2} = xr;
    xr = xr - func(xr)/dfunc(xr);
    iter = iter + 1;
    cell{iter+1,1} = iter;
    cell{iter+1,3} = xr;
    if xr ~= 0
        ea = abs((xr - xrold)/xr) * 100; % approximate relative error (%)
        cell{iter+1,4} = ea;
    end
    if ea <= es || iter >= maxit, break, end
end
root = xr;
disp (cell)
NRnew = cell2mat(cell(2:5,:));        %Convert to numeric values
figure (1)
plot (NRnew(1:4,1),NRnew(1:4,3))
xlabel('Iteration')
ylabel('New Estimate')
title ('Iteration vs. New Estimate')