%%folov fugnsen
    
function main = proof_of_concept()
    %clc; clear; close all; 
    arduino = true
    figure(1);
    if ismac
        print("Mac is bad");
    elseif isunix
        print("linux");
        a = arduino('/dev/ttyACM0', 'Uno', 'Libraries', 'Servo');
    elseif ispc
        a = arduino('COM3', 'Uno', 'Libraries', 'Servo');
    else
        disp('Platform not supported')
    end
    if arduino
        robot = f_arduino(a);
    end

    %while true
    %    J_Forward_kinematic(90,90,0,0,90,true)
    %    set_angle(robot,degrees_to_robot(90),degrees_to_robot(90),degrees_to_robot(90),degrees_to_robot(0),degrees_to_robot(180))
    %end

    %main proof of concept
    set_angle(robot,degrees_to_robot(90),degrees_to_robot(90),degrees_to_robot(0),degrees_to_robot(0),degrees_to_robot(90));

    first_butten = 1;
    while first_butten == 1
	    first_butten = readDigitalPin(a,'D2')
    end
    point_1 = [-200,0,200];
    point_2 = [-230,60,150];
    point_3 = [-250,140,100];
    point_4 = [-180,200,60];
    set_speed = 10;
    run_trajectory(point_1,point_2,point_3,point_4,robot,arduino,set_speed)

    pause(5)
    point_1 = [-180,200,60];
    point_2 = [-180,200,100];
    point_3 = [-250,0,150];
    point_4 = [-150,-150,250];
    set_speed = 5;
    run_trajectory(point_1,point_2,point_3,point_4,robot,arduino,set_speed)
    
    while true
        return_butten = 1;
        while return_butten == 1
	        return_butten = readDigitalPin(a,'D2')
        end
        point_1 = [-150,-150,250];
        point_2 = [-250,0,150];
        point_3 = [-180,200,100];
        point_4 = [-180,200,60];
        set_speed = 5;
        run_trajectory(point_1,point_2,point_3,point_4,robot,arduino,set_speed)

        user_butten = 1;
        while user_butten == 1
	        user_butten = readDigitalPin(a,'D2')
        end
        point_1 = [-180,200,60];
        point_2 = [-180,200,100];
        point_3 = [-250,0,150];
        point_4 = [-150,-150,250];
        set_speed = 5;
        run_trajectory(point_1,point_2,point_3,point_4,robot,arduino,set_speed)
    end


    function run_trajectory(point_1,point_2,point_3,point_4,robot,arduino,speed)
    %point_5 = point_3;
    %point_6 = point_2;
    %point_7 = point_1;
    p_list = {point_1,point_2 ,point_3,point_4};%point_5,point_6,point_7};
    data = point_to_point(p_list,speed*1.88);
    %cierkel = @(x) [cos(x)*100,200,sin(x)*100+120];
    %data = [data;run_step(0,0.04,2*pi,cierkel)];
    for runs = 1 : 1
        siz = size(data);
        invers = zeros(siz(1)+1,5);
        start_vadi = a_invers_kinematic(data(1,1),data(1,2),data(1,3));
        invers(1,:) = start_vadi(1,:);
        xyz = zeros(siz(1),3);
        for i = 1 : 1 : siz(1)
            pause(0);
    
            mid = a_invers_kinematic(data(i,1),data(i,2),data(i,3));
            invers(i+1,:) = mid(1,:);% angles(invers(i,:),mid);
            xyz(i,:) = J_Forward_kinematic(invers(i+1,1),invers(i+1,2),invers(i+1,3),invers(i+1,4),invers(i+1,5),true);
            rob_angle = [];
            for led = 1 : 1: 5
                rob_angle(led) = degrees_to_robot(invers(i+1,led));
            end
            if arduino
                set_angle(robot,rob_angle(1),rob_angle(2),rob_angle(3),rob_angle(4),rob_angle(5));
            end
            pause(0.01);
            %a_invers_kinematic()
        end
    end
    figure(2);
    scatter3(xyz(:,1),xyz(:,2),xyz(:,3));
    xlim([-350 350])
    ylim([-350 350])
    zlim([0 700])
end
end

function done = j_trajectory_2(t_1,t_2)
    r_1 = t_2(1)-t_1(1);
    r_2=t_2(2)-t_1(2);
    r_3=t_2(3)-t_1(3);  
    f= @(x)[t_1(1)+x*r_1,t_1(2)+x*r_2,t_1(3)+x*r_3];
    done=f;
end

function done = run_step(start,step, stop, fun,delay)
    if nargin < 5
        delay = 0;
    end

    var = [];
    caunter = 1;
    %var(uint8((stop-start)/step)-1,:) = [0,0,0]; 
    for i = start : step : stop
        var(caunter,:) = fun(i);
        pause(delay);
        caunter = caunter+1;
    end
    done = var;
end

function robot = f_arduino(a)
    wrist = servo(a, 'D11'); %, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
    roll = servo(a, 'D10'); %, 'MinPulseDuration', 9e-4, 'MaxPulseDuration', 2e-3);
    elbow = servo(a, 'D9');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
    shoulder = servo(a, 'D6');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
    base = servo(a, 'D5');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
    robot = [base,shoulder,elbow,roll,wrist];
end

function set_angle(robot,a,b,c,d,e)
    per = [a ,b ,c ,d ,e];
    writePosition(robot(5), e);
    writePosition(robot(4), d);
    writePosition(robot(3), 1-c);
    writePosition(robot(2), b);
    writePosition(robot(1), a);
end

function out = degrees_to_robot(x)
    if(x<0)
        x = 360+x; % if the degree is below 0, it is then added the value of 360
    end
    out = clamp(mod(x,360),0,180)/180; % conventing the angles to robot joint angles
end

% ensure that the robot joint angels are between 0 and 360 degrees

function out = trim_angels(list)
    for i = 1 : 1 : 5
        if(list(i)<0)
            list(i) = 360+list(i);
        end
        list(i) = mod(list(i),360);
    end
    out = list;
end

function erl = is_legal(list)
    bol = true;
    for i = 1 : 1 : 5
        if(list(i)<0)
            list(i) = 360+list(i);
        end
        list(i) = mod(list(i),360);
        if(list(i) < 0 && list(i) > 180)
            bol = false;
        end
    erl = bol;
    end
end
% Finding the solution with the least amout of angle deviation
function out = angles(now,angels_val)
%Find angle deaviation
    vink = [1000,1000,1000,1000]; % High value, like infinity
    for i = 1 : 1 : 4
        if(is_legal(angels_val(i,:)))
            angels_val(i,:) = trim_angels(angels_val(i,:));
            vink(i) = 0;
            for i2 = 1: 1 : 5
                vink(i) = vink(i) + abs(now(i2)-angels_val(i,i2));
            end
        end
    end
    min = 100000000;
    index = 0;
    for i = 1 : 1 : 4
        if not(vink(i) == 1000 && vink(i)< min)
            index = i;
            min = vink(i);
        end
    end
    if index == 0
        out = now;
    else
        out = angels_val(index,:);
    end
end

function data = line_path(data,start,stop,speed)
    len = sqrt((start(1)-stop(1))^2+(start(2)-stop(2))^2+(start(3)-stop(3))^2);
    step = speed/len;
    fun1 = j_trajectory_2(start,stop);
    var = run_step(0,step,1,fun1);
    data = [data;var];
end

function out = point_to_point(points,speed)
    data = [];
    siz = size(points);
    for i = 1 : siz(2)-1
        data = line_path(data,points{i},points{i+1},speed);
    end
    out = data;
end
