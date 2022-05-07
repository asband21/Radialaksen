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

%% A

% writePosition(wrist,90/180);
% writePosition(roll,90/180);
% writePosition(elbow,160/180);
% writePosition(shoulder,90/180);
% writePosition(base,88/180); 
% 
% pause(2) 

for n = 0:1:45

    writePosition(wrist,(90-n)/180);
    writePosition(roll,(90+n*2)/180);
    writePosition(elbow,(90+n*1.556)/180);
    writePosition(shoulder,(90-n*0.666)/180);
    writePosition(base,88/180);

    pause(0.01)
end

pause(10)

for a = 1:1:10

    for n = 20:-1:0

        writePosition(wrist,45/180);
        writePosition(roll,180/180);
        writePosition(elbow,(180-n)/180);
        writePosition(shoulder,(40+n)/180);
        writePosition(base,88/180); 

        pause(0.01)
    end

    for n = 0:1:20 

        writePosition(wrist,45/180);
        writePosition(roll,180/180);
        writePosition(elbow,(180-n)/180);
        writePosition(shoulder,(40+n)/180);
        writePosition(base,88/180); 

        pause(0.01)
    end

end

for n = 45:-1:0

    writePosition(wrist,(90-n)/180);
    writePosition(roll,(90+n*2)/180);
    writePosition(elbow,(90+n*1.556)/180);
    writePosition(shoulder,(90-n*0.666)/180);
    writePosition(base,88/180); 

    pause(0.01)
end
