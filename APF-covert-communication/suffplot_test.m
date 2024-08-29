%%
% fillcolor1=[0.85, 0.33, 0.10];
% fillcolor2=[0.93, 0.69, 0.13];
% plot(wx, wy,"k"+"^",'MarkerFaceColor','k','markersize',7);hold on;
% plot(x2, y2,'or','markersize',12,'LineWidth',2);
% plot(hover_point(1), hover_point(2),'cd','markersize',10,'LineWidth',2);
% 
% hhx=linspace(-R_w+x2,R_w+x2,10000); 
% hhy=-(R_w^2-(hhx-x2).^2).^0.5+y2;
% hhy2=(R_w^2-(hhx-x2).^2).^0.5+y2;
% plot(hhx,hhy,'r--','LineWidth',2);hold on;
% plot(hhx,hhy2,'r--','LineWidth',2);hold on;
% 
% plot(x_best,y_best,'LineWidth',2,'Color',fillcolor1);hold on;
%%
% fillcolor1=[0.85, 0.33, 0.10];
% fillcolor2=[0.93, 0.69, 0.13];
% plot(wx, wy,"k"+"^",'MarkerFaceColor','k','markersize',7);hold on;
% plot(x2, y2,'or','markersize',12,'LineWidth',2);
% plot(crosscicle(1), crosscicle(2),'cd','markersize',10,'LineWidth',2);
% 
% hhx=linspace(-R_w+x2,R_w+x2,10000); 
% hhy=-(R_w^2-(hhx-x2).^2).^0.5+y2;
% hhy2=(R_w^2-(hhx-x2).^2).^0.5+y2;
% plot(hhx,hhy,'r--','LineWidth',2);hold on;
% plot(hhx,hhy2,'r--','LineWidth',2);hold on;
% 
% plot(x_best,y_best,'LineWidth',2,'Color',fillcolor1);hold on;
%%
% x=(1:1:length(PP_best))/1000;
% plot(x,PP_best,':','LineWidth',1.5);hold on;
% xlabel('t[s]')
% ylabel('Transmission power [W]')

%%
% P_MAX=linspace(0.1,0.1,length(PP_best));
% plot(x,P_MAX,'--','LineWidth',1.5);hold on;

%% rho=0.05 suff_thrtim
% data=xlsread('suffthrtim.xlsx'); %% matlab读取Excel中的数据，并赋值给 data 数组
% data=xlsread('thrtim-refine.xlsx');
% fillcolor1=[0.85, 0.33, 0.10];fillcolor2=[0.93, 0.69, 0.13];fillcolor3=[0.00, 0.45, 0.74];fillcolor4=[0.54,0.53,0.45];
% 
x=[10	20	30	40	50	60	70	80	90	100];
yyaxis right
% tim s
ys=[0.27701	2.3765	11.6355	31.2743	82.5811	166.8794	296.2393	492.5373	748.5044	1131.5486]; 
plot(x,ys,'-.s','LineWidth',2);hold on;
% tim a 
% y=[0.570049	0.570049	0.570049	0.570049	0.570049	0.570049	0.570049	0.570049	0.570049	0.570049]; 
% plot(x,y,'-x','LineWidth',2,'MarkerSize',8);hold on;
% time shf 
ys=[1 1 1 1 1 1 1 1 1 1 ] * 55.074;
plot(x,ys,'-.s','LineWidth',2);hold on;
% tim a refine
ya=[0.956333	0.956333	0.956333	0.956333	0.956333	0.956333	0.956333	0.956333	0.956333	0.956333]; 
plot(x,ya,'-x','LineWidth',2,'MarkerSize',8);hold on;
ylabel('Computing time [s]')
ylim([-0.1 1200]);
% 

yyaxis left

% thr a refine
yq=[4.0474	4.0474	4.0474	4.0474	4.0474	4.0474	4.0474	4.0474	4.0474	4.0474]; 
plot(x,yq,'-x','LineWidth',2,'MarkerSize',8);hold on;
% thr a
% y=[4.0468	4.0468	4.0468	4.0468	4.0468	4.0468	4.0468	4.0468	4.0468	4.0468]; 
% plot(x,y,'-x','LineWidth',2,'MarkerSize',8);hold on;
% thr shf
yq=[4.04	4.0438	4.0457	4.0464	4.0469	4.0469	4.0469	4.0469	4.0469	4.0469]; 
plot(x,yq,'-x','LineWidth',2,'MarkerSize',8);hold on;
% thr s
ys=[4.0286	4.0427	4.0457	4.0462	4.0465	4.0466	4.0466	4.0467	4.0468	4.0468];  
plot(x,ys,'-.s','LineWidth',2);hold on;
ylabel('Information throughput [bit/hz]')
ylim([4.03 4.06]);
% 

xlim([10 100]);
% ylim([10 80]); 
xlabel('Discrete slots N')
legend('APF, throughput','SHF, throughput','TDSCP, throughput','TDSCP, computing time','SHF, computing time','APF, computing time','Location','northwest'); 
% legend('APF, throughput','TDSCP, throughput','TDSCP, computing time','APF, computing time','Location','northwest'); 
% legend('APF-refine, throughput','APF, throughput','TDSCP, throughput','TDSCP, computing time','APF, computing time','APF-refine, computing time','Location','northwest'); 
%% rho=0.03 suff_thrtim
% x=data(1,1:10);
% yyaxis right
% % tim s
% ys=data(3,1:10); 
% plot(x,ys,'-.s','LineWidth',2);hold on;
% % tim shf
% ys=[1 1 1 1 1 1 1 1 1 1 ] * 44.074;
% plot(x,ys,'-.s','LineWidth',2);hold on;
% % tim a
% y=data(6,1:10); 
% plot(x,y,'-x','LineWidth',2,'MarkerSize',8);hold on;
% ylabel('Computing time [s]')
% % ylim([-0.1 900]);
% % 
% 
% yyaxis left
% % thr a
% y=data(5,1:10); 
% plot(x,y,'-x','LineWidth',2,'MarkerSize',8);hold on;
% % thr shf
% y=[ 2.6 2.6010 2.6016 2.6017 2.6017 2.6017 2.6017 2.6017 2.6017 2.6017];
% plot(x,y,'-x','LineWidth',2,'MarkerSize',8);hold on;
% % thr s
% ys=data(2,1:10); 
% plot(x,ys,'-.s','LineWidth',2);hold on;
% ylabel('Information throughput [bit/hz]')
% ylim([2.59 2.61]);
% 
% 
% xlim([10 100]);
% % ylim([10 80]); 
% xlabel('Discrete slots N')
% legend('APF, throughput','SHF, throughput','TDSCP, throughput','TDSCP, computing time','SHF, computing time','APF, computing time','Location','northwest'); 