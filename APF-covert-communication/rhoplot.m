data=xlsread('rho.xlsx'); %% matlab读取Excel中的数据，并赋值给 data 数组
fillcolor1=[0.85, 0.33, 0.10];fillcolor2=[0.93, 0.69, 0.13];fillcolor3=[0.00, 0.45, 0.74];fillcolor4=[0.54,0.53,0.45];

plot(wx, wy,"k"+"^",'MarkerFaceColor','k','markersize',7);hold on;
plot(x2, y2,'or','markersize',12,'LineWidth',2);hold on;
% rho
% 0.03
x=data(1,1:length(x_opt)); 
y=data(2,1:length(y_opt)); 
plot(x,y,'Color',fillcolor4,'LineWidth',1);hold on;
% 
% 0.05
x=data(3,1:length(x_opt)); 
y=data(4,1:length(y_opt)); 
plot(x,y,'Color',fillcolor2,'LineWidth',1);hold on;

% 0.08
x=data(5,1:length(x_opt)); 
y=data(6,1:length(y_opt)); 
plot(x,y,'Color',fillcolor1,'LineWidth',1);hold on;

% none
x=data(7,1:length(x_opt)); 
y=data(8,1:length(y_opt)); 
plot(x,y,'Color',fillcolor3,'LineWidth',1);hold on;

% 0.05 TDSCP
x=data(11,1:11); 
y=data(12,1:11); 
plot(x,y,'*-','Color',[0.21,0.47,0.49],'LineWidth',1);hold on;

% plot(0,0,'p','Color',fillcolor3);hold on;
% plot(45,40,'^','Color',fillcolor1);hold on;
% plot(35,30,'^','Color',fillcolor2);hold on;
% plot(25,20,'^','Color',fillcolor4);hold on;

xlim([0 100]);ylim([0 80]); 
xlabel('x[m]')
ylabel('y[m]')
legend('{Bob}','{Willie}','{APF, \rho=0.03}','{APF, \rho=0.05}','{APF, \rho=0.08}','{APF, Willie default}','{TDSCP, \rho=0.05}','Location','northwest'); 
