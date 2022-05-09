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
degree = [0,0,180,80 ;%98; %80;
          0,12,180, 45+180; %45.2637+180;
          0,7.5,180,180; %-88.8085+270;
          0,0,180.5,0;
          0,-7.5,180,45.8366-90]

angle_radiens = degree;
for i = 1 : 1 :5
    degree(i,:) = bouns(degree(i,:));
    angle_radiens(i,1) = angle_cov_radiens(degree(i,1))
end


%% set Position 
    arm_postion(:)= J_Forward_kinematic(degree(1,1),degree(2,1),degree(3,1),degree(4,1),degree(5,1));
        x = arm_postion(1)
        y = arm_postion(2)
        z = arm_postion(3)

%% Struct convestion
    end_effector = 0;
    robot_config = ConfigStruct(angle_radiens(:,1).', end_effector);
    
%% Ploting
sim_ang = []
for j = 1 :1 : 5
    degree(j,:) = bouns(degree(j,:));
    if j == 3
        sim_ang(j,1) = angle_cov_radiens(degree(j,3)+degree(j,2)-degree(j,1)+degree(j,4));
    else
        sim_ang(j,1) = angle_cov_radiens(degree(j,1)+degree(j,4));
    end
end
robot_config = ConfigStruct(sim_ang, end_effector);
show(robot,robot_config,'PreservePlot',false,'Frames','off');
%axis([-1 1 -1 1 -0.1 0.5]);
poseNow = getTransform(robot, robot_config, 'end_point') 
asb_for = J_Forward_kinematic(degree(1),degree(2),degree(3),degree(4),degree(5))/1000   
poseNow = getTransform(robot, robot_config, 'end_point');

%
x_asb = [];
y_asb = [];
x_asb = [];
x_sim = [];
y_sim = [];
z_sim = [];
for i  = 0:20:180
for v2 = 0:20:180
for v3 = 0:45:180
for v4 = 0:45:180
for v5 = 0:45:180
    i = i
    list_isk = [i v2 v3 v4 v5]
    for j = 1 :1: 5
        degree(j,1) = list_isk(j);
        degree(j,:) = bouns(degree(j,:));
        if j == 3
            sim_ang(j,1) = angle_cov_radiens(degree(j,3)+degree(j,2)-degree(j,1)+degree(j,4));
        else
            sim_ang(j,1) = angle_cov_radiens((degree(j,1))+degree(j,4));
        end
    end
    asb_for = J_Forward_kinematic(degree(1),degree(2),degree(3),degree(4),degree(5))/1000;
    robot_config = ConfigStruct(sim_ang, end_effector);
    %pause(0.01)
    show(robot,robot_config,'PreservePlot',false,'Frames','off');
    %axis([-1 1 -1 1 -0.1 0.5]);
    poseNow = getTransform(robot, robot_config, 'end_point');
    jjjj = size(x_asb);
    x_asb(jjjj(2)+1) = asb_for(1);
    y_asb(jjjj(2)+1) = asb_for(2);
    z_asb(jjjj(2)+1) = asb_for(3);
    x_sim(jjjj(2)+1) = poseNow(1,4);
    y_sim(jjjj(2)+1) = poseNow(2,4);
    z_sim(jjjj(2)+1) = poseNow(3,4);
end
end
end 
end
end

tab = [x_asb;y_asb;z_asb;x_sim;y_sim;z_sim;x_asb-x_sim;y_asb-y_sim;z_asb-z_sim].'
plot3(x_asb,y_asb,z_asb,x_sim,y_sim,z_sim,x_asb-x_sim,y_asb-y_sim,z_asb-z_sim)
xlim([-0.350 0.350])
ylim([-0.350 0.350])
zlim([-0.5 0.700])
%}