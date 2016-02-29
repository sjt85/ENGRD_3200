% Gathers together tables of iterations and relative error
% Plots these

% Create function and derivative

fx = @(x) tan(pi*x) -x -6;
df = @(x) pi*(sec(pi*x))^2 -1;

% Get bisect data
[mass blah ea iter bsect]=bisect(fx,.4,.48,.001,100);

% Get Newton-Raphson data
[root,ea,iter,nr] = newtraph(fx,df,0.48,.0001,25);

% Get secant data
[y,sc] = secant(fx,0.54,.48,.0001);

figure(1)
hold on
scatter(cell2mat(bsect{2:16,1}),cell2mat(bsect{2:16,5}))
scatter(nr{2:7,1},nr{2:7,4})
scatter(sc{2:10,1},sc{2:10,4})
hold off