% initial
A_range=[-pi 0.74]; 
A=mean(A_range); % all direction
A=-pi;
Q=1e-4; % small enough

opt_mark_x0=0;
opt_mark_x1=0;
findflag=0;

R=0;
ds=0.01;
% 把足够绳轨迹分为两段来查找
s_x0=0;

der_x=1;
der_y=2;


% 轨迹瞬时值
x_best=0;
y_best=0;
x_save=0;
y_save=0;

% R and P 瞬时值
RR_best=0;
PP_best=0;
% R and P 累计值
R_opt=0;
P_opt=0;

% 悬停点 第一三种情况
hover=[0 0 0];
hover=findhover(snr1,snr2,H);
disp(hover);
% pause;

% 圆边 第二种情况
crosscicle=0;

% color
fillcolor1=[0.85, 0.33, 0.10];
fillcolor2=[0.93, 0.69, 0.13];
fillcolor3=[0.00, 0.45, 0.74];
fillcolor4=[0.21,0.47,0.49];

% plot circle
hhx=linspace(-R_w+x2,R_w+x2,10000); 
hhy=-(R_w^2-(hhx-x2).^2).^0.5+y2;
hhy2=(R_w^2-(hhx-x2).^2).^0.5+y2;
% plot(hhx,hhy,'r--');hold on;
% plot(hhx,hhy2,'r--');hold on;

% find traj
if  hover(1)==0
    tic;
%     ds_list=[1e-2,1e-3,1e-4,1e-5,1e-6];
%     ds=ds_list(3);
%     thr=[4.0456, 4.0458, 4.0458];
%     time=[0.956333, 3.209533, 36.313034];

    disp('the part of UAV trajectory will be in circle !')
    % 找到直线与圆的交点并找到对应的距离作为边界值
    crosscicle=gethover_c(R_w,H);    

    % 圆心角有关
    d_alpha=0;
    theta=0;
    s=0;
    
    % 圆心角
    Q=0;
    % 求弧长ds此时对应的圆心角d_alpha
    d_alpha=ds/R_w;
    % 求极坐标下 悬停点此时对应的角theta
    theta=-acos((crosscicle(1)-x2)/R_w);

    % 判断所需的条件
    dis_x0=0;
    last_dis_x0=100000;
    min_dis=100000;
    dis_i=1;
    ci_range=[1 50/ds]; %[1, 5000]
    ci=floor(mean(ci_range));
%     ci=2;
    
    while opt_mark_x0==0
        A1_aux=Q*cos(A);
        A2_aux=Q*sin(A);
        x=crosscicle(1);
        y=crosscicle(2);
        
        x_opt=crosscicle(1);
        y_opt=crosscicle(2);
        ii=1;
        cii=1;
        flagc=1;
        
        s=0;
        R_opt=0; 
        while 1
            if flagc==1
                % 贴圆边
                % 初始位置 进行A方向延申
                r0=((x-wx)^2+(y-wy)^2)^0.5;
                rw0=((x-x2)^2+(y-y2)^2)^0.5;
                r=[x-wx,y-wy];
                rw=[x-x2,y-y2];
                A1_aux=A1_aux+ds/V*force(der_x,r,H,rw,snr1,snr2,changflag);
                A2_aux=A2_aux+ds/V*force(der_y,r,H,rw,snr1,snr2,changflag); 

                x=R_w*cos(theta+d_alpha*cii)+x2;
                y=R_w*sin(theta+d_alpha*cii)+y2;
                cii=cii+1;
%                 disp('bbbbbbbbbbbb');
                if cii==ci
                    flagc=0;
%                     plot(x_opt,y_opt,'b:','LineWidth',2);hold on; 
%                     xlim([-100 200]);ylim([-100 150]);
%                     pause;
                end
            else
                % 力场延申
%                 disp('aaaaaaa');
                dx=-A1_aux/(A1_aux^2+A2_aux^2)^0.5;
                dy=-A2_aux/(A1_aux^2+A2_aux^2)^0.5;
                r0=((x-wx)^2+(y-wy)^2)^0.5;
                rw0=((x-x2)^2+(y-y2)^2)^0.5;
                r=[x-wx,y-wy];
                rw=[x-x2,y-y2];
                A1_aux=A1_aux+ds/V*force(der_x,r,H,rw,snr1,snr2,changflag);
                A2_aux=A2_aux+ds/V*force(der_y,r,H,rw,snr1,snr2,changflag); 
                x=x+dx*ds;
                y=y+dy*ds;
            end

            s=s+ds;     
            x_opt(ii+1)=x;
            y_opt(ii+1)=y;
            % change Rs Ps
            ii=ii+1;            
            
            % different
            last_dis_x0=dis_x0;
            dis_x0=norm([x-x0 y-y0]); 

            % test
