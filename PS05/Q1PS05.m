% year =[0 1 2 3 4 5 6 7 8 9 10]; 
CDs = [0 0.8 5.8 23 53 102 150 207 287 333 408];
LPs = [244 210 205 167 125 107 72 35 12 4.8 2.3];
logLPs = log(LPs);
logLPs = transpose(logLPs);
X = [1 1 1 1 1 1 1 1 1 1 1; 0 0.8 5.8 23 53 102 150 207 287 333 408];
X = transpose (X);
Xt = transpose (X);
G = Xt*X;
a = inv(Xt*X) * Xt * logLPs;
C = 800;
LP = exp(5.5285) * (exp(-0.0110))^800;
disp(LP)
figure
semilogy(CDs,LPs)

hold on
scatter(CDs,LPs)
box on
grid on

xlabel('Sales of Compact Discs')
ylabel('Log of Vinyl Long Playing Records')
title ('Semilog Y Plot of CDs vs LPs over an eleven year period')

x = linspace (0,500,500);
y = 5.528 + x * (-0.0110);
y1 = exp(5.5285) * (exp(-0.0110)).^x;

plot(x,y1)
hold off

