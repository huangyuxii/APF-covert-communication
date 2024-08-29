% %% T mix= 10
% data=xlsread('rhoPs.xlsx'); %% matlab读取Excel中的数据，并赋值给 data 数组
% fillcolor1=[0.85, 0.33, 0.10];fillcolor2=[0.93, 0.69, 0.13];fillcolor3=[0.00, 0.45, 0.74];fillcolor4=[0.21,0.47,0.49];
% % rho=0.01
% x=(1:1:10000)/100;
% y=data(1,1:10000); 
% plot(x,y,'-','Color',fillcolor1);hold on;
% 0.05
% y=data(2,1:10000);
% plot(x,y,'-','Color',fillcolor3);hold on;
% % 0.1
% y=data(3,1:10000);
% plot(x,y,'-','Color',fillcolor2);hold on;
% 
% % non-CC
% x=(1:1:10000)/100;
% y=data(4,1:10000);
% plot(x,y,'--','Color',fillcolor1);hold on;
% 
% % SCP
% x=(0:10:100);
% y=data(6,1:11);
% plot(x,y,'s-','Color',fillcolor1);hold on;
% y=data(5,1:11);
% plot(x,y,'s-','Color',fillcolor3);hold on;
% y=data(7,1:11);
% plot(x,y,'s-','Color',fillcolor2);hold on;
% 
% % xlim([0 100]);ylim([0 3]);
% ylim([0 0.1045]);
% xlabel('s[m]')
% ylabel('Transmission power [W]')
% legend('{APF, \rho=0.03}','{APF, \rho=0.05}','{APF, \rho=0.08}','{P_{max}}','{TDSCP, \rho=0.03}','{TDSCP, \rho=0.05}','{TDSCP, \rho=0.08}','Location','northwest');  %,'{rho=0.05 SCP}''{P_{max}}'

%% T mix= 12
data=xlsread('rhoPs.xlsx'); %% matlab读取Excel中的数据，并赋值给 data 数组
fillcolor1=[0.85, 0.33, 0.10];fillcolor2=[0.93, 0.69, 0.13];fillcolor3=[0.00, 0.45, 0.74];
% APF
x=(1:1:12000)/100;
% rho=0.01
y=data(11,1:12000); 
plot(x,y,'-','Color',fillcolor1);hold on;
% 0.05
y=data(12,1:12000);
plot(x,y,'-','Color',fillcolor3);hold on;
% 0.1
y=data(13,1:12000);
plot(x,y,'-','Color',fillcolor2);hold on;


% non-CC
x=(1:1:12000)/100;
y=data(14,1:12000);
plot(x,y,'--','Color',fillcolor1);hold on;

% SCP
x=(0:10:120);
% 0.01
y=data(16,1:13);
plot(x,y,'-s','Color',fillcolor1);hold on;
% 0.05
y=data(15,1:13);
plot(x,y,'-s','Color',fillcolor3);hold on;
% 0.1
y=data(17,1:13);
plot(x,y,'-s','Color',fillcolor2);hold on;


% xlim([0 100]);ylim([0 3]);
ylim([0 0.1045]);
xlabel('s(m)')
ylabel('Transmission power (W)')
legend('{APF, \epsilon=0.03}','{APF, \epsilon=0.05}','{APF, \epsilon=0.08}','{P_{max}}','{TDSCP, \epsilon=0.03}','{TDSCP, \epsilon=0.05}','{TDSCP, \epsilon=0.08}','Location','northwest');  %,'{rho=0.05 SCP}''{P_{max}}'