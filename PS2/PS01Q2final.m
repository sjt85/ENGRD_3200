% Part (a) of question 2
load noisy_tide
plot(t,f);            % Plot the 12-hr experimental data timeseries
xlabel('time-seconds')
ylabel('sea surface-meters')
title('time(seconds) vs sea surface elevation (meters)')

% Part (b) of question 2
% Use the centered finite difference approximation to compute the velocity
% at every point in sampled timeseries
df = zeros (1,43199);
h=1;
for i = 1+h:h:length(t)-h
    df(i-1) = (f(i+h)-f(i-h))/2*h;
end
figure(2)
hold on
%Find the analytical solution of velocity
analytical = -2*pi*sin(2*pi.*t/43201)/43201;
%Calculate the error for every time step
error = abs (analytical(2:length(analytical)-1)-df);
[maxerror,ind] = max(error);     %Find the maximum absolute error
subplot(2,1,1);
plot(t,analytical);
xlabel('sampled timeseries-seconds')
ylabel('velocity df/dt')
title('Analytical Solution')
subplot(2,1,2);
plot(t(2:length(t)-1),df);
xlabel('sampled timeseries-seconds')
ylabel('velocity df/dt')
title ('Computed solution')
fprintf('The maximum error with h=1 second is %d \n',maxerror);

% Part (d) of question 2
% Sample 50 equally spaced h values on logscale
% Find the optimal h value that minimizes the total error
hArray = [];
maxErrArray = [];
for h = logspace(0,4,50)
    k = 1;
    df = [];
    analytical = [];
    for i = (1+h):h:length(t)-h
        iplush = round(i+h);
        iminush = round (i-h);
        df(k) = (f(iplush)-f(iminush))/(2*h);
        analytical(k) = -2*pi*sin(2*pi*i/43201)/43201;
        k = k+1;
    end
    error = abs(df-analytical);
    maxerror = max(error);
    hArray = [hArray h];
    maxErrArray = [maxErrArray maxerror];
end
[B,I] = sort(maxErrArray);
optimalh = hArray(I(1));
fprintf('The optimal h value that minimizes the total error is %f seconds',optimalh);

% Generate the same plot as in part (b) but use the optimal h
h = optimalh;
NewT = [];
k = 1;
for i = 1+h:h:length(t)-h
    iplush = round (i+h);
    iminush = round (i-h);
    df(k) = (f(iplush)-f(iminush))/(2*h);
    NewT = [NewT i];
    k = k+1;
end
figure(2)
hold on
analytical = -2*pi*sin(2*pi.*t/43201)/43201;
figure(4)
subplot(2,1,1);
plot(t,analytical);
xlabel('sampled timeseries-seconds')
ylabel('velocity df/dt')
title('Analytical Solution')
subplot(2,1,2);
plot(NewT,df);
xlabel('sampled timeseries-seconds')
ylabel('velocity df/dt')
title('Computed Solution with optimal step h=409.4915s')

% Create the loglog plot of error as a function of h
figure (3)
loglog(hArray, maxErrArray)   
xlabel('Step Size')
ylabel('Error')
title ('Loglog Plot of Error Versus Step Size')

