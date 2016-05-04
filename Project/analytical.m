% Experimenting with laplace transforms

clear E
syms k m c omega A mu kt ct real
syms x(t) y(t) s
delta_x(t) = x(t)-y(t);
Fsp(t) = k*delta_x(t); % + k2*delta_x(t).^2 + k3*delta_x(t).^3;
Fd(t) = c*(diff(x(t),t)-diff(y(t),t)); %+ c2*(diff(x(t),t)-diff(y(t),t)).^2;
f1(t) = m*diff(diff(x(t),t),t) + Fsp(t) + Fd(t);
q(t) = A*sin(omega*t);
f2(t) = mu*diff(diff(y(t),t),t) - Fsp(t) - Fd(t) - kt*(q(t) - y(t)) + ...
    ct*(diff(q(t),t) - diff(y(t),t));
X(t) = laplace(f1(t),t,s)
Y(t) = laplace(f2(t),t,s)
Q(t) = laplace(q(t),t,s)

