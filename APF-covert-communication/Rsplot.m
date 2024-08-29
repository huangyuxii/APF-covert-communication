%% rho mix= 0.05
% data=xlsread('rhomixRs.xlsx'); %% matlab读取Excel中的数据，并赋值给 data 数组
% fillcolor1=[0.85, 0.33, 0.10];fillcolor2=[0.93, 0.69, 0.13];fillcolor3=[0.00, 0.45, 0.74];
% % T=8
% % x=1:1:8000;
% x=(1:1:12000)/100;
% % changflag
% % 1
% y=data(1,1:12000);
% for i=1:1:4000
%     y(8000+i)=y(8000);
% end
% plot(x,y,'--','Color',fillcolor1);hold on;
% % 2
% y=data(3,1:12000);
% for i=1:1:4000
%     y(8000+i)=y(8000);
% end
% plot(x,y,'--','Color',fillcolor3);hold on;
% 
% % T=10
% x=(1:1:12000)/100;
% % changflag
% % 1
% y=data(4,1:12000);
% for i=1:1:2000
%     y(10000+i)=y(10000);
% end
% plot(x,y,'-.','Color',fillcolor1);hold on;
% % 2
% y=data(6,1:12000);
% for i=1:1:2000
%     y(10000+i)=y(10000);
% end
% plot(x,y,'-.','Color',fillcolor3);hold on;
% 
% % T=13
% x=(1:1:12000)/100;
% % changflag
% % 1
% y=data(7,1:12000);
% plot(x,y,'-','Color',fillcolor1);hold on;
% % 2
% y=data(8,1:12000);
% plot(x,y,'-','Color',fillcolor3);hold on;
% 
% xlim([0 120]);ylim([0 4]);
% xlabel('s(m)')
% ylabel('Achieved capacity (bit/Hz)')
% legend('{T=8 non-CC}','{T=8 CC}','{T=10 non-CC}','{T=10 CC}','{T=13 non-CC}','{T=13 CC}','Location','northwest');

%% T mix= 10
data=xlsread('TmixRs.xlsx'); %% matlab读取Excel中的数据，并赋值给 data 数组
fillcolor1=[0.85, 0.33, 0.10];fillcolor2=[0.93, 0.69, 0.13];fillcolor3=[0.00, 0.45, 0.74];
% rho=0.01
x=(1:1:10000)/100;
% changflag
% 1
y=data(2,1:10000); 
plot(x,y,'--','Color',fillcolor2);hold on;
% 2
y=data(3,1:10000);
plot(x,y,'--','Color',fillcolor3);hold on;

% rho=0.05
% changflag
% 1
y=data(5,1:10000); 
plot(x,y,'-.','Color',fillcolor2);hold on;
% 2
y=data(6,1:10000);
plot(x,y,'-.','Color',fillcolor3);hold on;

% rho=0.3
% changflag
% 1
y=data(7,1:10000);
plot(x,y,'-','Color',fillcolor3);hold on;
% 2
y=data(8,1:10000); 
plot(x,y,'-','Color',fillcolor2);hold on;

xlim([0 100]);ylim([0 3]);
xlabel('s(m)')
ylabel('Achieved capacity (bit/Hz)')
legend('{rho=0.01 non-CC}','{rho=0.01 CC}','{rho=0.05 non-CC}','{rho=0.05 CC}','{rho=0.3 non-CC}','{rho=0.3 CC}','Location','northwest');
% % 黄色为非遮蔽情况