a = 0
b = 0
c = 0
d = 0
e = 90

kor = J_Forward_kinematic(a,b,c,d,e)
vink = a_invers_kinematic(kor(1), kor(2) ,kor(3))
v1 = J_Forward_kinematic(vink(1,1),vink(1,2),vink(1,3),vink(1,4),vink(1,5));
v2 = J_Forward_kinematic(vink(2,1),vink(2,2),vink(2,3),vink(2,4),vink(2,5));
v3 = J_Forward_kinematic(vink(3,1),vink(3,2),vink(3,3),vink(3,4),vink(3,5));
v4 = J_Forward_kinematic(vink(4,1),vink(4,2),vink(4,3),vink(4,4),vink(4,5));
start_vin = []
vin_b = []
vin_c = []
vin_3 = []
vin_4 = []

dif = []
y = []
for ongange = 0 : 5 : 360
    b = ongange;
    f = 2
    jjjj = size(start_vin);
    kor = J_Forward_kinematic(a,b,c,d,e);
    x(jjjj+1) = kor(2);
    y(jjjj+1) = kor(3);
    vink = a_invers_kinematic(kor(1), kor(2) ,kor(3));
    iiii = size(vink)
    for row = 1 : 1 : iiii(1)
        for kol = 1 : 1 : iiii(2)
            if(vink(row,kol)<0)
                vink(row,kol) = vink(row,kol)+360
            end
        end
    end
    vin_b(jjjj(2)+1)  = vink(1,f);
    slut_c(jjjj(2)+1) = vink(2,f);
    vin_3(jjjj(2)+1)  = vink(3,f);
    vin_4(jjjj(2)+1)  = vink(4,f);
    dif(jjjj(2)+1,:) =  vink(5,:);
    start_vin(jjjj(2)+1) = ongange;
end
i = [start_vin;vin_b;slut_c;vin_3;vin_4].'
plot2([start_vin;vin_b].')

%plot2([x;y].')
%xlim([-350 350])
%ylim([-350 350])
%zlim([0 700])
%axis()
%dif = dif