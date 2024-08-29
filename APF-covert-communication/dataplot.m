data=xlsread('data.xlsx'); %% matlab读取Excel中的数据，并赋值给 data 数组
% 遮蔽
% x=data(1,1:length(x_opt));
% y=data(2,1:length(y_opt)); 
% plot(x,y,'b');hold on;

% % 部分遮蔽
x=data(6,1:length(x_opt)); 
y=data(7,1:length(y_opt)); 
plot(x,y,'k');hold on;
% 
% 非遮蔽
% x=data(4,1:length(x_opt)); 
% y=data(5,1:length(y_opt)); 
% plot(x,y,'r');hold on;
% 
% 部分遮蔽边界
% x=data(8,:); 
% y=data(9,:); 
% plot(x,y,'p');hold on;
% 
plot([x0 x1 x2],[y0 y1 y2],'^');hold on;
xlim([0 100]);ylim([0 80]); 
% legend('{部分遮蔽情况下}','{非遮蔽情况下}' ,'Location','northwest'); %,'{部分遮蔽情况下}'

