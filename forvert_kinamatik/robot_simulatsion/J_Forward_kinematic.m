function output = J_Forward_kinematic(a, b, c, d, e) 
    l_1 = 119.65;
    l_2 = 120.35;
    l_3 = 62.6; 
    x = -62.6*(-sin(a)*cos(b)*cos(c) + sin(a)*sin(b)*sin(c))*sin(e) + 62.6*(-cos(a)*sin(d) + (sin(a)*cos(b)*sin(c) + sin(a)*sin(b)*cos(c))*cos(d))*cos(e) - 5.25*cos(a)*cos(d) - 5.25*(sin(a)*cos(b)*sin(c) + sin(a)*sin(b)*cos(c))*sin(d) - 120.35*cos(a)*sin(d) + 120.35*(sin(a)*cos(b)*sin(c) + sin(a)*sin(b)*cos(c))*cos(d) + 19.15*cos(a) + 119.65*sin(a)*sin(b) %(-(-sin(a)*cos(b)*cos(c) + sin(a)*sin(b)*sin(c))*sin(e) + (-cos(a)*sin(d) + (sin(a)*cos(b)*sin(c) + sin(a)*sin(b)*cos(c))*cos(d))*cos(e))*l_3 + (-cos(a)*sin(d) + (sin(a)*cos(b)*sin(c) + sin(a)*sin(b)*cos(c))*cos(d))*l_2 + sin(a)*sin(b)*l_1; 
    y =  -62.6*(cos(a)*cos(b)*cos(c) - cos(a)*sin(b)*sin(c))*sin(e) + 62.6*(-sin(a)*sin(d) + (-cos(a)*cos(b)*sin(c) - cos(a)*sin(b)*cos(c))*cos(d))*cos(e) - 5.25*sin(a)*cos(d) - 5.25*(-cos(a)*cos(b)*sin(c) - cos(a)*sin(b)*cos(c))*sin(d) - 120.35*sin(a)*sin(d) + 120.35*(-cos(a)*cos(b)*sin(c) - cos(a)*sin(b)*cos(c))*cos(d) + 19.15*sin(a) - 119.65*cos(a)*sin(b);%(-(cos(a)*cos(b)*cos(c) - cos(a)*sin(b)*sin(c))*sin(e) + (-sin(a)*sin(d) + (-cos(a)*cos(b)*sin(c) - cos(a)*sin(b)*cos(c))*cos(d))*cos(e))*l_3 + (-sin(a)*sin(d) + (-cos(a)*cos(b)*sin(c) - cos(a)*sin(b)*cos(c))*cos(d))*l_2 - cos(a)*sin(b)*l_1;
    z = 97.15 - 62.6*(1.*sin(b)*cos(c) + 1.*cos(b)*sin(c))*sin(e) + 62.6*(-1.*sin(b)*sin(c) + 1.*cos(b)*cos(c))*cos(d)*cos(e) - 5.25*(-1.*sin(b)*sin(c) + 1.*cos(b)*cos(c))*sin(d) + 120.35*(-1.*sin(b)*sin(c) + 1.*cos(b)*cos(c))*cos(d) + 119.65*cos(b);%(-(sin(b)*cos(c) + cos(b)*sin(c))*sin(e) + (-sin(b)*sin(c) + cos(b)*cos(c))*cos(d)*cos(e))*l_3 + (-sin(b)*sin(c) + cos(b)*cos(c))*cos(d)*l_2 + cos(b)*l_1; 
    output=[x;y;z];
end

