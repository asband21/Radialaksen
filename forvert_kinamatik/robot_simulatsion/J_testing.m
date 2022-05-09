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

%% Vertical
writePosition(wrist,0.5);
writePosition(roll,0.5);
writePosition(elbow,0.5);
writePosition(shoulder,0.5);
writePosition(base,0.5); 
