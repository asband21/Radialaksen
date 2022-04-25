clc; clear; close all; 

%% Setup robot
robot = importrobot("robot_arm_description\urdf\robot_arm.urdf");

%% Set positions: 
JointPos = [0, 0, 0, 0, 0]; % Positioner for hver joint
Gripper = 0; %gripperens position

%% Matlabs toolbox skal bruge positionen i en structur format så jeg har lavet en funktion til dette:
% (Derudover laver den også en hurtig kinematisk optimerings problem for gripperens position)
robot_config = ConfigStruct(JointPos, Gripper);

%% Vi kan så se robotten i denne configuration:
show(robot,robot_config,'PreservePlot',false,'Frames','off');
axis([-1 1 -1 1 -0.1 0.5]); % sætter lige figur axis til passende værdier

%% Vi kan flytte robotten til en ny position:
pause(1)
JointPos = [0, -pi/2, 0, 0, 0]; % Positioner for hver joint
Gripper = 80*pi/180; %gripperens position
robot_config = ConfigStruct(JointPos, Gripper);

show(robot,robot_config, 'PreservePlot', false, 'Frames','off');
axis([-1 1 -1 1 -0.1 0.5]); % sætter lige figur axis til passende værdier

%% Og i kan få positionen for end-effectoren:
poseNow = getTransform(robot, robot_config, 'end_point');