%             if s>200
%                 ci=ci+10;
%                 break;
%             else
%                 continue;
%             end

            if last_dis_x0<=dis_x0 & s>norm([crosscicle(1)-x0 crosscicle(2)-y0])
%                 plot(x_opt,y_opt,'b:','LineWidth',2);hold on; 
%                 xlim([-100 200]);ylim([-100 150]);
%                 pause;
                min_dis(dis_i+1)=last_dis_x0;
                dis_i=dis_i+1;
                if min_dis(dis_i)>ds
                    ang_xy=angle(x-crosscicle(1)+(y-crosscicle(2))*1j);
                    ang_x0=angle(x0-crosscicle(1)+(y0-crosscicle(2))*1j);
                    if ang_xy>ang_x0
                        ci_range(1)=ci;
                        ci=floor(mean(ci_range));
                    else
                        ci_range(2)=ci;
                        ci=floor(mean(ci_range));
                    end
%                 A=A+0.3;
                    break;
                else
                    % find
                    disp('success! x0_find!');
                    for i=1:length(x_opt)
                        x_best(i)=x_opt(length(x_opt)+1-i);
                        y_best(i)=y_opt(length(y_opt)+1-i);
                        % change Rs Ps
                        r=[x_best(i)-wx,y_best(i)-wy];
                        rw=[x_best(i)-x2,y_best(i)-y2];
                        r0=norm(r);
                        rw0=norm(rw);
                        R_opt=R_opt+potential(r0,H,rw0,snr1,snr2,changflag)*ds/V;
                        P_opt=power1(rw0,H,snr1,snr2,changflag);
                        RR_best(i)=R_opt;
                        PP_best(i)=P_opt;
                    end
                    opt_mark_x0=1;
                    s_x0=s;
                    break;
                end
            end
        
        end
%         disp('-------------------------------');
%         disp(['ci：' num2str(ci)]);
%         disp(['R：' num2str(R_opt)]);
%         disp(['A:' num2str(A)]);
%         disp(['s:' num2str(s)]); 
%         plot([x0 x1],[y0 y1],'^');hold on;
%         plot(x_opt,y_opt,'b:','LineWidth',2);hold on; 
%         xlim([-100 200]);ylim([-100 150]);
%         pause;
    end
%     disp('-------------------------------');
%     disp(['R：' num2str(R_opt)]);
%     disp(['A:' num2str(A)]);
%     disp(['s:' num2str(s)]); 
%     plot([x0 x1],[y0 y1],'^');hold on;
%     plot(x_opt,y_opt,'b:','LineWidth',2);hold on; 
%     xlim([-100 200]);ylim([-100 150]);
%     pause;

    % different
    findflag=0;

    % different
    dis_x1=0;
    last_dis_x1=100000;
    min_dis=100000;
    dis_i=1;
    ci_range=[1 50/ds];%[1 5000];
    ci=floor(mean(ci));
    
    s=0;

    % 遍历法 非二分
