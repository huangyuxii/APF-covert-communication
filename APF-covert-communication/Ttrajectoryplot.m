data=xlsread('Ttra.xlsx'); %% matlab读取Excel中的数据，并赋值给 data 数组
fillcolor1=[0.85, 0.33, 0.10];fillcolor2=[0.93, 0.69, 0.13];fillcolor3=[0.00, 0.45, 0.74];
fillcolor4=[0.21,0.47,0.49];

plot(wx, wy,"k"+"^",'MarkerFaceColor','k','markersize',7);hold on;
plot(x2, y2,'or','markersize',12,'LineWidth',2);hold on;

% T chang
% 10 CC
x=data(3,1:10000);
y=data(4,1:10000); 
plot(x,y,'--','Color',fillcolor2,'LineWidth',2);hold on;
% 11 CC APF
x=data(7,1:11000);
y=data(8,1:11000); 
plot(x,y,'-.','Color',fillcolor2,'LineWidth',2);hold on;
% 12 CC
x=data(11,1:12000);
y=data(12,1:12000); 
plot(x,y,'-','Color',fillcolor2,'LineWidth',2);hold on;

% 10 SCP
x=data(21,1:11);
y=data(22,1:11); 
plot(x,y,'--s','Color',fillcolor3,'LineWidth',2);hold on;
% 11 CC SCP
x=data(23,1:12);
y=data(24,1:12); 
plot(x,y,'-.s','Color',fillcolor3,'LineWidth',2);hold on;
% 12 CC SCP
x=data(25,1:13);
y=data(26,1:13); 
plot(x,y,'-s','Color',fillcolor3,'LineWidth',2);hold on;


xlim([0 100]);ylim([0 80]);
xlabel('x[m]');
ylabel('y[m]');
% legend('{T=8 non-CC}','{T=8 CC}','{T=8 CC SCP}','{T=10 non-CC}', '{T=10 CC}','{T=10 CC SCP}','{T=12 non-CC}','{T=12 CC}','{T=12 CC SCP}','Location','northwest'); %,'{部分遮蔽情况下}'
legend('{Bob}','{Willie}','{APF, T=10}', '{APF, T=11}','{APF, T=12}','{TDSCP, T=10}','{TDSCP, T=11}','{TDSCP, T=12}','Location','northwest'); 
% title('不同rho与T下部分遮蔽场内的无人机轨迹图')