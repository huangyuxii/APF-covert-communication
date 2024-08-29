function plotsurf(x,y,z)

%数据预处理
[X,Y] = meshgrid(x,y); %将其x，y轴网格化
Z = z; %直接计算
%Z = Func_Sur(X,Y); %计算对应的Z坐标 建议函数形式调用

%相关参数
FontS = 16; %大小为12pt
FontW = 'bold';  %粗细为加粗 [不加粗用normal或缺省]
az = 50; el = 20; %旋转的角度设置
Length = 20; Width = 15; %设置图片长宽
Start_x = 6; Start_y = 6; %设置图片起始位置

%图像绘制
% figure(1) %定义所绘图像为Figure的第一个
Fig = mesh(X,Y,Z); %绘制三维曲面图
colormap winter; %设置colormap的格式
colorbar; %加上色条

%图像调整
view([az,el]); %设置观察角度
axis([min(x) max(x) min(y) max(y)... %设置坐标范围
        min(min(Z)) max(max(Z))]) %这里由于Z是二维需要用两层最值函数
set(gcf,'Units','centimeters','Position',[Start_x Start_y Length Width]); %设置图片大小

%坐标调整（设置为LaTeX文字格式）
L(1) = xlabel('$x$','interpreter','latex','FontSize',FontS,'FontWeight',FontW);
L(2) = ylabel('$y$','interpreter','latex','FontSize',FontS,'FontWeight',FontW);
L(3) = zlabel('$z$','interpreter','latex','FontSize',FontS,'FontWeight',FontW);
% L(4) = title(,'interpreter','latex','FontSize',FontS,'FontWeight',FontW);

%图像保存
% saveas(Fig,'Example2.png'); %保存为.png格式
end
%eps格式保存：需增加'psc2'不然图像为黑白
%saveas(Fig,'Example.eps','psc2');