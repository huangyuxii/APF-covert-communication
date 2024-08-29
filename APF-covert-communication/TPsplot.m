% rho mix= 0.05
data=xlsread('TPs.xlsx'); %% matlab读取Excel中的数据，并赋值给 data 数组
fillcolor1=[0.85, 0.33, 0.10];fillcolor2=[0.93, 0.69, 0.13];fillcolor3=[0.00, 0.45, 0.74];
% APF
% T=8
% x=1:1:8000;
x=(1:1:12000)/100;
y=data(3,1:12000);
for i=1:1:4000
    y(8000+i)=0;
end
plot(x,y,'--','Color',fillcolor1);hold on;

% T=10
x=(1:1:12000)/100;
y=data(2,1:12000);
for i=1:1:2000
    y(10000+i)=0;
end
plot(x,y,'--','Color',fillcolor2);hold on;

% T=12
x=(1:1:12000)/100;
y=data(3,1:12000);
plot(x,y,'--','Color',fillcolor3);hold on;

% SCP
% T=8
% x=1:1:8000;
% x=(1:1:12000)/100;
% y=data(6,1:12000);
% for i=1:1:4000
%     y(8000+i)=0;
% end
% plot(x,y,'-.','Color',fillcolor1);hold on;
% 
% % T=10
% x=(1:1:12000)/100;
% y=data(5,1:12000);
% for i=1:1:2000
%     y(10000+i)=0;
% end
% plot(x,y,'-.','Color',fillcolor2);hold on;
% 
% % T=12
% x=(1:1:12000)/100;
% y=data(7,1:12000);
% plot(x,y,'-.','Color',fillcolor3);hold on;
% 
% % T=12
% % x=(1:1:12000)/100;
% % y=data(4,1:12000);
% % plot(x,y,'-','Color',fillcolor1);hold on;
% 
% % xlim([0 120]);ylim([0 4]);
% xlabel('s(m)')
% ylabel('Transmission power (W)')
% legend('{T=8 APF}','{T=10 APF}','{T=12 APF}','{T=8 SCP}','{T=10 SCP}','{T=12 SCP}','Location','northwest'); % '{P_{max}}'
