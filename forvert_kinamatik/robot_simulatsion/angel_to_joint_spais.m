function output = angel_to_joint_spais(list)
    list = bouns(list);
    output = (list(1)*list(2))/180+list(1);
end