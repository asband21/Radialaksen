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
    x2 = x; +((y)/len_2d(y,x))*O__1; % l__3*sin(a)*1.01 ; %
    y2 = y; +((-x)/len_2d(y,x))*O__1; % l__3*cos(a)*1.01 ; %-((-x)/len_2d(y,x))*O__1
    z2 = z-l__0;
    len2 = len_2d(len_2d(x2,y2),z2);
    indhol = ((l__1^2)+(l__2^2)-len2^2)/(2*l__1*l__2);
    c = acos(clamp(indhol,-1,1));
    c2 = -c;

    %mid_x =  
    %med_y =  

    %b2 = atan2(z2,len2) - acos((len2^2+l__1^2-l__2^2)/(len2*l__1*2));
    %b =  atan2(z2*l__1+z2*l__2*cos(c)-len2*l__2*sin(c),len2*l__1+len2*l__2*cos(c)+z2*l__2*sin(c));
    %b =  atan2(len2*l__1+len2*l__2*cos(c)+z2*l__2*sin(c),z2*l__1+z2*l__2*cos(c)-len2*l__2*sin(c));
    %b2 = atan2(z2*l__1+z2*l__2*cos(c2)-len2*l__2*sin(c2) ,len2*l__1+len2*l__2*cos(c2)+z2*l__2*sin(c2));
    %if(x*y>0)
            b = atan2(z2,len_2d(x2,y2)) + acos(clamp((len2^2+l__1^2-l__2^2)/(len2*l__1*2),-1,1));
            b2 = atan2(z2,len_2d(x2,y2)) - acos(clamp((len2^2+l__1^2-l__2^2)/(len2*l__1*2),-1,1));
    %else
    %        b = atan2(z2,len_2d(x2,y2)) + acos(clamp((len2^2+l__1^2-l__2^2)/(len2*l__1*2),-1,1));
    %        b2 = atan2(z2,-len_2d(x2,y2)) + acos(clamp((len2^2+l__1^2-l__2^2)/(len2*l__1*2),-1,1));
    %end
    e = c+b-pi;
    e2 = c2 + b2 -pi;


    a =  -(180*a)/pi;
    b =  (180*b)/pi;
    c =  (180*c)/pi-90;
    d =  (180*d)/pi;
    e =  (180*e)/pi;
    a2 = (180*a2)/pi;
    b2 = (180*b2)/pi;
    c2 = (180*c2)/pi-90;
    e2 = (180*e2)/pi;
    
    output = [a, b, c ,d, e; a, b2, c2 ,d, e2; mod(a+180,360), 180-b, 180-c ,d, 180-e; mod(a+180,360), 180-b2, 180-c2 ,d, 180-e2];
    %if(a > pi)
    %    output = [a, b, c ,d, e; a2 pi-b]
    %else
    %    output = [a, b, c ,d, e; a2  ]
    %end
end