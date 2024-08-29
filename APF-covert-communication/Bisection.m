function output=Bisection(L,rho,error)
% input:L 判决次数
% input:rho 最小检测错误率要求值
% output:error 二分查找误差
syms t
a=0.01; b=3; % changed
c=factorial(L-1);
y1=int(t^(L-1)*exp(-t),t,L*log(1+a)/a,L*(1+a)*log(1+a)/a)/c-rho;
y2=int(t^(L-1)*exp(-t),t,L*log(1+b)/b,L*(1+b)*log(1+b)/b)/c-rho;
%由于 最小检测错误率对信噪比具有单调递减 特性
while(y1*y2<0)
    d=(a+b)/2;
    y3=int(t^(L-1)*exp(-t),t,L*log(1+d)/d,L*(1+d)*log(1+d)/d)/c-rho;
    if(y1*y3<0)
        b=d;
    else
        a=d;
    end
    y1=int(t^(L-1)*exp(-t),t,L*log(1+a)/a,L*(1+a)*log(1+a)/a)/c;
    y1=double(y1)-rho;
    y2=int(t^(L-1)*exp(-t),t,L*log(1+b)/b,L*(1+b)*log(1+b)/b)/c;
    y2=double(y2)-rho;
    if(b-a<error)
        break;
    end
end
output = (a+b)/2;
 