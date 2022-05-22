function output = clamp(x, min, max)
    var = x;
    if x < min
        var = min;
    end
    if x > max 
        var = max;
    end
    output = var;
end
