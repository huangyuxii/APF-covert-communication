a=norm([200-150, 500-150])
b=norm([200-35.395, 500-216.555])
c=norm([35.395-150, 216.555-150])
d=a^2-b^2-c^2

%% 解圆切点的代码
% 圆心坐标和半径
cx = 150;
cy = 150;
radius = 132.529;

% 外点坐标
px = 200;
py = 500;

% 定义方程：圆的方程和切线斜率的关系
syms x y
circle_eq = (x - cx)^2 + (y - cy)^2 == radius^2;
slope_eq = ((y - py) / (x - px)) * ((cy - y) / (cx - x)) == -1;

% 求解方程
sol = solve([circle_eq, slope_eq], [x, y]);

% 获取解
x1 = double(sol.x(1));
y1 = double(sol.y(1));
x2 = double(sol.x(2));
y2 = double(sol.y(2));

% 显示结果
fprintf('切点1: (%.3f, %.3f)\n', x1, y1);
fprintf('切点2: (%.3f, %.3f)\n', x2, y2);

% 绘制圆和切线
theta = linspace(0, 2*pi, 100);
x_circle = cx + radius * cos(theta);
y_circle = cy + radius * sin(theta);

figure;
hold on;
plot(x_circle, y_circle, 'b'); % 画圆
plot(px, py, 'ro'); % 外点
plot([px, x1], [py, y1], 'g'); % 切线1
plot([px, x2], [py, y2], 'g'); % 切线2
plot(x1, y1, 'bo'); % 切点1
plot(x2, y2, 'bo'); % 切点2
axis equal;
grid on;
title('圆与切点');
xlabel('X');
ylabel('Y');
legend('圆', '外点', '切线', '切点');
hold off;
