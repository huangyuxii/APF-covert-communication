close all;
rho=0.05;
snr1=Bisection(5,rho,0.01)
snr2=1000;
H=100;

global wx; 
global wy;
global x2; 
global y2;

wx=0; wy=0;
x2=40; y2=40;
% 边界点
x_save=x2;
y_save=y2;
disp(snr2/snr1-H^2);
R_w=(snr2/snr1-H^2)^0.5;
disp(['convert rho= ' num2str(rho) ' convert Rw=' num2str(R_w)]);

% 极小值点
minF=100;
minx=0;miny=0;
mini=1;

xi=1;yi=1;si=1;si0=1;

for x=-200:10:120
    for y=-200:10:120
        r=[x,y];
        r0=norm(r);
        rw=[x-x2,y-y2];
        rw0=norm(rw);
        if snr1*(rw0^2+H^2)>snr2
            FX(xi,yi)=-1*snr2/log(2)*r(1)/(r0^2+H^2)/(r0^2+H^2+snr2);
            FY(xi,yi)=-1*snr2/log(2)*r(2)/(r0^2+H^2)/(r0^2+H^2+snr2);
        else
            FX(xi,yi)=snr1/log(2)/(r0^2+H^2+(rw0^2+H^2)*snr1)/(r0^2+H^2)*(rw(1)*(r0^2+H^2)-r(1)*(rw0^2+H^2));
            FY(xi,yi)=snr1/log(2)/(r0^2+H^2+(rw0^2+H^2)*snr1)/(r0^2+H^2)*(rw(2)*(r0^2+H^2)-r(2)*(rw0^2+H^2));
        end

        yi=yi+1;
    end
    yi=1;
    xi=xi+1;
end

x=-200:10:120;
y=-200:10:120;

set(0,'defaultAxesFontName', 'TimesSimSun'); %坐标轴
set(0,'defaultTextFontName', 'TimesSimSun'); %文字
%% 2D
plot(wx, wy,"k"+"^",'MarkerFaceColor','k','markersize',7);hold on;
plot(x2, y2,'or','markersize',12,'LineWidth',2);
% 绘制向量图
[Y,X]=meshgrid(y,x);
quiver(X,Y,FX,FY);hold on;
xlim([-100 120]);ylim([-100 100]);
% set(gca,'xtick',[],'ytick',[],'ztick',[],'xcolor','w','ycolor','w','zcolor','w')

% title(['(a)  Potential field diagram with \rho=' num2str(rho) '.']);


% 绘制covert boundary
% hhx=linspace(-R_w+x2,R_w+x2,10000); 
% hhy=-(R_w^2-(hhx-x2).^2).^0.5+y2;
% hhy2=(R_w^2-(hhx-x2).^2).^0.5+y2;
% plot(hhx,hhy,'r--','LineWidth',2);hold on;
% plot(hhx,hhy2,'r--','LineWidth',2);hold on;

% legend('{Bob}','{Willie}','','隐蔽边界');
% legend('{Bob}','{Willie}');

%% 3D
% [Y,X]=meshgrid(y,x);
% surfc(X,Y,R);
% grid on






