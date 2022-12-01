global m cD A rhoAir g windMag windAng

%% Constants
m = 50/1000; % Mass [kg]
d = 3/100; % Diameter [m]
cD = 0.5;
A = pi*(d/2)^2; % Surface Area of golf ball [m^2]
rhoAir = 1.225; % Density of Air [ kg/m^3]
g = [0, 0, 9.81]; % Graitational acceleration [m/s^2]
windAng = 0; % Inital Wind Direction (Deg)
Velvec = [0 20 20]; % [m/s]

%% Intial Conditions
condition(1) = 0; % Displacemnt in N direction
condition(2) = 0; % Displacemnt in E direction [m/s]
condition(3) = 0; % Displacemnt in D direction [m/s]
condition(4) = Velvec(1); % Velocity in the N direction
condition(5) = Velvec(2); % Velocity in the E direction
condition(6) = Velvec(3); % Velocity in the -D direction

%% First part of Question 9
wind = (0:1:10); % Inital Wind Magnitude
for i = 1:length(wind)
    windMag = wind(i);
    [t,z] = ode45('Problem9_ODES',[0 5],condition);
    figure(1)
    plot3(z(:,1),z(:,2),z(:,3))
    hold on
    ydist(i) = max(z(:,2));
    xdist(i) = max(z(:,1));
    totaldist(i) = (ydist(i)^2+xdist(i)^2)^(1/2); % Gives total Displacemnt of ball
end

axis equal
title('Trajectory of Golf Ball')
xlabel('N Displacement [m]')
ylabel('E Displacement [m]')
zlabel('-D Displacement [m]')
hold off
% Plots the total distance traveled versus wind speed 
figure(2)
plot(wind,totaldist)
title('Wind vs. Displacement')
xlabel('Wind (m/s)')
ylabel('Displacement (m)')

%% Second part of question 9
windMag = 0; % Inital Wind Magnitude (Reinitializing)
massvec = [25 50 75]/1000; % [kg]
KE = 1/2*m*norm(Velvec)^2;
tangent = Velvec./norm(Velvec);
for i = 1:3
    m = massvec(i);
    Vnew = sqrt((2*KE)/m).*tangent;
    condition(1) = 0; % Displacemnt in N direction
    condition(2) = 0; % Displacemnt in E direction [m/s]
    condition(3) = 0; % Displacemnt in D direction [m/s]
    condition(4) = Vnew(1); % Velocity in the N direction
    condition(5) = Vnew(2); % Velocity in the E direction
    condition(6) = Vnew(3); % Velocity in the -D direction

    [t,z] = ode45('Problem9_ODES',[0 5],condition);
