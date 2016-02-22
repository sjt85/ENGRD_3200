function [ n ] = TEAMPS00Q3(x,acceptable_error)
%Inputs x for ln(x) about base point of x = 1 and acceptable relative error
%Computes Taylor series and compares to known solution, returns degree of
%polynomial required to achieve the desired error

actual = log(x);
n = 0;
y = 0;
error = 100; %Initialize error as huge

while error > acceptable_error  %Run until error is within limit
    n = n+1;
    y = y + ((-1)^(n+1)*(x-1)^n)/n;
    error = abs(actual - y)/actual;
    
end

    
end