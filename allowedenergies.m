%% Find allowed energies
%Variables
m = 1;
hbar = 1;
V0 = 3;
a = 1;

%Energy must be less than V0
etau = 0.1;
E = 0:etau:v0 - etau;



l = sqrt(2.*m.*(V0 - E))/hbar;


figure;
hold on;
plot(E,l.*tan(l*a))
plot(E,sqrt(2*m*E)/hbar)