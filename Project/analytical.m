% Laplace transform verification script
%   Uses the symbolic math toolbox to derive laplace transforms for Xs, Xu,
%   and Q
%   Then uses the control systems toolbox to perform a simulation using
%   transfer functions


clear E
% Define symbolic variables
syms k m c omega A mu kt ct T real
syms x(t) y(t) q(t) s

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


% Replace the strings identifying laplace transforms with sym objects
syms X Y Q
Eq1 = subs(Eq1,{laplace(x(t), t, s),laplace(y(t), t, s)},{X,Y});
Eq2 = subs(Eq2,{laplace(x(t), t, s),laplace(y(t), t, s)},{X,Y});

Eq1 = subs(Eq1,{x(0),y(0),'D(x)(0)','D(y)(0)'},{0,0,0,0});
Eq2 = subs(Eq2,{x(0),y(0),'D(x)(0)','D(y)(0)'},{0,0,0,0});
    
Eq1 = subs(Eq1,{laplace(q(t), t, s)},{Q});
Eq2 = subs(Eq2,{laplace(q(t), t, s)},{Q});

Eq1 = subs(Eq1,{q(0)},{0});
Eq2 = subs(Eq2,{q(0)},{0});


% Solve it!
[X, Y] = solve(Eq1, Eq2, X, Y);

X = simplify(X);
Y = simplify(Y);

% Display below
pretty(X)
pretty(Y)

%%% Put together the transfer functions %%%

% Need constants first
ms = 236.12;
mu = 23.61;
kt = 181818.88;
ct = 13.854;
ks = 34967;
cs = 905.2896;
L = 5.2;
V = 10;
T = L/(V*1000/3600);
omega = pi/T;



% Input transfer function of sprung mass X, as derived above

Xtf = tf([-ct*cs, cs*kt-ct*ks, kt*ks],[ms*mu, cs*ms-ct*ms+cs*mu, ...
    ks*ms+kt*ms+ks*mu-cs*ct, cs*kt-ct*ks, ks*kt]);

Ytf = tf([-ct*ms, kt*ms-ct*cs, kt*cs-ct*ks, kt*ks],...
    [ms*mu, cs*ms-ct*ms+cs*mu, ks*ms+kt*ms+ks*mu-cs*ct, cs*kt-ct*ks, ks*kt]);

% Perform a simulation at 10 kph

t_vect = linspace(0,T*5,300);
q_vect = zeros(1,length(t_vect));
q_vect(1,1:60) = 0.1*sin(omega.*t_vect(1,1:60));
[xs_final, t_final] = lsim(Xtf,q_vect,t_vect);
[xu_final, t_final] = lsim(Ytf,q_vect,t_vect);

figure
hold on
box on
plot(t_final,xs_final)
xlabel('Time [seconds]')
ylabel('Sprung mass position x_s [meters]');
hold off

figure
hold on
box on
plot(t_final,xu_final)
xlabel('Time [seconds]')
ylabel('Unsprung mass position x_u [meters]');
hold off


% Now evaluate at 40 kph

V = 40;
T = L/(V*1000/3600);
omega = pi/T;
t_vect = linspace(0,T*5,300);
q_vect = zeros(1,length(t_vect));
q_vect(1,1:60) = 0.1*sin(omega.*t_vect(1,1:60));
[xs_final, t_final] = lsim(Xtf,q_vect,t_vect);
[xu_final, t_final] = lsim(Ytf,q_vect,t_vect);

figure
hold on
box on
plot(t_final,xs_final)
xlabel('Time [seconds]')
ylabel('Sprung mass position x_s [meters]');
hold off

figure
hold on
box on
plot(t_final,xu_final)
xlabel('Time [seconds]')
ylabel('Unsprung mass position x_u [meters]');
hold off
