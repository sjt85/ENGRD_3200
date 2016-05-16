function xdot = dydtsys40(t,x)
% The function dydtsys is used to hold the ODEs
% t is the current time (a single number).
% x is a four element vector;
% x = [xs, vs, xu, vu]
% xdot is dxdt of each of these four variables

% Hard coding constants
global k
global c
ms = 236.12;           % Sprung mass
mu = 23.61;            % Unsprung mass
kt = 181818.88;        % Tire Stiffness
ct = 13.854;           % Tire Damping Coefficient
V = 40;                % Velocity of the car
L = 5.2;               % Length

% T is the time needed for the car to go over the bump
T = L/(V*1000/3600);
omega = pi/T;
A = 0.1;

% QCM experiences the road profile q when 0<t<T
if 0>t || t>T;
    qdot = 0;
    q = 0;
else
    qdot= A*omega*cos(omega*t);
    q = A*sin(omega*t);
end

deltax = x(1)-x(3);          % Aggregate Displacement
deltax_dot = x(2)-x(4);      % Aggregate Velocity

% Fsp and Fd are the spring and damper forces
Fsp = k(1) * deltax + k(2) * deltax^2 + k(3) * deltax^3;
Fd = c(1) * deltax_dot + c(2) * deltax_dot^2;

% Create a matrix to represent four first-order differential equations
% xdot(1,1),xdot(2,1),xdot(3,1),xdot(4,1) are Vs,As,Vu, and Au respectively
% x(1),x(2),x(3),x(4) are Xs,Vs,Xu, and Vu respectively
xdot(1,1)=x(2);
xdot(2,1)=-1/ms*(Fsp+Fd);
xdot(3,1)=x(4);
xdot(4,1)=(1/mu)*(kt*(q-x(3))+ct*(qdot-x(4))+Fsp+Fd);

end

