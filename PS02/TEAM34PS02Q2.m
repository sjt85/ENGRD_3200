% Gathers together tables of iterations and relative error
% Plots these

% Create function and derivative

fx = @(x) tan(pi*x) -x -6;
df = @(x) pi*(sec(pi*x))^2 -1;

% Get bisect data
[mass blah ea iter bsect]=bisect(fx,.4,.48,.001,100);
bsect1 = cell2mat(bsect(2:16,:)); %Convert to numeric values

% Get Newton-Raphson data
[root,ea,iter,nr] = newtraph(fx,df,0.48,.0001,25);
nr1 = cell2mat(nr(2:7,:)); %Convert to numeric values

% Get secant data
[y,sc] = secant(fx,0.54,.48,.0001);
sc1 = cell2mat(sc(2:12,:)); %Convert to numeric values

close all

figure(1)
semilogy(bsect1(:,1),bsect1(:,5),'-o')
hold on
plot(nr1(:,1),nr1(:,4),'-o')
plot(sc1(:,1),sc1(:,4),'-o')
legend('Bisect','Newton-Raphson','Secant')
xlabel('Iteration')
ylabel('log_{10}(Approx Error)')
ax = gca;
ax.XTick = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
grid on
box on
hold off