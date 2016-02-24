%
plot(t,f);
xlabel('time-seconds')
ylabel('sea surface-meters')
title('time(seconds) vs sea surface elevation (meters)')
df = zeros (1,43199);
h=1;
% Use the centered finite difference approximation to compute the velocity
% at every point in sampled timeseries
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
subplot(2,1,2);
plot(t(2:length(t)-1),df);
xlabel('sampled timeseries-seconds')
ylabel('velocity df/dt')