%     A=0.83;
%     Q=4*1e-3;
    Q=0;

   while opt_mark_x1==0
        A1_aux=Q*cos(A);
        A2_aux=Q*sin(A);
        x=crosscicle(1);
        y=crosscicle(2);
        
        x_opt=crosscicle(1);
        y_opt=crosscicle(2);
        ii=1;
        cii=1;
        flagc=1;
        
        s=0;
        while 1
            if flagc==1
                % 贴圆边
                % 初始位置 进行A方向延申
                r0=((x-wx)^2+(y-wy)^2)^0.5;
                rw0=((x-x2)^2+(y-y2)^2)^0.5;
                r=[x-wx,y-wy];
                rw=[x-x2,y-y2];
                A1_aux=A1_aux+ds/V*force(der_x,r,H,rw,snr1,snr2,changflag);
                A2_aux=A2_aux+ds/V*force(der_y,r,H,rw,snr1,snr2,changflag); 

                x=R_w*cos(theta-d_alpha*cii)+x2;
                y=R_w*sin(theta-d_alpha*cii)+y2;
                cii=cii+1;
                if cii==ci
                    flagc=0;
                end
            else
                % 力场延申
                dx=-A1_aux/(A1_aux^2+A2_aux^2)^0.5;
                dy=-A2_aux/(A1_aux^2+A2_aux^2)^0.5;
                r0=((x-wx)^2+(y-wy)^2)^0.5;
                rw0=((x-x2)^2+(y-y2)^2)^0.5;
                r=[x-wx,y-wy];
                rw=[x-x2,y-y2];
                A1_aux=A1_aux+ds/V*force(der_x,r,H,rw,snr1,snr2,changflag);
                A2_aux=A2_aux+ds/V*force(der_y,r,H,rw,snr1,snr2,changflag); 
                x=x+dx*ds;
                y=y+dy*ds;
            end

            s=s+ds;     
            x_opt(ii+1)=x;
            y_opt(ii+1)=y;
            % change Rs Ps
            ii=ii+1;            
            
            % different
            last_dis_x1=dis_x1;
            dis_x1=norm([x-x1 y-y1]); 

            if last_dis_x1<=dis_x1 & s>norm([crosscicle(1)-x1 crosscicle(2)-y1])
                min_dis(dis_i+1)=last_dis_x1;
                dis_i=dis_i+1;
                if min_dis(dis_i)>ds
                    ang_xy=angle(x-crosscicle(1)+(y-crosscicle(2))*1j);
                    ang_x1=angle(x1-crosscicle(1)+(y1-crosscicle(2))*1j);
                    if ang_xy>ang_x1
                        ci_range(2)=ci;
                        ci=floor(mean(ci_range));
                    else
                        ci_range(1)=ci;
                        ci=floor(mean(ci_range));
                    end
                  break;
                else
                     % find
                    disp('success! x1_find!');
                    L_0=length(x_best);
                    s=s+s_x0;
                    for i=1:1:(V*T-s)/ds
                        x_best(L_0+i)=crosscicle(1);
                        y_best(L_0+i)=crosscicle(2);
                    end
                    L_1=length(x_best);
                    for i=1:1:length(x_opt)
                        x_best(L_1+i)=x_opt(i);
                        y_best(L_1+i)=y_opt(i);
                    end
                    for i=L_0+1:1:V*T/ds
                        % change Rs Ps
                        r=[x_best(i)-wx,y_best(i)-wy];
                        rw=[x_best(i)-x2,y_best(i)-y2];
                        r0=norm(r);
                        rw0=norm(rw);
                        R_opt=R_opt+potential(r0,H,rw0,snr1,snr2,changflag)*ds/V;
                        P_opt=power1(rw0,H,snr1,snr2,changflag);
                        RR_best(i)=R_opt;
                        PP_best(i)=P_opt;
                    end
                    opt_mark_x1=1;
                    break;
                end
            end
        
        end
%         disp('-------------------------------');
%         disp(['ci：' num2str(ci)]);
%         disp(['R：' num2str(R_opt)]);
%         disp(['A:' num2str(A)]);
%         disp(['s:' num2str(s)]); 
%         plot([x0 x1],[y0 y1],'^');hold on;
%         plot(x_opt,y_opt,'b:','LineWidth',2);hold on; 
%         xlim([-100 200]);ylim([-100 150]);
%         pause;
    end

%     plot(wx, wy,"k"+"^",'MarkerFaceColor','k','markersize',7);hold on;
%     plot(x2, y2,'or','markersize',12,'LineWidth',2);
%     disp('-----------------------------------');
%     disp(['s_part:' num2str(s)]);
%     disp(['Q:' num2str(Q)]);
%     disp(['R:' num2str(R_opt)]);
%     disp(['A:' num2str(A)]);
    plot([crosscicle(1)],[crosscicle(2)],'cd','markersize',10,'LineWidth',2);hold on;
% 
%     plot(hhx,hhy,'r--','LineWidth',2);hold on;
%     plot(hhx,hhy2,'r--','LineWidth',2);hold on;
% 
    plot(x_best,y_best,'LineWidth',2,'Color',fillcolor1);hold on; 
%     xlim([-100 200]);ylim([-100 200]);
    toc;
    disp(['Optimal result -- ' num2str(R_opt)]);



else
    disp('UAV trajectory exist hover ponit!')
    hover_point=[0 0];
    hover_point(1)=hover(2);
    hover_point(2)=hover(3);

    % 判断所需的条件
    dis_x0=0;
    last_dis_x0=100000;
    min_dis=100000;
    dis_i=1;
