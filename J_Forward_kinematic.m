function output = J_Forward_kinematic(a, b, c, d, e,plot_bool)
    if nargin < 6
        plot_bool = false;
    end
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
    transformation_matrix_list = {A__0, A ,A__2,B,C,E,E__2,F,G,H,J};
    x2 = [];
    y2 = [];
    z2 = [];
    identity_matrix = [1 0 0 0; 0 1 0 0; 0 0 1 0 ; 0 0 0 1];
    size_P_transformation_matrix_list = size(transformation_matrix_list);
    for i = 1 : 1 : size_P_transformation_matrix_list(2)
        identity_matrix = identity_matrix*transformation_matrix_list{i};
        x2(i) = identity_matrix(1,4);
        y2(i) = identity_matrix(2,4);
        z2(i) = identity_matrix(3,4);
    end
    x = x2(size_P_transformation_matrix_list(2));
    y = y2(size_P_transformation_matrix_list(2));
    z = z2(size_P_transformation_matrix_list(2));
    if plot_bool
        plot3(x2,y2,z2)
        xlim([-350 350]);
        ylim([-350 350]);
        zlim([0 500])
        %view(0,90)
        %view(a*180/pi+90,0)
    end
    output=[x;y;z];
end

