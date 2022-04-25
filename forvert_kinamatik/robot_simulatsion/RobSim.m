clc; clear; close all; 

%% Setup robot
%robot = loadrobot("kinovaJacoJ2N6S300");
robot = importrobot("robot_arm_description\urdf\robot_arm.urdf");
currentRobotJConfig = homeConfiguration(robot);

%{
%% Create environment
iviz = interactiveRigidBodyTree(robot);
ax = gca;

plane = collisionBox(1.5,1.5,0.05);
plane.Pose = trvec2tform([0.25 0 -0.025]);
show(plane,'Parent', ax);

leftShelf = collisionBox(0.25,0.1,0.2);
leftShelf.Pose = trvec2tform([0.3 -.65 0.1]);
[~, patchObj] = show(leftShelf,'Parent',ax);
patchObj.FaceColor = [0 0 1];

leftWidget = collisionCylinder(0.01, 0.07);
leftWidget.Pose = trvec2tform([0.3 -0.65 0.225]);
[~, patchObj] = show(leftWidget,'Parent',ax);
patchObj.FaceColor = [1 0 0];
%}

%% Set positions: 
c0 = [currentRobotJConfig(1).JointPosition, ...
        currentRobotJConfig(2).JointPosition,...
        currentRobotJConfig(3).JointPosition,...
        currentRobotJConfig(4).JointPosition,...
        currentRobotJConfig(5).JointPosition];

Configs = zeros(5, 10);
Configs(:, 1) = c0; 

Gripper = zeros(1, 10);
Gripper(1, 1) = 0; 

for n = 2:10
    Configs(:,n) = c0;
    Configs(1, n) = pi;
    Configs(3, n) = 2*pi/10;
    Gripper(1,n) = n*80*pi/(180*10);
end
numSamples = 1001;
[q,~,~, tvec] = trapveltraj(Configs,numSamples,'EndTime',2);
[g,~,~, ~] = trapveltraj(Gripper,numSamples,'EndTime',2);

%% Simulate and get end-effector positions:
close all; 
robot = importrobot("robot_arm_description\urdf\robot_arm.urdf");
show(robot,currentRobotJConfig,'PreservePlot',false,'Frames','off');
hold on
axis([-1 1 -1 1 -0.1 0.5]);
for i = 1:5:numSamples
    % Interpolate simulated joint positions to get configuration at current time    
    configNow = ConfigStruct(q(:,i), g(1,i));
    poseNow = getTransform(robot, configNow, 'end_point');
    show(robot,configNow, 'PreservePlot', false, 'Frames','off');
    jointSpaceMarker = plot3(poseNow(1,4),poseNow(2,4),poseNow(3,4),'r.','MarkerSize',20);
    drawnow;
end

