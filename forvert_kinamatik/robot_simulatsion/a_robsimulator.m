clc; clear; close all; 
%% Setup
    robot = importrobot("robot_arm_description/urdf/robot_arm.urdf");
    currentRobotJConfig = homeConfiguration(robot); 
%% The angels

angle_cov_offset = @(angle,offset) (angle+offset)/180 ;
%dddd = [1,0.79,-1.55,0,0.8];
%for kat = 1 :1 :5
%   dddd(kat) = (dddd(kat)*180)/pi
%end
angle_cov_radiens = @(angle) (angle*pi)/180;
%{
0,(12+10)/2,180;
0,(6+7.5)/2,(180+181)/2;
0,0,(177+180)/2;
0,(7.5+10)/2,(178+180)/2 
%}
degree = [0,0,180,57.2958;
        90,12,180,45.2637+180;
        90,7.5,180,-88.8085-90;
        0,0,180.5,0;
        90,-7.5,180,45.8366-90]

angle_radiens = degree;
for i = 1 : 1 :5
    degree(i,:) = bouns(degree(i,:));
    angle_radiens(i,1) = angle_cov_radiens(degree(i,1))
end


%% set Position 
    arm_postion(:)= J_Forward_kinematic(angle_radiens(1,1),angle_radiens(2,1),angle_radiens(3,1),angle_radiens(4,1),angle_radiens(5,1));
        x = arm_postion(1)
        y = arm_postion(2)
        z = arm_postion(3)

%% Struct convestion
    end_effector = 0;
    robot_config = ConfigStruct(angle_radiens(:,1).', end_effector);
    
%% Ploting
for j = 1 :1: 5
    degree(j,:) = bouns(degree(j,:));
    degree(j,1) = angle_cov_radiens(degree(j,1)+degree(j,4));
end
robot_config = ConfigStruct(degree, end_effector);
show(robot,robot_config,'PreservePlot',false,'Frames','off');
%axis([-1 1 -1 1 -0.1 0.5]);
poseNow = getTransform(robot, robot_config, 'end_point') 
asb_for = J_Forward_kinematic(degree(1),degree(2)+pi*0.5,degree(3),degree(4),degree(5))/1000   
poseNow = getTransform(robot, robot_config, 'end_point')

%{
for i = 1:3:360
    for j = 1 :1: 5
        degree(j,1) = i;
        degree(j,:) = bouns(degree(j,:));
        degree(j,1) = angle_cov_radiens(degree(j,1)+degree(j,4));
    end
    i = i
    asb_for = J_Forward_kinematic(degree(1),degree(2),degree(3),degree(4),degree(5))
    robot_config = ConfigStruct(degree, end_effector);
    pause(0.01)
    show(robot,robot_config,'PreservePlot',false,'Frames','off');
    %axis([-1 1 -1 1 -0.1 0.5]);
    poseNow = getTransform(robot, robot_config, 'end_point') 
end
%}

