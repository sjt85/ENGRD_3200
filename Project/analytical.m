% Experimenting with laplace transforms

clear E
% Define symbolic variables
syms k m c omega A mu kt ct d real
syms x(t) y(t) Q s

% Set up our equations
delta_x(t) = x(t)-y(t);
Fsp(t) = k*delta_x(t); % + k2*delta_x(t).^2 + k3*delta_x(t).^3;
Fd(t) = c*(diff(x(t),t)-diff(y(t),t)); %+ c2*(diff(x(t),t)-diff(y(t),t)).^2;
f1(t) = m*diff(diff(x(t),t),t) + Fsp(t) + Fd(t);
f2(t) = mu*diff(diff(y(t),t),t) - Fsp(t) - Fd(t) - kt*(q(t) - y(t)) + ...
    ct*(diff(q(t),t) - diff(y(t),t));



% Perform laplace transforms
Eq1 = laplace(f1(t),t,s);
Eq2 = laplace(f2(t),t,s);
%Q = laplace(q(t),t,s);     % This one might not be necessary

% Set up the input and find its shifted laplace transform
%q(t) = A*sin(omega*t);
q(t) = Q;
%Q = laplace(q(t), t, s) - laplace(q(t), t-d, s);

% Replace the strings identifying laplace transforms with sym objects
syms X Y
Eq1 = subs(Eq1,{laplace(x(t), t, s),laplace(y(t), t, s)},{X,Y});
Eq2 = subs(Eq2,{laplace(x(t), t, s),laplace(y(t), t, s)},{X,Y});

Eq1 = subs(Eq1,{x(0),y(0),'D(x)(0)','D(y)(0)'},{0,0,0,0})
Eq2 = subs(Eq2,{x(0),y(0),'D(x)(0)','D(y)(0)'},{0,0,0,0})

% Try simplifying
%Eq1 = collect(Eq1)
%Eq2 = collect(Eq2)

% Solve it!
[X, Y] = solve(Eq1, Eq2, X, Y);

X = simplify(X);
Y = simplify(Y);

pretty(X)
pretty(Y)



