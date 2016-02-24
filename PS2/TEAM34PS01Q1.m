% Find the smallest distance h from pi/4 that has a relative error smaller
% than 10^-6
h = 0.2;                                    %start with h=0.2
actual = cos(pi/4);                         %compute the actual value
computed = (sin(pi/4+h)-sin(pi/4))/h;       %use the forward finite difference formula
error = abs((computed - actual)/actual);
while error > 1*10^(-6)
    h=h/10;
    computed = (sin(pi/4+h)-sin(pi/4))/h;
    error = abs((computed - actual)/actual);
end
disp(h)

