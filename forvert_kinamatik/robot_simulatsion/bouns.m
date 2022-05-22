function output = bouns(list)
    list(1) = clamp(list(1),list(2),list(3)+list(2));
    output = list;
end
