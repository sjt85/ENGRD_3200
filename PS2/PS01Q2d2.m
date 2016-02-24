% 
h = 409.4915;
NewT = [];
k = 1;
% Use the centered finite difference approximation to compute the velocity
% at every point in sampled timeseries
for i = 1+h:h:length(t)-h
    iplush = round (i+h);
    iminush = round (i-h);
    df(k) = (f(iplush)-f(iminush))/(2*h);
    NewT = [NewT i];
    k = k+1;
end
figure(2)
hold on
%Find the analytical solution of velocity
analytical = -2*pi*sin(2*pi.*t/43201)/43201;

subplot(2,1,1);
plot(t,analytical);
xlabel('sampled timeseries-seconds')
ylabel('velocity df/dt')
title('Analytical solution')
subplot(2,1,2);
plot(NewT,df);
xlabel('sampled timeseries-seconds')
ylabel('velocity df/dt')
title('computed solution with optimal step h')