function output = J_Forward_kinematic(a, b, c, d, e) 
    l_1 = 119.65;
    l_2 = 120.35;
    l_3 = 62.6; 
    x = (-(-sin(a)*cos(b)*cos(c) + sin(a)*sin(b)*sin(c))*sin(e) + (-cos(a)*sin(d) + (sin(a)*cos(b)*sin(c) + sin(a)*sin(b)*cos(c))*cos(d))*cos(e))*l_3 + (-cos(a)*sin(d) + (sin(a)*cos(b)*sin(c) + sin(a)*sin(b)*cos(c))*cos(d))*l_2 + sin(a)*sin(b)*l_1; 
    y = (-(cos(a)*cos(b)*cos(c) - cos(a)*sin(b)*sin(c))*sin(e) + (-sin(a)*sin(d) + (-cos(a)*cos(b)*sin(c) - cos(a)*sin(b)*cos(c))*cos(d))*cos(e))*l_3 + (-sin(a)*sin(d) + (-cos(a)*cos(b)*sin(c) - cos(a)*sin(b)*cos(c))*cos(d))*l_2 - cos(a)*sin(b)*l_1;
    z = (-(sin(b)*cos(c) + cos(b)*sin(c))*sin(e) + (-sin(b)*sin(c) + cos(b)*cos(c))*cos(d)*cos(e))*l_3 + (-sin(b)*sin(c) + cos(b)*cos(c))*cos(d)*l_2 + cos(b)*l_1; 
    output=[x;y;z];
end

