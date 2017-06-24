function quicktsplot(x);
[T,n]=size(x);
for i=1:n;
plot(x(:,i)),title(num2str(i));pause;end;
