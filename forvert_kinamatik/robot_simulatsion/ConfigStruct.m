function currentRobotJConfig = ConfigStruct(q, g)
names = {'base','shoulder','elbow','roll','pitch'};
for n = 1:5
currentRobotJConfig(n).JointName = names{n};
currentRobotJConfig(n).JointPosition = q(n);
end

guess = [0,0]; %[0, 70*pi/180];
options = optimset('Display','off');
f = @(y) solve_kin(g, y);
x = fsolve(f,guess, options);

currentRobotJConfig(6).JointName = 'finger_gear_left';
currentRobotJConfig(6).JointPosition = -g;
currentRobotJConfig(7).JointName = 'f2g_left';
currentRobotJConfig(7).JointPosition = x(2);
currentRobotJConfig(8).JointName = 'l2f_left';
currentRobotJConfig(8).JointPosition = x(1);

currentRobotJConfig(9).JointName = 'finger_gear_right';
currentRobotJConfig(9).JointPosition = g;
currentRobotJConfig(10).JointName = 'f2g_right';
currentRobotJConfig(10).JointPosition = -x(2);
currentRobotJConfig(11).JointName = 'f2l_right';
currentRobotJConfig(11).JointPosition = x(1);
%end

end

function F = solve_kin(g, q)
vA = 111.8*pi/180 - g; 
vB = -(pi-(69.4*pi/180 - q(1)));  
vC = -(pi-(109.6*pi/180 - q(2))); 
A1 = [cos(vA), -sin(vA); sin(vA), cos(vA)];
A2 = [cos(vB), -sin(vB); sin(vB), cos(vB)];
A3 = [cos(vC), -sin(vC); sin(vC), cos(vC)];

F = A1*([30.75;0] + A2*([22;0] + A3*[31;0]))-[21.541;0];

end
