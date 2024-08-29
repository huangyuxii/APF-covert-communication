function crosscicle=gethover_c(Rw,H)
% 给定距离 
global wx wy x0 y0 x1 y1 x2 y2 ;


syms x y hx hy cx cy; 
crosscicle=0;

% 在圆边上的悬停点求解
% [cx,cy]=solve(cy==(y2-wy)/(x2-wx).*(cx-wx)+wy,cy==-(Rw^2-(cx-x2)^2)^0.5+y2);
% plot(double(cx),double(cy),'rp');hold on;
% crosscicle(1)=double(cx);
% crosscicle(2)=double(cy);

% 在圆边内的悬停点求解 ( 结果仍然在圆边上
r3=norm ([x2-wx y2-wy]);
ri=1;
R_temp=0;
r_maxR=0;
for rm=r3:0.001:Rw
    R_temp(ri)=(rm^2+H^2)/((rm-r3)^2+H^2);
    rm=rm+0.01;
    ri=ri+1;
end
[R_temp_max,ri]=max(R_temp);
r_maxR=r3+(ri-1)*0.001;
% disp(R_temp)
disp(['r3：' num2str(r3) ' Rw：' num2str(Rw)]);
disp(['r_maxR：' num2str(r_maxR)]);
[hx,hy]=solve(hy==(y2-wy)/(x2-wx).*(hx-wx)+wy,hy==-(r_maxR^2-(hx-x2)^2)^0.5+y2); % 可能会有多个解/无解
crosscicle(1)=double(hx(1));
crosscicle(2)=double(hy(1));
disp(crosscicle);

end
                                                                                                                                                                                                                                                                                                                                                                                                     
