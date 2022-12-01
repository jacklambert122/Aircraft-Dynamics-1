global Wind Wind2

%% Part 1 
Problem10part1();

%% Part 2 
Wind = 0:1:20;
t2 = 1;
for i=1:length(Wind)
   Wind2 = [Wind(i) 0 0];
   V45 = Problem10part2(t2,V45);
   t2 = t2+1;
end

figure(2)
hold on
plot(Wind,V45);
title('Angle of Balloon')
xlabel('Wind Velocity [m/s]')
ylabel('Volume of Helium')
axis equal