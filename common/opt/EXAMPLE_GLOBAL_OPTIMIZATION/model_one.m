function xdot = model_one(t,x,p)

xdot(1) = p(1)-x(1)*p(2)+x(2)*p(3)-p(5)*x(2)*t/(p(2)+t)*sin(t);
xdot(2) = p(3)-x(1)*x(2)+p(2)*t/(p(5)+t);

xdot = xdot(:);

end