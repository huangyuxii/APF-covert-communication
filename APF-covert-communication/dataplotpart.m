data=xlsread('datapart.xlsx'); %% matlab读取Excel中的数据，并赋值给 data 数组
fillcolor1=[0.85, 0.33, 0.10];fillcolor2=[0.93, 0.69, 0.13];fillcolor3=[0.00, 0.45, 0.74];
% T rho
% 8 1e-2
x=data(1,1:length(x_opt));
y=data(2,1:length(y_opt)); 
plot(x,y,'--','Color',fillcolor1);hold on;
% 8 0.05
x=data(5,1:length(x_opt));
y=data(6,1:length(y_opt)); 
plot(x,y,'--','Color',fillcolor2);hold on;
% 8 0.3
x=data(9,1:length(x_opt));
y=data(10,1:length(y_opt)); 
plot(x,y,'--','Color',fillcolor3);hold on;

% 10 1e-2
x=data(13,1:length(x_opt));
y=data(14,1:length(y_opt)); 
plot(x,y,'-.','Color',fillcolor1);hold on;
% 10 0.05
x=data(15,1:length(x_opt));
y=data(16,1:length(y_opt)); 
plot(x,y,'-.','Color',fillcolor2);hold on;
% 10 0.3
x=data(19,1:length(x_opt));
y=data(20,1:length(y_opt)); 
plot(x,y,'-.','Color',fillcolor3);hold on;

% 部分遮蔽边界
x=data(7,:); 
y=data(8,:); 
plot(x,y,'p','Color',fillcolor2);hold on;
x=data(11,:); 
y=data(12,:); 
plot(x,y,'p','Color',fillcolor3);hold on;
x=data(17,:); 
y=data(18,:); 
plot(x,y,'p','Color',fillcolor2);hold on;
x=data(21,:); 
y=data(22,:); 
plot(x,y,'p','Color',fillcolor3);hold on;
% 圆形边界
t = linspace(0, 2*pi);
plot(32.8515 * cos(t) + x2 , 32.8515 * sin(t) + y2,'g:');
t = linspace(0, 2*pi);
plot(18.5926 * cos(t) + x2 , 18.5926 * sin(t) + y2,'g:');
% 

plot([x0 x1],[y0 y1],'o');hold on;
plot(wx,wy,'b^');hold on;
plot(x2,y2,'r^');hold on;
xlim([30 100]);ylim([30 80]);
xlabel('x(m)');
ylabel('y(m)');
legend('{T=8 \rho=0.05}','{T=8 \rho=0.5}','{T=8 \rho=0.8}', '{T=10 \rho=0.05}','{T=10 \rho=0.5}','{T=10 \rho=0.8}','Location','northwest'); %,'{部分遮蔽情况下}'
% title('不同rho与T下部分遮蔽场内的无人机轨迹图')