function TEAM34PS08Q2
% The function uses composite Gauss-Legendre quadrature,
% with 2 and 4 points to approximate this integral.
f = @(x) 1/(1+x^2);

% Store the estimation values for different number of total subintervals
pt2Est = zeros(1,36);
pt4Est = zeros(1,36);

% Two weighing factors for two-point formula
pt2c0 = 1;
pt2c1 = 1;

% Two x positions for two-point formula
pt2x0 = -1/sqrt(3);
pt2x1 = 1/sqrt(3);

% Four weighing factors for four-point formula
pt4c0 = (18-sqrt(30))/36;
pt4c1 = (18+sqrt(30))/36;
pt4c2 = (18+sqrt(30))/36;
pt4c3 = (18-sqrt(30))/36;

% Four x positions for four-point formula
pt4x0 = -(sqrt(525+70*sqrt(30)))/35;
pt4x1 = -(sqrt(525-70*sqrt(30)))/35;
pt4x2 = (sqrt(525-70*sqrt(30)))/35;
pt4x3 = (sqrt(525+70*sqrt(30)))/35;

index = 0;

% n is the number of subintervals
for n = 20:4:160
    step = 1/n;      % length of each subinterval
    index = index + 1;
    for k = 0:step:1-step
        
        % lower and upper bound at each step
        lower = k;
        upper = k+step;
        
        % Perform a change of variable to find the new fx
        newdx = (upper-lower)/2;
        interfx = @(x) f(((upper+lower)+(upper-lower)*x)/2);
        newfx = @(x) newdx*interfx(x);
        
        % Use two-point forumual to find the current estimate
        pt2Curr = pt2c0*newfx(pt2x0)+ pt2c1*newfx(pt2x1);
        
        % Use four-point formula to find the current estimate
        pt4Curr = pt4c0*newfx(pt4x0) + pt4c1*newfx(pt4x1)+...
            pt4c2*newfx(pt4x2) + pt4c3*newfx(pt4x3);
        
        % Add up the estimation value for each subinterval
        pt2Est(index) = pt2Est(index) + pt2Curr;
        pt4Est(index) = pt4Est(index) + pt4Curr;
    end
end


end

