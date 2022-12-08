%%Authors: Jordan Grow
clear
%Constants
m = 1;
hbar = 1;
V0 = 3;
a = 1;

%Assumption of infinity
in = 10;

%Plottingvariables
tau = 0.01;
widthp = 3;
energy = 1.75;

% create matrix of normfunc, probability to be
% filled

%Solve for schrodinger equation
rhs = @(x,u)[u(2); u(1) * 2*m*((heaviside(x + a) .* (1 - heaviside(x - a)))*V0 - energy)/hbar^2];

%Create bounding function
rhs_bounds = @(ua,ub)[ua(1) + in;ub(1)- in];

%create initial guess
%We have no idea what sols will be
rhs_guess = @(x)[sin(x);cos(x)];
xmesh = linspace(-widthp,widthp,10);
solinit = bvpinit(xmesh,rhs_guess);


%Create solutions
solution = bvp4c(rhs,rhs_bounds,solinit);

%Normalize wavefunction
normfunc = solution.y(1,:)/norm(solution.y(1,:));
probability = abs(normfunc).^2;

%% Plotstuff
figure;

%plot potential function
x = -widthp * a:tau:widthp * a;
v = (heaviside(x + a) .* (1 - heaviside(x - a))).*V0;
plot(x,v)
xlabel('x')

[S,P]=meshgrid(solution.x,probability.*100);

%Plot probability function
figure
mesh(S,P,time)