%     Q=1e-4;
    Q=0;
    A_range=[0.15, 1.95]; %[0.45, 1.65]
    A=mean(A_range);


    while opt_mark_x0==0
        A1_aux=Q*cos(A);
        A2_aux=Q*sin(A);
        x=hover_point(1);
        y=hover_point(2);
        
        x_opt=hover_point(1);
        y_opt=hover_point(2);
        ii=1;
        s=0;
        while 1
           if s==0 || ( s==0.01)
                r0=((x-wx)^2+(y-wy)^2)^0.5;
                rw0=((x-x2)^2+(y-y2)^2)^0.5;
                r=[x-wx,y-wy];
                rw=[x-x2,y-y2];
                A1_aux=A1_aux+ds/V*force(der_x,r,H,rw,snr1,snr2,changflag);
                A2_aux=A2_aux+ds/V*force(der_y,r,H,rw,snr1,snr2,changflag); 

                x=x+ds*cos(A);
                y=y+ds*sin(A);
            else
                dx=-A1_aux/(A1_aux^2+A2_aux^2)^0.5;
                dy=-A2_aux/(A1_aux^2+A2_aux^2)^0.5;
%                 if norm([x-dx])

                r0=((x-wx)^2+(y-wy)^2)^0.5;
                rw0=((x-x2)^2+(y-y2)^2)^0.5;
                r=[x-wx,y-wy];
                rw=[x-x2,y-y2];
                A1_aux=A1_aux+ds/V*force(der_x,r,H,rw,snr1,snr2,changflag);
                A2_aux=A2_aux+ds/V*force(der_y,r,H,rw,snr1,snr2,changflag); 
                x=x+dx*ds;
                y=y+dy*ds;
            end
            s=s+ds;     
            x_opt(ii+1)=x;
            y_opt(ii+1)=y;
            % change Rs Ps
            ii=ii+1; 

            % different
            last_dis_x0=dis_x0;
            dis_x0=norm([x-x0 y-y0]);


        
            % test
%             if s>150
%                 last_A=A;
%                 A=A+0.3;
%                 break;
%             else
%                 continue;
%             end
    
            if last_dis_x0<=dis_x0 & s>norm([hover_point(1)-x0 hover_point(2)-y0])
                min_dis(dis_i+1)=last_dis_x0;
                dis_i=dis_i+1;
                if min_dis(dis_i)>5*ds
                    ang_xy=angle(x-hover_point(1)+(y-hover_point(2))*1j);
                    ang_x0=angle(x0-hover_point(1)+(y0-hover_point(2))*1j);
                    if ang_xy>ang_x0
                        A_range(2)=A;
                        A=mean(A_range);
                    else
                        A_range(1)=A;
                        A=mean(A_range);
                    end
                  break;
                else
                    % find
                    disp('success! x0_find!');
                    for i=1:length(x_opt)
                        x_best(i)=x_opt(length(x_opt)+1-i);
                        y_best(i)=y_opt(length(y_opt)+1-i);
                        % change Rs Ps
                        r=[x_best(i)-wx,y_best(i)-wy];
                        rw=[x_best(i)-x2,y_best(i)-y2];
                        r0=norm(r);
                        rw0=norm(rw);
                        R_opt=R_opt+potential(r0,H,rw0,snr1,snr2,changflag)*ds/V;
                        P_opt=power1(rw0,H,snr1,snr2,changflag);
                        RR_best(i)=R_opt;
                        PP_best(i)=P_opt;
                    end
                    opt_mark_x0=1;
                    s_x0=s;
                    break;
                end
            end

            
            
        end
%         disp(['min_dis:' num2str(min_dis(dis_i))]);
%         plot(wx, wy,"k"+"^",'MarkerFaceColor','k','markersize',7);hold on;
%         plot(x2, y2,'or','markersize',12,'LineWidth',2);
%         disp('-----------------------------------');
%         disp(['A:' num2str(A)]);
%         plot([x0 x1 hover_point(1)],[y0 y1 hover_point(2)],'^');hold on;
%         plot(x_opt,y_opt);hold on; 
%         xlim([-100 200]);ylim([-100 150]);
%         pause;
    end
    
    Q=0;
    A_range=[0.15, 1.95]; %[0.45, 1.65]
    A=mean(A_range);
    
    % different
    dis_x1=0;
    last_dis_x1=100000;
    min_dis=100000;
    dis_i=1;
    
    while opt_mark_x1==0
        A1_aux=Q*cos(A);
        A2_aux=Q*sin(A);
        x=hover_point(1);
        y=hover_point(2);
        
        x_opt=hover_point(1);
        y_opt=hover_point(2);
        ii=1;
        s=0;
        while 1
            if s==0 || ( s==0.01)
                r0=((x-wx)^2+(y-wy)^2)^0.5;
                rw0=((x-x2)^2+(y-y2)^2)^0.5;
                r=[x-wx,y-wy];
                rw=[x-x2,y-y2];
                A1_aux=A1_aux+ds/V*force(der_x,r,H,rw,snr1,snr2,changflag);
                A2_aux=A2_aux+ds/V*force(der_y,r,H,rw,snr1,snr2,changflag); 

                x=x+ds*cos(A);
                y=y+ds*sin(A);
            else
                dx=-A1_aux/(A1_aux^2+A2_aux^2)^0.5;
                dy=-A2_aux/(A1_aux^2+A2_aux^2)^0.5;
