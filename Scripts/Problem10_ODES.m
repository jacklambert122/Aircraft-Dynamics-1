function [dydt] = Problem10_ODES(t,y)

global m cD A V rhoAir rhoHe g Wind

dx = y(1); % x - location
dy = y(2); % y - location
dz = y(3); % z - location
Vx = y(4); % x - component of velocity
Vy = y(5); % y - compenent of velocity
Vz = y(6); % z - component of velocity

%% Accounting for Wind
Vwx = Wind(1);
Vwy = Wind(2);
Vwz = Wind(3);
vrel = [Vx-Vwx Vy-Vwy Vz-Vwz]; % Relative Wind 
mag = sqrt(vrel(1)^2+vrel(2)^2+vrel(3)^2); % Magnitude of velocity rel to body 

if mag == 0
    unitrep = [0 0 0];
else
    unitrep = vrel./mag; % Direction of drag 
end

Drag = -0.5*rhoAir*mag^2*cD*A.*unitrep;
Bouyancy =  V * (rhoAir - rhoHe) * g;
Accell = (Bouyancy + Drag - m.*g)./m;

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