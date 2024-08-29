data=xlsread('wtob.xlsx'); %% matlab读取Excel中的数据，并赋值给 data 数组
fillcolor1=[0.85, 0.33, 0.10];fillcolor2=[0.93, 0.69, 0.13];fillcolor3=[0.00, 0.45, 0.74];fillcolor4=[0.54,0.53,0.45];

plot(wx, wy,"k"+"^",'MarkerFaceColor','k','markersize',7);hold on;
% plot(x2, y2,'or','markersize',12,'LineWidth',2);hold on;
plot(40,40,'o','markersize',12,'Color',fillcolor1,'LineWidth',2);hold on;
plot(30,30,'o','markersize',12,'Color',fillcolor2,'LineWidth',2);hold on;
plot(20,20,'o','markersize',12,'Color',fillcolor4,'LineWidth',2);hold on;

% willie SCP Nscp=11;
% (40,40)
Nscp=11;
x=data(11,1:Nscp); 
y=data(12,1:Nscp); 
plot(x,y,'-s','Color',fillcolor1);hold on;

% willie APF
% (45,40)
x=data(1,1:length(x_opt)); 
y=data(2,1:length(y_opt)); 
plot(x,y,'Color',fillcolor1);hold on;
% 
% (35,30)
x=data(3,1:length(x_opt)); 
y=data(4,1:length(y_opt)); 
plot(x,y,'Color',fillcolor2);hold on;

% (25,20)
x=data(5,1:length(x_opt)); 
y=data(6,1:length(y_opt)); 
plot(x,y,'Color',fillcolor4);hold on;

% none
x=data(7,1:length(x_opt)); 
y=data(8,1:length(y_opt)); 
plot(x,y,'Color',fillcolor3);hold on;
% 

% 
% (35,30)
% x=data(13,1:Nscp); 
% y=data(14,1:Nscp); 
% plot(x,y,'-s','Color',fillcolor2);hold on;
% 
% % (25,20)
% x=data(15,1:Nscp); 
% y=data(16,1:Nscp); 
% plot(x,y,'-s','Color',fillcolor4);hold on; %,'Color',fillcolor4

% none
% x=data(17,1:length(40)); 
% y=data(18,1:length(40)); 
% plot(x,y,'Color',fillcolor3);hold on;


xlim([0 100]);ylim([0 80]); 
xlabel('x(m)')
ylabel('y(m)')
legend( 'Bob','Willie, q_w=(40, 40)','Willie, q_w=(30, 30)','Willie, q_w=(20, 20)','TDSCP, q_w=(40, 40)','APF, q_w=(40, 40)','APF, q_w=(30, 30)','APF, q_w=(20, 20)','APF, Willie default','Location','northwest'); 
% legend( 'Bob','','','','APF, q_w=(40, 40)','APF, q_w=(30, 30)','APF, q_w=(20, 20)','APF, Willie 缺失','TDSCP, q_w=(40, 40)','Location','northwest'); 