function output = J_Forward_kinematic(a, b, c, d, e) 
    l__0 = 97.15;
    l__1 = 119.65;
    l__2 = 120.35;
    l__3 = 62.6;    
    O__1 = 13.9;
    O__2 = 5.25;
    a = (pi*a)/180;
    b = (pi*b)/180-(pi/2);
    c = (pi*c)/180-(pi/2);
    d = (pi*d)/180;
    e = (pi*e)/180-(pi/2);
    A__0 = [1, 0, 0, 0 ; 0, 1, 0, 0 ; 0, 0, 1, 0 ; 0, 0, l__0, 1].';
    A = [cos(a), sin(a), 0, 0 ; -sin(a), cos(a), 0, 0 ; 0, 0, 1, 0 ; 0, 0, 0, 1].';
    A__2 =[1, 0, 0, 0 ; 0, 1, 0, 0 ; 0, 0, 1, 0 ; O__1, 0, 0, 1].';
    B = [1, 0, 0, 0 ; 0, cos(b), sin(b), 0 ; 0, -sin(b), cos(b), 0 ; 0, 0, 0, 1].';
    C = [1, 0, 0, 0 ; 0, 1, 0, 0 ; 0, 0, 1, 0 ; 0, 0, l__1, 1].';
    E = [1, 0, 0, 0 ; 0, cos(c), sin(c), 0 ; 0, -sin(c), cos(c), 0 ; 0, 0, 0, 1].';
    E__2 =[1, 0, 0, 0 ; 0, 1, 0, 0 ; 0, 0, 1, 0 ; O__2, 0, 0, 1].';
    %F = [cos(d), 0, sin(d), 0 ; 0, 1, 0, 0 ; -sin(d), 0, cos(d), 0 ; 0, 0, 0, 1].';
    F = [cos(d), sin(d), 0, 0 ; -sin(d), cos(d), 0, 0 ; 0, 0, 1, 0 ; 0, 0, 0, 1].';
    G = [1, 0, 0, 0 ; 0, 1, 0, 0 ; 0, 0, 1, 0 ; -O__2, 0, l__2, 1].';
    H = [1, 0, 0, 0 ; 0, cos(e), sin(e), 0 ; 0, -sin(e), cos(e), 0 ; 0, 0, 0, 1].';
    J = [1, 0, 0, 0 ; 0, 1, 0, 0 ; 0, 0, 1, 0 ; 0, 0, l__3, 1].';
    list = {A__0, A ,A__2,B,C,E,E__2,F,G,H,J};
    x2 = [];
    y2 = [];
    z2 = [];
    ind = [1 0 0 0; 0 1 0 0; 0 0 1 0 ; 0 0 0 1];
    jjjj = size(list);
    for i = 1 : 1 : jjjj(2)
        ind = ind*list{i};
        x2(i) = ind(1,4);
        y2(i) = ind(2,4);
        z2(i) = ind(3,4);
    end
    x = x2(jjjj(2));
    y = y2(jjjj(2));
    z = z2(jjjj(2));
    %plot3(x2,y2,z2)
    %xlim([-350 350])
    %ylim([-350 350])
    %zlim([0 700])
    %x = -62.6*(-sin(a)*cos(b)*cos(c) + sin(a)*sin(b)*sin(c))*sin(e) + 62.6*(-cos(a)*sin(d) + (sin(a)*cos(b)*sin(c) + sin(a)*sin(b)*cos(c))*cos(d))*cos(e) - 5.25*cos(a)*cos(d) - 5.25*(sin(a)*cos(b)*sin(c) + sin(a)*sin(b)*cos(c))*sin(d) - 120.35*cos(a)*sin(d) + 120.35*(sin(a)*cos(b)*sin(c) + sin(a)*sin(b)*cos(c))*cos(d) + 19.15*cos(a) + 119.65*sin(a)*sin(b) %(-(-sin(a)*cos(b)*cos(c) + sin(a)*sin(b)*sin(c))*sin(e) + (-cos(a)*sin(d) + (sin(a)*cos(b)*sin(c) + sin(a)*sin(b)*cos(c))*cos(d))*cos(e))*l_3 + (-cos(a)*sin(d) + (sin(a)*cos(b)*sin(c) + sin(a)*sin(b)*cos(c))*cos(d))*l_2 + sin(a)*sin(b)*l_1; 
    %y =  -62.6*(cos(a)*cos(b)*cos(c) - cos(a)*sin(b)*sin(c))*sin(e) + 62.6*(-sin(a)*sin(d) + (-cos(a)*cos(b)*sin(c) - cos(a)*sin(b)*cos(c))*cos(d))*cos(e) - 5.25*sin(a)*cos(d) - 5.25*(-cos(a)*cos(b)*sin(c) - cos(a)*sin(b)*cos(c))*sin(d) - 120.35*sin(a)*sin(d) + 120.35*(-cos(a)*cos(b)*sin(c) - cos(a)*sin(b)*cos(c))*cos(d) + 19.15*sin(a) - 119.65*cos(a)*sin(b);%(-(cos(a)*cos(b)*cos(c) - cos(a)*sin(b)*sin(c))*sin(e) + (-sin(a)*sin(d) + (-cos(a)*cos(b)*sin(c) - cos(a)*sin(b)*cos(c))*cos(d))*cos(e))*l_3 + (-sin(a)*sin(d) + (-cos(a)*cos(b)*sin(c) - cos(a)*sin(b)*cos(c))*cos(d))*l_2 - cos(a)*sin(b)*l_1;
    %z = 97.15 - 62.6*(1.*sin(b)*cos(c) + 1.*cos(b)*sin(c))*sin(e) + 62.6*(-1.*sin(b)*sin(c) + 1.*cos(b)*cos(c))*cos(d)*cos(e) - 5.25*(-1.*sin(b)*sin(c) + 1.*cos(b)*cos(c))*sin(d) + 120.35*(-1.*sin(b)*sin(c) + 1.*cos(b)*cos(c))*cos(d) + 119.65*cos(b);%(-(sin(b)*cos(c) + cos(b)*sin(c))*sin(e) + (-sin(b)*sin(c) + cos(b)*cos(c))*cos(d)*cos(e))*l_3 + (-sin(b)*sin(c) + cos(b)*cos(c))*cos(d)*l_2 + cos(b)*l_1; 
    output=[x;y;z];
end

