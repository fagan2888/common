function y=uniform_ab(n,min_y,max_y);

x=rand(n,1);    
min_x=0;max_x=1;
y=min_y+(x-min_x)*(min_y-max_y)/(min_x-max_x);