%                 if norm([x-dx])

                r0=((x-wx)^2+(y-wy)^2)^0.5;
                rw0=((x-x2)^2+(y-y2)^2)^0.5;
                r=[x-wx,y-wy];
                rw=[x-x2,y-y2];
                A1_aux=A1_aux+ds/V*force(der_x,r,H,rw,snr1,snr2,changflag);
                A2_aux=A2_aux+ds/V*force(der_y,r,H,rw,snr1,snr2,changflag); 
                x=x+dx*ds;
                y=y+dy*ds;
            end
    
            % different
            last_dis_x1=dis_x1;
            dis_x1=norm([x-x1 y-y1]);
            
            s=s+ds;
                   
            x_opt(ii+1)=x;
            y_opt(ii+1)=y;
            ii=ii+1;
    
            if last_dis_x1<=dis_x1 & s>norm([hover_point(1)-x1 hover_point(2)-y1])
                min_dis(dis_i+1)=last_dis_x1;
                dis_i=dis_i+1;
%                 disp(['min_dis:' num2str(min_dis(dis_i))]);
%                 disp(['A:' num2str(A)]);
                % plot
    %             plot([x0 x1 hover_point(1)],[y0 y1 hover_point(2)],'^');hold on;
    %             plot(x_opt,y_opt);hold on; 
    %             xlim([-100 200]);ylim([-100 150]);
    %             pause;
                if min_dis(dis_i)>5*ds
                    ang_xy=angle(x-hover_point(1)+(y-hover_point(2))*1j);
                    ang_x1=angle(x1-hover_point(1)+(y1-hover_point(2))*1j);
                    if ang_xy>ang_x1
                        A_range(2)=A;
                        A=mean(A_range);
                    else
                        A_range(1)=A;
                        A=mean(A_range);
                    end
                    break;
                else
                    % find
                    disp('success! x1_find!');
                    L_0=length(x_best);
                    s=s+s_x0;
                    for i=1:1:(V*T-s)/ds
                        x_best(L_0+i)=hover_point(1);
                        y_best(L_0+i)=hover_point(2);
                    end
                    L_1=length(x_best);
                    for i=1:1:length(x_opt)
                        x_best(L_1+i)=x_opt(i);
                        y_best(L_1+i)=y_opt(i);
                    end
                    for i=L_0+1:1:V*T/ds
                        % change Rs Ps
                        r=[x_best(i)-wx,y_best(i)-wy];
                        rw=[x_best(i)-x2,y_best(i)-y2];
                        r0=norm(r);
                        rw0=norm(rw);
                        R_opt=R_opt+potential(r0,H,rw0,snr1,snr2,changflag)*ds/V;
                        P_opt=power1(rw0,H,snr1,snr2,changflag);
                        RR_best(i)=R_opt;
                        PP_best(i)=P_opt;
                    end
                    opt_mark_x1=1;
                    break;
                end
            end
        end
    end
    
%     plot(wx, wy,"k"+"^",'MarkerFaceColor','k','markersize',7);hold on;
%     plot(x2, y2,'or','markersize',12,'LineWidth',2);
%     disp('-----------------------------------');
%     disp(['s_part:' num2str(s)]);
%     disp(['Q:' num2str(Q)]);
%     disp(['A:' num2str(A)]);
    plot([hover_point(1)],[hover_point(2)],'cd','markersize',12,'LineWidth',2);hold on;
% 
%     plot(hhx,hhy,'r--','LineWidth',2);hold on;
%     plot(hhx,hhy2,'r--','LineWidth',2);hold on;
% 
    plot(x_best,y_best,'LineWidth',2);hold on; 
%     legend('{Willie}','APF trajectory');
%     xlim([-100 200]);ylim([-100 150]);
end



            