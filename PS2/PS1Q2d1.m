%
hArray = [];
maxErrArray = [];
for h = logspace(0,4,50)
    k = 1;
    df = [];
    analytical = [];
    for i = (1+h):h:length(t)-h
        iplush = round (i+h);
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
disp(optimalh)
loglog(hArray, maxErrArray)
