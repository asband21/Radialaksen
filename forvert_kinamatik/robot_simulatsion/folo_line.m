%%folov fugnsen
    
function main = folo_line()
    %clc; clear; close all; 
    ardino = false
    figure(1);
    if ardino
        robor = setop_adriuno();
    end
    
     %while true
     %    J_Forward_kinematic(90,90,90,0,180,true)
     %    set_angel(robor,dregres_to_robot(90),dregres_to_robot(90),dregres_to_robot(90),dregres_to_robot(0),dregres_to_robot(180))
     %end

    pungt_1 = [-40,250,100];
    pungt_2 = [-267.5,200,100];
    pungt_3 = [-267.5,0,100];
    pungt_4 = [-267.5,0,75];
    pungt_5 = pungt_3;
    pungt_6 = pungt_2;
    pungt_7 = pungt_1;
    p_list = {pungt_1,pungt_2,pungt_3,pungt_4,pungt_5,pungt_6,pungt_7};
    data = point_to_point(p_list,3);
    for roins = 1 : 1
        siz = size(data);
        inver = zeros(siz(1)+1,5);
        start_vadi = a_invers_kinematic(data(1,1),data(1,2),data(1,3));
        inver(1,:) = start_vadi(1,:);
        xyz = zeros(siz(1),3);
        for i = 1 : 1 : siz(1)
            pause(0);
    
            mid = a_invers_kinematic(data(i,1),data(i,2),data(i,3));
            inver(i+1,:) = mid(1,:);% vinkler(inver(i,:),mid);
            xyz(i,:) = J_Forward_kinematic(inver(i+1,1),inver(i+1,2),inver(i+1,3),inver(i+1,4),inver(i+1,5),true);
            rob_angel = [];
            for led = 1 : 1: 5
                rob_angel(led) = dregres_to_robot(inver(i+1,led));
            end
            if ardino
                set_angel(robor,rob_angel(1),rob_angel(2),rob_angel(3),rob_angel(4),rob_angel(5));
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


function done = j_trajectory_2(t_1,t_2)
%UNTITLED3 Summary of this function goes here%   Detailed explanation goes here
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

function robor = setop_adriuno()
    if ismac
        print("fuck dig");
    elseif isunix
        print("linux");
        a = arduino('/dev/ttyACM0', 'Uno', 'Libraries', 'Servo');
    elseif ispc
        a = arduino('COM3', 'Uno', 'Libraries', 'Servo');
    else
        disp('Platform not supported')
    end
    wrist = servo(a, 'D11'); %, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
    roll = servo(a, 'D10'); %, 'MinPulseDuration', 9e-4, 'MaxPulseDuration', 2e-3);
    elbow = servo(a, 'D9');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
    shoulder = servo(a, 'D6');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
    base = servo(a, 'D5');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
    robor = [base,shoulder,elbow,roll,wrist];
end

function set_angel(robor,a,b,c,d,e)
    per = [a ,b ,c ,d ,e];
    writePosition(robor(5), e);
    writePosition(robor(4), d);
    writePosition(robor(3), 1-c);
    writePosition(robor(2), b);
    writePosition(robor(1), a);
end

function out = dregres_to_robot(x)
    if(x<0)
        x = 360+x;
    end
    out = clamp(mod(x,360),0,180)/180;
end
function out = trim_angls(list)
    for i = 1 : 1 : 5
        if(list(i)<0)
            list(i) = 360+list(i);
        end
        list(i) = mod(list(i),360);
    end
    out = list;
end

function erl = er_lovlig(list)
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

function out = vinkler(now,angls_val)
    vink = [1000,1000,1000,1000];
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
    for i = 1 : 1 : 4
        if not(vink(i) == 1000 && vink(i)< min)
            index = i;
            min = vink(i);
        end
    end
    if index == 0
        out = now;
    else
        out = angls_val(index,:);
    end
end

function data = line_pahfe(data,start,stop,speed)
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
        data = line_pahfe(data,points{i},points{i+1},speed);
    end
    out = data;
end