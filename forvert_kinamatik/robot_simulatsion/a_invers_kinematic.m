function output = a_invers_kinematic(x,y,z)
    l__0 = 97.15;
    l__1 = 119.65;
    l__2 = 120.35;
    l__3 = 62.6;    
    O__1 = 13.9;
    O__2 = 5.25;
    
    d = 0;

    len_2d = @(x,y) (sqrt(x^2+y^2));
    a = atan2(x,y) -atan(O__1/len_2d(x,y));
    a2 = mod(a+pi,2*pi);
    x2 = x-l__3*sin(a); %+((y)/len_2d(y,x))*O__1 - l__3*sin(a)*1.01 ; %
    y2 = y-l__3*cos(a);%+((-x)/len_2d(y,x))*O__1 - l__3*cos(a)*1.01 ; %-((-x)/len_2d(y,x))*O__1
    z2 = z-l__0;
    len2 = len_2d(len_2d(x2,y2),z2); % finding the length from origo to therede* joint
    %indhol = ((l__1^2)+(l__2^2)-len2^2)/(2*l__1*l__2);
    c = acos(clamp(((l__1^2)+(l__2^2)-len2^2)/(2*l__1*l__2),-1,1));
    c2 = -c;
    b = atan2(z2,len_2d(x2,y2)) + acos(clamp((len2^2+l__1^2-l__2^2)/(len2*l__1*2),-1,1));
    b2 = atan2(z2,len_2d(x2,y2)) - acos(clamp((len2^2+l__1^2-l__2^2)/(len2*l__1*2),-1,1));

    x3 = len_2d(x2,y2)-cos(c)*l__1;
    z3 = z2-sin(c)*l__1;
    e = atan2(x3,z3);
   
    e2 = e+pi;
  
    a =  -(180*a)/pi; %fiding to the phycial robot
    b =  (180*b)/pi;
    c =  (180*c)/pi-90;
    d =  (180*d)/pi;
    e =  (180*e)/pi;
    a2 = (180*a2)/pi;
    b2 = (180*b2)/pi;
    c2 = (180*c2)/pi-90;
    e2 = (180*e2)/pi;
    
    output = [a, b, c ,d, e+10; a, b2, c2 ,d, e2+10; mod(a+180,360), 180-b, 180-c ,d, 180-e; mod(a+180,360), 180-b2, 180-c2 ,d, 180-e2];
   
end