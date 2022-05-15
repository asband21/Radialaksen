%%folov fugnsen
function main = folo_line()

    figure(1);
    pungt_1 = [150,100,20];
    pungt_2 = [150,100,150];
    pungt_3 = [150,200,150];
    pungt_4 = [-150,200,150];
    fun1 = j_trajectory_2(pungt_1,pungt_2);
    fun2 = j_trajectory_2(pungt_2,pungt_3);
    fun3 = j_trajectory_2(pungt_3,pungt_4);
    data = run_step(0,0.01,1,fun1);
    data = [data;run_step(0,0.01,1,fun2)];
    data = [data;run_step(0,0.01,1,fun3)];
    siz = size(data);
    inver = zeros(siz(1),5);
    xyz = zeros(siz(1),3);
    for i = 1 : 1 : siz(1)
        pause(0);

        mid = a_invers_kinematic(data(i,1),data(i,2),data(i,3));
        inver(i,:) = mid(1,:);
        xyz(i,:) = J_Forward_kinematic(mid(1,1),mid(1,2),mid(1,3),mid(1,4),mid(1,5),true)
        pause(0.01);

        %a_invers_kinematic()
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
    var(uint8((stop-start)/step)+1,:) = [0,0,0]; 
    for i = start : step : stop
        var(caunter,:) = fun(i);
        pause(delay);
        caunter = caunter+1;
    end
    done = var
end