
%% T(s)
data=xlsread('Tperform.xlsx'); %% matlab读取Excel中的数据，并赋值给 data 数组
fillcolor1=[0.85, 0.33, 0.10];fillcolor2=[0.93, 0.69, 0.13];fillcolor3=[0.00, 0.45, 0.74];
% T chang
x=(1:1:12000)/1000;
% 10 CC APF
y=data(3,1:10000);
for i=1:1:2000
    y(10000+i)=y(10000);
end
plot(x,y,'--','Color',fillcolor2);hold on;
% 11 CC APF
y=data(7,1:11000);
for i=1:1:1000
    y(11000+i)=y(11000);
end
plot(x,y,'-.','Color',fillcolor2);hold on;
% 12 CC APF
y=data(11,1:12000); 
plot(x,y,'-','Color',fillcolor2);hold on;

% 10 SCP
x=(0:100:1200)/100;
y=data(15,1:13); 
plot(x,y,'--s','Color',fillcolor3);hold on;
% 11 CC SCP
y=data(16,1:13);
plot(x,y,'-.s','Color',fillcolor3);hold on;
% 12 CC SCP
x=(0:100:1200)/100;
y=data(17,1:13); 
plot(x,y,'-s','Color',fillcolor3);hold on;

% plot([x0 x1],[y0 y1],'o');hold on;
xlabel('T[s]');
ylabel('Information throughput [bit/hz]');
legend('{APF, T=10}', '{APF, T=11}','{APF, T=12}','{TDSCP, T=10}','{TDSCP, T=11}','{TDSCP, T=12}','Location','northwest'); %,'{部分遮蔽情况下}'