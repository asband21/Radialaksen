function f = j_trajectory(t_1,t_2)
r_1 = t_2(1)-t_1(1);
r_2=t_2(2)-t_1(2);
r_3=t_2(3)-t_1(3);
f= @(x)[t_1(1)+x*r_1,t_1(2)+x*r_2,t_1(3)+x*r_3];
end