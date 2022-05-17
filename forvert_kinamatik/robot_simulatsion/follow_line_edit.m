%% follow function
    
function main = follow_line_edit()
    %clc; clear; close all;  
    ardino = false % if arduino is true, then the arudino is activated
    figure(1);
    if ardino
        robot = setup_ardurino();
    end 
    %% Debuging
    %J_Forward_kinematic(0,90,90,0,0,true)
    %while true
    %    set_angel(robot,dregres_to_robot(0),dregres_to_robot(90),dregres_to_robot(90),dregres_to_robot(0),dregres_to_robot(90))
    %end

    %% poitns and functions 
    point_1 = [-40,250,100];
    point_2 = [-267.5,200,100];
    point_3 = [-267.5,0,100];
    point_4 = [-267.5,0,75];
    point_5 = point_3;
    point_6 = point_2;
    point_7 = point_1; 

    fun1 = j_trajectory_2(point_1,point_2);
    fun2 = j_trajectory_2(point_2,point_3);
    fun3 = j_trajectory_2(point_3,point_4);
    fun4 = j_trajectory_2(point_4,point_5);
    fun5 = j_trajectory_2(point_5,point_6);
    fun6 = j_trajectory_2(point_6,point_7); 

  % data is incetet into matrix, the matrix grows for each functions that is incetet  

  %% matrix update with functions and poitns
    data = run_step(0,0.1,1,fun1);
    data = [data;run_step(0,0.02,1,fun2)];
    data = [data;run_step(0,0.1,1,fun3)];
    data = [data;run_step(0,0.1,1,fun4)];
    data = [data;run_step(0,0.02,1,fun5)];
    data = [data;run_step(0,0.1,1,fun6)];  

%% Program run 
% The program runs 10 times
    for runs = 1 : 10
        siz = size(data);
        inverse = zeros(siz(1)+1,5);
        start_value = a_invers_kinematic(data(1,1),data(1,2),data(1,3));
        inverse(1,:) = start_value(1,:);
        xyz = zeros(siz(1),3); 

        for i = 1 : 1 : siz(1)
            pause(0); %pause
            mid = a_invers_kinematic(data(i,1),data(i,2),data(i,3)) %inversekinematic on the 'data'  
            inverse(i+1,:) = vinkler(inverse(i,:),mid); % angle
            xyz(i,:) = J_Forward_kinematic(inverse(i+1,1),inverse(i+1,2), ...
                inverse(i+1,3),inverse(i+1,4),inverse(i+1,5),true) % checking the forwardkiematic with the inverse angels 
            rob_angle = []; %inisilaysig the rob_angle

             %incetes the convetet degreass into the robot_angle for each joint
            for led = 1 : 1: 5
                rob_angle(led) = dregres_to_robot(inverse(i+1,led));
            end

            if ardino
                set_angel(robot,rob_angle(1),rob_angle(2),rob_angle(3),rob_angle(4),rob_angle(5));
            end
            pause(0.01);
        end
    end
    figure(2); % setup new figure, figure 2
    scatter3(xyz(:,1),xyz(:,2),xyz(:,3)); % plotting poitns 

    %limiting the coordinate system
    xlim([-350 350])  
    ylim([-350 350])
    zlim([0 700])
end

%% function-set #1
% linear function precestet in a parmeter eqation,  
% "Parameterfremtiling af en linje"
function done = j_trajectory_2(t_1,t_2)
    r_1 = t_2(1)-t_1(1);
    r_2=t_2(2)-t_1(2);
    r_3=t_2(3)-t_1(3);  
    f= @(x)[t_1(1)+x*r_1,t_1(2)+x*r_2,t_1(3)+x*r_3];
    done=f;
end 


function done = run_step(start,step, stop, fun,delay) 

%If the delay is not specfied in the function call, delay is equal to 0 
    if nargin < 5
        delay = 0;
    end

    % IZITILAZING array to optimize the performance
    var = [];
    caunter = 1;
    var(uint8((stop-start)/step)+1,:) = [0,0,0];  % finding the max vaule of and setting it to [0,0,0]
    for i = start : step : stop
        var(caunter,:) = fun(i); % running the functions of the paths
        pause(delay);
        caunter = caunter+1; % count the loop eduration
    end
    done = var
end

%% arduino setup 
function robot = setup_ardurino()
    if ismac
        print("fuck dig");
    elseif isunix
        print("linux");
        a = arduino('/dev/ttyACM0', 'Uno', 'Libraries', 'Servo');
    elseif ispc
        a = arduino('COM14', 'Uno', 'Libraries', 'Servo');
    else
        disp('Platform not supported')
    end
    wrist = servo(a, 'D11'); %, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
    roll = servo(a, 'D10'); %, 'MinPulseDuration', 9e-4, 'MaxPulseDuration', 2e-3);
    elbow = servo(a, 'D9');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
    shoulder = servo(a, 'D6');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
    base = servo(a, 'D5');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
    robot = [base,shoulder,elbow,roll,wrist];
end

%% writting postion to the physical robot
function set_angel(robot,a,b,c,d,e)
    writePosition(robot(5), e);
    writePosition(robot(4), d);
    writePosition(robot(3), c);
    writePosition(robot(2), b);
    writePosition(robot(1), a); 
end

%% Funtion-set #2 
function out = dregres_to_robot(x)
    if(x<0) 
        x = 360+x; % if the degree is below 0, it is then added the value of 360
    end
    out = clamp(mod(x,360),0,180)/180; % conventing the angles to robot joint angels
end 

% ensure that the robot joint angels are between 0 and 360 degrees
function out = trim_angls(list)
    for i = 1 : 1 : 5
        if(list(i)<0)
            list(i) = 360+list(i);
        end
        list(i) = mod(list(i),360);
    end
    out = list;
end

%tjekking of the postion is leagel
function erl = er_lovlig(list)
    bol = true;
    for i = 1 : 1 : 5
        if(list(i)<0)
            list(i) = 360+list(i);
        end
        list(i) = mod(list(i),360)
        if(list(i) < 0 && list(i) > 180)
            bol = false;
        end
    erl = bol;
    end
end

% Finding the solution with the least amout of angel deviation
function out = vinkler(now,angls_val) 
%Find angel deaviation
    vink = [1000,1000,1000,1000]; % High vaule, like infinity
    for i = 1 : 1 : 4
        if(er_lovlig(angls_val(i,:)))
            angls_val(i,:) = trim_angls(angls_val(i,:));
            vink(i) = 0;
            for i2 = 1: 1 : 5
                vink(i) = vink(i) + abs(now(i2)-angls_val(i,i2));
            end
        end
    end
    min = 100000000;
    index = 0; 
    % comparing soultions with least deviation
    for i = 1 : 1 : 4
        if not(vink(i) == 1000) && vink(i)< min % when angle is not equal tp 1000 and is abov minimum
            index = i;
            min = vink(i);
        end
    end  
    % there was no leagel solutions founde
    if index == 0
        out = now;
    else
        out = angls_val(index,:); %leagal soultion found with the least angel deviation
    end
end