clc; clear; close all; 
%% Setup
    robot = importrobot("robot_arm_description/urdf/robot_arm.urdf");
    currentRobotJConfig = homeConfiguration(robot); 
%% The angels   
%0.5*0.18* 1000;
%(65/0.18)/1000;   
%radius = degree*pi/180  
angle_cov = @(x) x/180

angle_cov_offset = @(angle,offset) (angle+offset)/180

joint_angle_to_raniens = @(angle) angle*pi

degree = [0,0,0,0,0]

mani_degree=degree; 
for i = 1 :1: 5 
    mani_degree(i) = angle_cov(mani_degree(i))
end
angle_radiens = mani_degree
for i = 1 :1: 5 
    angle_radiens(i) = joint_angle_to_raniens(angle_radiens(i))
end
%{
for n=1:1:5 
    if mani_degree(n) > 1.0 
    integ=floor(mani_degree(n));
    mani_degree(n)=mani_degree(n)-integ;
    elseif mani_degree(n)<0 
   integ=floor(mani_degree(n));
   mani_degree(n)=mani_degree(n)-integ;
    end   
end
%}
%mani_degree=[1,0,0,0,0]

   robot_angle =[degree(1),degree(2),degree(3),degree(4),degree(5)]  %[radius(1),radius(2),radius(3),radius(4),radius(5)]; 
    %SIM_Vertecal : [1, 5.5, 4.7, 0, 0.8], 
    %Robot_Vertical [1,0.68,0.55,1,0.5]
    end_effector = 0;  %Open = 0, closed = 1.5  
        
%% set Position 
    arm_postion(:)= J_Forward_kinematic(angle_radiens(1),angle_radiens(2),angle_radiens(3),angle_radiens(4),angle_radiens(5));
        x = arm_postion(1)
        y = arm_postion(2)
        z = arm_postion(3)

%% Struct convestion  
    robot_config = ConfigStruct(robot_angle, end_effector);

%% Ploting
    show(robot,robot_config,'PreservePlot',false,'Frames','off');
   axis([-1 1 -1 1 -0.1 0.5]);
    poseNow = getTransform(robot, robot_config, 'end_point') 
%% Arduino_Robots_setup
 
%Husk at port nummet skal ændres til jeres port eks"COM14"
a = arduino('COM14', 'Uno', 'Libraries', 'Servo');

% Disse 'D#' er portene på arduinoen
wrist = servo(a, 'D9'); %, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
roll = servo(a, 'D8'); %, 'MinPulseDuration', 9e-4, 'MaxPulseDuration', 2e-3);
elbow = servo(a, 'D7');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
shoulder = servo(a, 'D6');%,'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
base = servo(a, 'D5');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);

%% Simulator_Merge 
writePosition(wrist, mani_degree(5));
writePosition(roll, mani_degree(4));
writePosition(elbow, mani_degree(3));
writePosition(shoulder, mani_degree(2));
writePosition(base, mani_degree(1));

%Vertical
%{  
 
writePosition(wrist, 0.5);
writePosition(roll, 1);
writePosition(elbow, 0.55);
writePosition(shoulder, 0.68);
writePosition(base, 1);
pause(5)  
%}

%% trejectori  
%{

    Configs(:, 1) = robot_angle; 
Configs = zeros(5, 10);
Gripper = zeros(1, 10);
Gripper(1, 1) = 0; 

for n = 2:10
    Configs(:,n) = robot_angle;
    Configs(1, n) = pi;
    Configs(3, n) = 2*pi/10;
    Gripper(1,n) = n*80*pi/(180*10);
end
numSamples = 1001;
[q,~,~, tvec] = trapveltraj(robot_angle,numSamples,'EndTime',2);
[g,~,~, ~] = trapveltraj(Gripper,numSamples,'EndTime',2);

close all; 
robot = importrobot("robot_arm_description\urdf\robot_arm.urdf");
show(robot,robot_config,'PreservePlot',false,'Frames','off');
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

%}