x = linspace (0,5,50);
y = 1./x;
N0 = x*0+1;
N1 = 1-(x-1);
N2 = 1-(x-1)+(x-1).^2;
figure
plot(x,y,x,N0,x,N1,x,N2)
xlabel('x')
ylabel('function value')
legend('Original Function','N = 0','N = 1','N = 2')
N3 = 1-(x-1)+(x-1).^2-(x-1).^3;
N4 = 1-(x-1)+(x-1).^2-(x-1).^3+(x-1).^4;
figure
plot(x,y,x,N2,x,N3,x,N4)
xlabel('x')
ylabel('function value')
legend('Original Function','N = 2','N = 3','N = 4')
T2 = 1/2*(x.^2-6.5*x+10)-(1/0.75/2.5)*(x.^2-6*x+8)+1/12*(x.^2-4.5*x+5);
figure
plot(x,y,x,N2,x,T2)
xlabel('x')
ylabel('function value')
legend('Original Function','Taylor Interpolation with N = 2','Lagrange form with N = 2')
