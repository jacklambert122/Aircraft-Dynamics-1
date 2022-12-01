function [dydt] = Problem9_ODES(t,y)

global m cD A rhoAir g windMag windAng

dx = y(1); % N - location
dy = y(2); % E - location
dz = y(3); % -D - location
Vx = y(4); % N - component of velocity
Vy = y(5); % E compenent of velocity
Vz = y(6); % -D component of velocity

%% Accounting for Wind
Vwx = -1*windMag*cosd(windAng); %Cross range wind [m/s] 
Vwy = windMag*sind(windAng); %Down range wind [mph] 
Vwz = 0;

vrel = [Vx-Vwx Vy-Vwy Vz-Vwz]; % Relative Wind 
mag = sqrt(vrel(1)^2+vrel(2)^2+vrel(3)^2); % Magnitude of velocity rel to body 

if mag == 0
    unitrep = [0 0 0];
else
    unitrep = vrel./mag; % Direction of drag 
end

Drag = 0.5*rhoAir*mag^2*cD*A.*unitrep;
Accell = (-Drag - m.*g)./m;

% Kinematic Equations
dydt(1) = vrel(1); 
dydt(2) = vrel(2);
dydt(3) = vrel(3);
dydt(4) = Accell(1);
dydt(5) = Accell(2);
dydt(6) = Accell(3);

if dz < 0.0 % stops the trajectory from continueing past ground level
    dydt = 0;
    for i = 1:6
        y(i) = 0;
    end
end
dydt = dydt';
