function  TEAM34PS07Q2
Depth = [0 0.5 1 1.5 2 2.5 3];
Temp = [70 70 55 22 13 10 10];
DD = linspace(Depth(1),Depth(length(Depth)));
[yy,dy,d2] = natspline(Depth,Temp,DD);

subplot(1,3,1),plot(Temp,Depth,'o',yy,DD) 
title('(a) T')
legend('data','T','Location','SouthEast') 
set(gca,'YDir','reverse'),grid 

subplot(1,3,2),plot(dy,DD) 
title('(b) dT/dz') 
set(gca,'YDir','reverse'),grid 

subplot(1,3,3),plot(d2,DD)
title('(c) d2T/dz2') 
set(gca,'YDir','reverse'),grid

figure
x = [DD(41),DD(42)];
dT2 = [d2(41),d2(42)];
dT0 = [0 0];

plot(dT2,x)
hold on
plot(dT0,x)
hold off
end