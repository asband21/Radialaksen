%{
mani_degree = [-5.1,5.6,3.3,1,4.12] ;
for n=1:1:5 
    if mani_degree(n) > 1.0 
    integ=floor(mani_degree(n));
    mani_degree(n)=mani_degree(n)-integ;
    elseif mani_degree(n)<0 
   integ=floor(mani_degree(n));
   mani_degree(n)=mani_degree(n)-integ;
    end   
end
mani_degree
degree=[1, 5.5, 4.7, 0, 0.8];

degree = degree*pi/180 ;


%}

angle_cov = @(x) x/180

angle_cov(45)
sin(3.14)