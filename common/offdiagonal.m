function C=offdiagonal(A);
    [m,n]=size(A);
    idx=eye(m,n);
    B=(1-idx).*A;
    C=A(~idx);