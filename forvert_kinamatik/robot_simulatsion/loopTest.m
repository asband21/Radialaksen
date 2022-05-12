%{
mani_degree = [-5.1,5.6,3.3,1,4.12] ;
for n=1:1:5 
    if mani_degree(n) > 1.0 
    integ=floor(mani_degree(n));
    mani_degree(n)=mani_degree(n)-integ;
    elseif mani_degree(n)<0 
   integ=floor(mani_degree(n));
   mani_degree(n)=mani_degree(n)-integ;
    end   
end
mani_degree
degree=[1, 5.5, 4.7, 0, 0.8];

degree = degree*pi/180 ;

angle_cov = @(x) x/180

angle_cov(45)
sin(3.14) 




Angles = [ 0,0,180;0,12,180;0,7.5,(180+181)/2;0,0,(177+180)/2;0,-7.5,(178+180)/2] 
%} 
clc; clear; close all; 
%Husk at port nummet skal ændres til jeres port eks"COM14"
a = arduino('COM3', 'Uno', 'Libraries', 'Servo');

wrist = servo(a, 'D11'); %, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
roll = servo(a, 'D10'); %, 'MinPulseDuration', 9e-4, 'MaxPulseDuration', 2e-3);
elbow = servo(a, 'D9');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
shoulder = servo(a, 'D6');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
base = servo(a, 'D5');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);

%%trejektory
%start
x1 = 300;
y1 = 100;
z1 = 200;
R1 = 0;
P1 = 0;
Y1 = 0;

%end
x2 = 0;
y2 = 300;
z2 = 40;
R2 = 0;
P2 = 0;
Y2 = 0;

V = 10; % mm/sec

start_cord = [x1;
              y1;
              z1;
              R1;
              P1;
              Y1;];

end_cord = [x2;
            y2;
            z2;
            R2;
            P2;
            Y2;];

%% 

ft= (sqrt((x2-x1)^2+(y2-y1)^2+(z2-z1)^2))/V;

a0 = start_cord;
a1 = zeros(length(start_cord));
a2 = 3/(ft*ft)*(end_cord-start_cord);
a3 = -2/(ft*ft*ft)*(end_cord-start_cord);

t=0:0.10:ft;
for i=1:length(start_cord)
 cord(i,:)=a0(i)+a1(i)*t+a2(i)*t.^2+a3(i)*t.^3;
end


% %% A
% 
% writePosition(wrist,150/180);
% writePosition(roll,0/180);
% writePosition(elbow,(180-20)/180);
% writePosition(shoulder,20/180);
% writePosition(base,90/180); 

for k = 1:1:10
%movement
    for n = 1:0.1:ft+1
        n
        x = cord(1,n)
        y = cord(2,n)
        z = cord(3,n)
        Roll = cord(4,n)
        Pitch = cord(5,n)
        Yaw = cord(6,n)

        %invers

        %robot
        writePosition(wrist,?/180);
        writePosition(roll,?/180);
        writePosition(elbow,(180-?)/180);
        writePosition(shoulder,?/180);
        writePosition(base,?/180); 


    end

    for n = ft+1:-0.1:1
        n
        x = cord(1,n)
        y = cord(2,n)
        z = cord(3,n)
        Roll = cord(4,n)
        Pitch = cord(5,n)
        Yaw = cord(6,n)

        %invers

        %robot
        writePosition(wrist,?/180);
        writePosition(roll,?/180);
        writePosition(elbow,(180-?)/180);
        writePosition(shoulder,?/180);
        writePosition(base,?/180); 


    end
    %count
end