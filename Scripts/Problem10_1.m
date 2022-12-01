function Problem10part1()

global m cD A V rhoAir rhoHe g Wind

%% Constants
m = 0.5; % Mass of Balloon[kg]
cD = 0.5;
V = 1; % Volume of Helium  [m^3]
r = (V /((4/3)*pi))^(1/3);
A = pi*r^2;
rhoAir = 1.225; % Density of Air [kg/m^3]
rhoHe = 0.164; % Density of Helium [kg/m^3]
g = [0, 0, 9.81]; % Graitational acceleration [m/s^2]
Velvec = [0 0 0]; % [m/s]

%% Intial Conditions
condition(1) = 0; % Displacemnt in N direction
condition(2) = 0; % Displacemnt in E direction [m/s]
condition(3) = 0; % Displacemnt in D direction [m/s]
condition(4) = Velvec(1); % Velocity in the N direction
condition(5) = Velvec(2); % Velocity in the E direction
condition(6) = Velvec(3); % Velocity in the D direction

[t,z] = ode45('Problem10_ODES',[0 5],condition);
figure(1)
plot3(z(:,1),z(:,2),z(:,3))
axis equal
title('Trajectory of Balloon')
xlabel('N - Displacement [m]')
ylabel('E - Displacement [m]')
zlabel('D - Displacement [m]')
