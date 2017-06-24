% given original acf, g_x, computes the acf of the y, where y= (1-rho L) x
function g_y = filter_acf(g_x,rho,nlags);


T=rows(g_x);
omega = zeros(T,1);
S_x = zeros(T,1);
for k = 0:T-1,
    omega(k+1) = 2*pi*k/T;
    S_x(k+1)=  g_x(1);
    for j= 1:T-1;
    S_x(k+1) = S_x(k+1)+ 2* g_x(j+1)*cos(omega(k+1)*j);
    end;
end

cexp = exp(-i*omega);
den = 1;
num = (1-rho*cexp)  ;
ff = num./den;
gain = ff.*conj(ff);
y = ifft(gain.*S_x);

g_y=real(y(1:nlags+1));

