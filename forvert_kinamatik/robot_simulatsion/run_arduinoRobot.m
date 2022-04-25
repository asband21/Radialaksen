clc; clear; close all; 

a = arduino('COM14', 'Uno', 'Libraries', 'Servo');

wrist = servo(a, 'D9'); %, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
roll = servo(a, 'D8'); %, 'MinPulseDuration', 9e-4, 'MaxPulseDuration', 2e-3);
elbow = servo(a, 'D7');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
shoulder = servo(a, 'D6');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);
base = servo(a, 'D5');%, 'MinPulseDuration', 1e-3, 'MaxPulseDuration', 2e-3);

angle = 1;
writePosition(roll, angle);
writePosition(wrist, angle);
writePosition(elbow, angle);
writePosition(shoulder, angle);
writePosition(base, angle);
pause(1)

for angle = 0:0.01:1
    writePosition(roll, angle);
    writePosition(wrist, angle);
    writePosition(elbow, angle);
    writePosition(shoulder, angle);
    writePosition(base, angle);
    pause(0.01)
end
