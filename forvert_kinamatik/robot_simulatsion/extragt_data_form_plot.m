clear
fig = openfig('a_func/dif_4.fig');
axObjs = fig.Children
dataObjs = axObjs.Children
x = dataObjs(1).XData;
y = dataObjs(1).YData;
z = dataObjs(1).ZData;
x2 = dataObjs(2).XData;
y2 = dataObjs(2).YData;
z2 = dataObjs(2).ZData;
x3 = dataObjs(3).XData;
y3 = dataObjs(3).YData;
z3 = dataObjs(3).ZData;
var = [x;y;z;x2;y2;z2;x3;y3;z3].'
%plot3(x,y,z,x2,y2,z2,x3,y3,z3)