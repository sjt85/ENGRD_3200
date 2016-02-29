% It will take function and initial value as the input of function. 
% a, b are two initial guesses
% maxerr is the acceptable approximate relative error
% The function returns y and cell, where y is the root to the function
% cell is a cell array which stores the number of iteration, previous
% estimate, new estimate and relative error

function [y,cell] = secant(f,a,b,maxerr)
c = (a*f(b) - b*f(a))/(f(b) - f(a));
iter = 1;       
cell = {'Iteration','Previous estimate','New estimate','Relative error'};
while abs(f(c)) > maxerr
    a = b;
    b = c;
    c = (a*f(b) - b*f(a))/(f(b) - f(a));
    cell{iter+1,1} = iter;
    cell{iter+1,2} = a;
    cell{iter+1,3} = b;
    cell{iter+1,4} = abs(f(c));
    iter = iter + 1;
    if(iter == 25)
        break;
    end
end
y = c;