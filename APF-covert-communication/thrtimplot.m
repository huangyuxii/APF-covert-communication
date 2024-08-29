
%% 100x100 performance comparison 
data=xlsread('thrtim.xlsx'); %% matlab读取Excel中的数据，并赋值给 data 数组
fillcolor1=[0.85, 0.33, 0.10];fillcolor2=[0.93, 0.69, 0.13];fillcolor3=[0.00, 0.45, 0.74];fillcolor4=[0.54,0.53,0.45];


x=data(1,1:10);

yyaxis right
% tim s
ys=data(2,1:10); 
plot(x,ys,'-.s','LineWidth',2);hold on;
% tim shf
ys=[1 1 1 1 1 1 1 1 1 1 ] * 21.3
plot(x,ys,'-.s','LineWidth',2);hold on;
% tim a
y=data(5,1:10); 
plot(x,y,'-x','LineWidth',2,'MarkerSize',8);hold on;

ylabel('Computing time [s]')
ylim([-0.1 500]);
% 
yyaxis left
% thr a
% y=data(6,1:10);
y=[1 1 1 1 1 1 1 1 1 1 ]*0.64369
plot(x,y,'-x','LineWidth',2,'MarkerSize',8);hold on;
% thr shf
ys=[0.6430 0.6432  0.6433 0.6434    0.6434 0.6434 0.6434 0.6434 0.6434 0.6434]
plot(x,ys,'-.s','LineWidth',2);hold on;
% thr s
ys=data(3,1:10); 
plot(x,ys,'-.s','LineWidth',2);hold on;
ylabel('Information throughput [bit/hz]')
ylim([0.64 0.645]);
% 

xlim([10 100]);
% ylim([10 80]); 
xlabel('Discrete slots N')
legend('APF, throughput','SHF, throughput','TDSCP, throughput','TDSCP, computing time','SHF, computing time','APF, computing time','Location','northwest'); 

%% 500x500 performance cpmparison
load("data\thr_scp_T80.mat");
load("data\tim_scp_T80.mat")

yyaxis right
% tim s
x=[10  20  30 40 50 60 70 80 90 100];
plot(x,tim_scp,'-.s','LineWidth',2);hold on;
% tim a
ys=[1 1 1 1 1 1 1 1 1 1 ] * 2.275121
plot(x,ys,'-x','LineWidth',2);hold on;

ylabel('Computing time [s]')
ylim([-0.1 500]);
% 
yyaxis left
% thr a
% y=data(6,1:10);
y=[1 1 1 1 1 1 1 1 1 1 ]*1.08009;
plot(x,y,'-x','LineWidth',2,'MarkerSize',8);hold on;
% thr s
plot(x,thr_scp,'-.s','LineWidth',2);hold on;
ylabel('Information throughput [bit/hz]')
% ylim([0.64 0.645]);
% 

xlim([10 100]);
% ylim([10 80]); 
xlabel('Discrete slots N')
legend('APF, throughput','TDSCP, throughput','TDSCP, computing time','APF, computing time','Location','northwest'); 
