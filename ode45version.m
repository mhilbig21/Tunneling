% Constants: change these to sensible things
hbar = 1;
m = 1;
E = 1; % get this one from "allowedenergies.m" (just read it out of the table)
V0 = 2; % energy level of barrier
a = 0.5; % width of barrier

%% STEP 1: BEFORE THE BARRIER


% rhs equation
rhs_b = @(x,u)[u(2); -2*m*E./hbar^2 * u(1)];

% choose initial condition based on energy the particle has before the
% barrier:
% basically, this is the value of the function at some point to the left of
% the barrier. 
% make the derivative initial condition zero if you choose a max
% fix to be more accurate later. 
u0_b = [0.5, 0];
% this is where the initial condition is defined at
xinitial_b = -10; % fix later
% place xfinal a little bit after the barrier starts
% barrier starts at 0 - a, so:
xfinal_b = -1*a;
% before barrier solution
[x_b, u_b] = ode45(rhs_b,[xinitial_b, xfinal_b], u0_b);

%% STEP 2: INSIDE THE BARRIER
% rhs function for this part
rhs_i = @(x,u)[u(2); -2*m*(E-V0)./hbar^2 * u(1)];
xinitial_i = -1*a; % this is where the barrier starts
xfinal_i = a+0.5; % went out a bit so the solution covers it
% initial condition is the value of the PREVIOUS step at the barrier
% beginning

% Goal here is to find the index of x variable at the beginning of the
% barrier, -1*a
for n=1:size(x_b)
    if abs(x_b(n,1)-(-1*a))<0.1
        barrindexb=n;
    end
end

% then use that index to find the value of the func at -1*a and its first
% derivative - these are the initial conditions
u0_i = [u_b(barrindexb,1), u_b(barrindexb,2)];

% now just solve
[x_i, u_i] = ode45(rhs_i,[xinitial_i, xfinal_i], u0_i);

%% STEP 3: AFTER THE BARRIER

% same rhs function from first step
xinitial_a = xfinal_i; % end of barrier
xfinal_a = 10; % whatever you want

% find index of end of barrier: 
for n=1:size(x_i)
    if abs(x_i(n,1)-a)<0.1
        barrindexa=n;
    end
end

% initial conditions for after-barrier are the end of the barrier
u0_a = [u_i(barrindexa,1), u_i(barrindexa,2)];

% solve!
[x_a, u_a] = ode45(rhs_b,[xinitial_a,xfinal_a],u0_a);

% after this make a function that is all the u's:
% u_b from xinitial_b to -1*a
% u_i from -1*a to a
% u_a from a to xfinal_a

%% STEP 3: PLOTTING RESULTS
figure
hold on

plot(x_b,u_b(:,2))

plot(x_i,u_i(:,2))

plot(x_a,u_a(:,2))

