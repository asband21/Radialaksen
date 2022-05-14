a = 0
b = 90
c = 90
d = 0
e = 90
kor = [];
v1 = [];    
v2 = [];
v3 = []; 
v4 = [];
                                                                                                                        
step = 180/18
for ongange = 0 : step : 180
    ongange = ongange
for ongange_b = 0 : step : 180              
for ongange_c = 0 : step : 180
    lengf = ongange/step*180/step*180/step+ongange_b/step*180/step+ongange_c/step;
    a = ongange;
    b = ongange_b;
    c = ongange_c;
    var2 = lengf(1)+1
    kor(lengf(1)+1,:) = J_Forward_kinematic(a,b,c,d,e);
    vink = a_invers_kinematic(kor(lengf(1)+1,1), kor(lengf(1)+1,2) ,kor(lengf(1)+1,3));
    v1(lengf(1)+1,:) = J_Forward_kinematic(vink(1,1),vink(1,2),vink(1,3),vink(1,4),vink(1,5));
    v2(lengf(1)+1,:) = J_Forward_kinematic(vink(2,1),vink(2,2),vink(2,3),vink(2,4),vink(2,5));
    v3(lengf(1)+1,:) = J_Forward_kinematic(vink(3,1),vink(3,2),vink(3,3),vink(3,4),vink(3,5));
    v4(lengf(1)+1,:) = J_Forward_kinematic(vink(4,1),vink(4,2),vink(4,3),vink(4,4),vink(4,5));
end
end
end
kor = kor
kip = [v1.';v2.';v3.';v4.'].'
varb = 3;
plot3(kor(:,1),kor(:,2),kor(:,3),kip(:,varb*3+1),kip(:,varb*3+2),kip(:,varb*3+3),kor(:,1)-kip(:,varb*3+1),kor(:,2)-kip(:,varb*3+2),kor(:,3)-kip(:,varb*3+3))
%plot3(kor(:,1),kor(:,2),kor(:,3),v1(:,1),v1(:,2),v1(:,3),v2(:,1),v2(:,2),v2(:,3),v3(:,1),v3(:,2),v3(:,3),v4(:,1),v4(:,2),v4(:,3))
%plot3(kor(:,1),kor(:,2),kor(:,3),v1(:,1),v1(:,2),v1(:,3))
xlim([-350 350])
ylim([-350 350])
zlim([-200 500])