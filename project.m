%% Testing harmonic oscillator
%Constants
m = 3;
hbar = 1;
a = 2;
k = 3;
%Plot for 10 n values
figure;
hold on;
for n = 1:10
%Choose a value for E
%n = 9;
E = (n^2*pi^2*hbar^2)/(2*m*a^2);
rhs_isw = @(t,u)[u(2); -(2*m*E)/hbar^2*u(1)];
rhs_bounds = @(ua,ub)[ua(1);ub(1)-a];
%create initial guess
rhs_guess = @(x)[sin(x);cos(x)];
xmesh = linspace(0,a,10);
solinit = bvpinit(xmesh,rhs_guess);
solution = bvp4c(rhs_isw,rhs_bounds,solinit);
%Normalize wavefunction
normfunc = solution.y(1,:)/norm(solution.y(1,:));
probability = normfunc.^2;
plot(solution.x,probability)
end
xlabel("x")
ylabel("wavefunction")