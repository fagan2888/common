function xdot = model_two(t,x,p)

xdot(1) = p(1)-2*x(1)*p(2)+x(2)*p(3);
xdot(2) = p(3)-x(1)*x(2);

xdot = xdot(:);

end