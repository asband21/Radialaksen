clc; clear; close all; 
%Husk at port nummet skal ændres til jeres port eks"COM14"
%a = arduino('COM14', 'Uno', 'Libraries', 'Servo');
a = arduino('/dev/ttyACM0', 'Uno', 'Libraries', 'Servo');

wrist = servo(a, 'D9'); %, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
roll = servo(a, 'D8'); %, 'MinPulseDuration', 9e-4, 'MaxPulseDuration', 2e-3);
elbow = servo(a, 'D7');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
shoulder = servo(a, 'D6');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
base = servo(a, 'D5');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);

%% Vertical
writePosition(wrist, 0.5);
writePosition(roll, 1);
writePosition(elbow, 0.55);
writePosition(shoulder, 0.65);
writePosition(base, 1);
pause(5) 

%% Null-point
%writePosition(wrist, 0);
%writePosition(roll, 0);
%writePosition(elbow, 0);
%writePosition(shoulder, 0);
%writePosition(base, 0); 
%pause(5) 

%% One-point 
%writePosition(wrist, 1);
%writePosition(roll, 1);
%writePosition(elbow, 1);
%writePosition(shoulder, 1);
%writePosition(base, 1); 
%pause(5)  