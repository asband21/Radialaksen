l__0 = 97.15;
l__1 = 119.65;
l__2 = 120.35;
l__3 = 62.6;
O__1 = 13.9;
O__2 = 5.25;
a = 0
b = 0
c = 0
d = 0
e = 0

x = [];
y = []; 
z = [];

%for a_v = 0 : 20 : 180
%for b_v = 0 : 20 : 180
%for c_v = 0 : 20 : 180
%for d_v = 0 : 20 : 180
%for e_v = 0 : 20 : 180
%    a = (pi*a_v)/180;
%    b = (pi*b_v)/180;
%    c = (pi*c_v)/180;
%    d = (pi*d_v)/180;
%    e = (pi*e_v)/180;

    A__0 = [1, 0, 0, 0 ; 0, 1, 0, 0 ; 0, 0, 1, 0 ; 0, 0, l__0, 1].';
    A = [cos(a), sin(a), 0, 0 ; -sin(a), cos(a), 0, 0 ; 0, 0, 1, 0 ; 0, 0, 0, 1].';
    A__2 =[1, 0, 0, 0 ; 0, 1, 0, 0 ; 0, 0, 1, 0 ; O__1, 0, 0, 1].';
    B = [1, 0, 0, 0 ; 0, cos(b), sin(b), 0 ; 0, -sin(b), cos(b), 0 ; 0, 0, 0, 1].';
    C = [1, 0, 0, 0 ; 0, 1, 0, 0 ; 0, 0, 1, 0 ; 0, 0, l__1, 1].';
    E = [1, 0, 0, 0 ; 0, cos(c), sin(c), 0 ; 0, -sin(c), cos(c), 0 ; 0, 0, 0, 1].';
    E__2 =[1, 0, 0, 0 ; 0, 1, 0, 0 ; 0, 0, 1, 0 ; O__2, 0, 0, 1].';
    F = [cos(d), 0, sin(d), 0 ; 0, 1, 0, 0 ; -sin(d), 0, cos(d), 0 ; 0, 0, 0, 1].';
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
    iiii = size(x);
    x(iiii(2)+1) = x2(jjjj(2));
    y(iiii(2)+1) = y2(jjjj(2));
    z(iiii(2)+1) = z2(jjjj(2));
    plot3(x2,y2,z2)
    %xlim([-250 250])
    %ylim([-250 250])
    %zlim([0 500])
%end
%end
%end
%end
%ppy = a_v
%end
%densityScatter([x,y,z])
%densityScatterChart(x,y)
%scatter3(x,y,z,'blue','filled')
%plot3(x,y,z)
