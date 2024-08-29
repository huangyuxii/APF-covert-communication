tic;
%% optimal trajectory generation
ds=0.01; % resolution for 1.curve generation 2.same point judge
tra_ds=1; %3.rope length judge
A_range=[angle(x0-x1+1j*(y0-y1)) angle(x0-wx+1j*(y0-wy))];%atan([(y1-y0)/(x1-x0) (wy-y0)/(wx-x0)]);
% A_range=[-1 0.7];
Q_range=[0 1000];

% 求偏导 der_x,der_y 分别为x,y的偏导
der_x=1;der_y=2;


A_range=[0.38034      0.3805];
Q_range=[0   0.0029448];
% A_range=[0.20245     0.38051];

A=mean(A_range);
Q=mean(Q_range);

% figure;
opt_mark=0; % marker: 1 -- optimal found; 0 -- optimal not found
% flag
boundaryflag=0; % 第几次到达隐蔽位置
covflag=0; % 0在场外 1在场内
lastcovflag=0;

circleflag=0; %判断有无回环

saveflag=1; % 用于保存漂离点的


isopleth; %绘等值线图
% plot([x0 x1],[y0 y1],'^');hold on;
% user position
% plot(wx,wy,"k"+"^",'MarkerFaceColor','k','markersize',7);
% warden position
% plot(x2,y2,'or','markersize',12);

while opt_mark==0
    %disp(A_range)
    %disp(Q_range)
    %disp([A Q]);
   disp(['Q_range -- ' num2str(Q_range)]);
   disp(['A_range -- ' num2str(A_range)]);

    A1_aux=Q*cos(A);
    A2_aux=Q*sin(A);
    x=x0;
    y=y0;
    
    x_opt=x0;
    y_opt=y0;
    ii=1;
    s=0;

    dis_x1=0;
    last_dis_x1=100000;
    min_dis1=100000;
    dis_i1=1;

    dis_x0=0;
    last_dis_x0=100000;
    min_dis0=100000;
    dis_i0=1;
    
    while 1
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
        s=s+ds;
        
        x_opt(ii+1)=x;
        y_opt(ii+1)=y;
        ii=ii+1;
        
        % 判断第几次进入隐蔽场内部
        lastcovflag=covflag;
        if rw0>R_w
            covflag=0;
        else
            covflag=1;
        end
        if lastcovflag~=covflag
            boundaryflag=boundaryflag+1;
%             disp(['covflag:' num2str(covflag)  '    lastcovflag:' num2str(lastcovflag)]);
            disp(['boundaryflag:' num2str(boundaryflag)]);
        end

        % 回环判断到延申到终点的结果是
        if circleflag==1 && boundaryflag>=2 && saveflag
                boundarypoint=[x,y];
                boundary_s=s;
                saveflag=0;
        end
        if circleflag==1 && rw0>R_w
        % 回环且出边界
            last_dis_x1=dis_x1;
            dis_x1=norm([x-x1 y-y1]); 
            last_dis_x0=dis_x0;
            dis_x0=norm([x-x0 y-y0]); 
            % 回环往终点延伸
            if last_dis_x1<=dis_x1 && s-boundary_s>norm([boundarypoint(1)-x1 boundarypoint(2)-y1])
                min_dis1(dis_i1+1)=last_dis_x1;
                dis_i1=dis_i1+1;
                if min_dis1(dis_i1)>tra_ds
                    ang_xy=angle(x-boundarypoint(1)+(y-boundarypoint(2))*1j);
                    ang_x1=angle(x1-boundarypoint(1)+(y1-boundarypoint(2))*1j);
                    
                    if ang_xy>ang_x1
                        Q_range(2)=Q;
                        Q=mean(Q_range);
                    else
                        Q_range(1)=Q;
                        Q=mean(Q_range);
                    end

                                       
                    % 补充冗余量
                    if abs(Q_range(1)-Q_range(2))<1e-6
                        if s>V*T
                            A_range(2)=A;
                            A=mean(A_range);
                            Q_range=[0 Q*2];
                        else
                            A_range(1)=A;
                            A=mean(A_range);
                            Q_range=[0 Q*2];
                        end
                    end 
                  break;
                else
                    disp('.........CLOSING TO (X1,Y1).................');
                    if abs(s-V*T)>tra_ds
                        % 故意反
                        % 绳长不满足条件 s=VT ，随着a↑ s↑
                        % 最佳角度范围的选择
                        if s>V*T
                            %需减小A 所以A在下1/2处
        %                     disp('...........................................');
        %                     disp('decreasing A');
                            A_range(1)=A;
                            if abs(A_range(1)-A_range(2))<1e-6
                                A_range=[A A+0.1];
                            end
                            A=mean(A_range);
                            Q_range=[0 Q*2];
                            break;
                        else
                            %需增大A 所以A在上1/2处
        %                     disp('...........................................');
        %                     disp('increasing A');
                            A_range(2)=A;
                            if abs(A_range(1)-A_range(2))<1e-6
        %                         if A+0.01>angle(x0-wx+1j*(y0-wy))
        %                             A_range=[A angle(x0-wx+1j*(y0-wy))];
        %                         else
                                    A_range=[A-0.1 A]; %扩大A的范围
        %                         end
                            end
                            A=mean(A_range);
                            Q_range=[0 Q*2];
                            break;
                        end
                    else
                        % 绳长视为满足条件 s=VT
                        % 结束循环
        %                 disp('make a success');
                        opt_mark=1;
                        break;
                    end
                end            
            % 回环往起点延伸
            elseif last_dis_x0<=dis_x0 && s-boundary_s>norm([boundarypoint(1)-x0 boundarypoint(2)-y0])
                disp('-------------------colse to(x0,y0)------------------');

                % 补充冗余量 (需要)
                if abs(Q_range(1)-Q_range(2))<1e-6
                        A_range=[A A+0.1];
                        A=mean(A_range);
                        Q_range=[0 2*Q];
                else
                    Q_range(1)=Q;             
                end 
                Q=mean(Q_range);
                break;
            end

        else
        % 回环不出边界 和其他情况
            if sqrt((x-x1)^2+(y-y1)^2)>tra_ds
                % 绳子轨迹(x,y)还未接近目的点(x1,y1)
                % 最佳拉力范围的选择  Q↑ r(s)↓
                ang0 = angle(x0-wx+1j*(y0-wy));
                ang1 = pi-angle(x1-x0+1j*(y1-y0));
                ang_bac = ang0+ang1;
                ang_alpha = angle(x1-x0+1j*(y1-y0))-angle(x-wx+1j*(y-wy));
                r0 = norm([x0-wx, y0-wy]);
                r_temp = r0*sin(ang_bac)/sin(ang_alpha);
                if norm([x-wx,y-wx])>r_temp 
                    % 需增大Q 所以Q在
                    % 上1/2处
%                     disp('...........................................');
%                     disp('increasing Q');
                        Q_range(1)=Q;
                        if abs(Q_range(1)-Q_range(2))<1e-6
                            Q_range=[Q Q*2];
                        end               
                        Q=mean(Q_range);
                        break;
                elseif angle(x-wx+1j*(y-wy))>angle(x1-wx+1j*(y1-wy)) && boundaryflag~=1
                    % 需减小Q 所以Q在下1/2处
    %                 disp('...........................................');
    %                     disp('decreasing Q');
                        Q_range(2)=Q;
                        if abs(Q_range(1)-Q_range(2))<1e-6
                            Q_range=[Q/2 Q];
                        end
                        Q=mean(Q_range);
                        break;
                elseif angle(x-wx+1j*(y-wy))>angle(x1-wx+1j*(y1-wy)) && boundaryflag==1
                    % 说明回环了，可以继续延申
                    circleflag=1;
                end
            % 正常状态，继续延申
            else
                % 绳子轨迹(x,y)接近目的点(x1,y1)
                if abs(s-V*T)>tra_ds
                    % 绳长不满足条件 s=VT ，随着a↑ s↑
                    % 最佳角度范围的选择
                    if s>V*T
                        %需减小A 所以A在下1/2处
    %                     disp('...........................................');
    %                     disp('decreasing A');
                        A_range(2)=A;
                        if abs(A_range(1)-A_range(2))<1e-6
                            A_range=[A-0.001 A];
                        end
                        A=mean(A_range);
                        Q_range=[0 Q*2];
                        break;
                    else
                        %需增大A 所以A在上1/2处
    %                     disp('...........................................');
    %                     disp('increasing A');
                        A_range(1)=A;
                        if abs(A_range(1)-A_range(2))<1e-6
                                A_range=[A A+0.01];
                        end
                        A=mean(A_range);
                        Q_range=[0 Q*2];
                        break;
                    end
                else
                    % 绳长视为满足条件 s=VT
                    % 结束循环
    %                 disp('make a success');
                    opt_mark=1;
                    break;
                end
            end
        
          
        end  %回环判定
    end
%    disp(['circleflag -- ' num2str(circleflag)]);
%    plot(x_opt,y_opt);hold on;
%    xlim([0 500]);ylim([0 500]);
% 
   boundaryflag=0;
   circleflag=0;
   saveflag=1;
% 
   disp(['S -- ' num2str(s)]);
   disp('......................................................................................');
   
   pause;
end
disp('success !');
disp('......................................................................................');
% 得到最佳 Q A 
%% 根据最佳拉力得到最优解
%% s=800.46
% A_range=[0.37902,0.38902];
% Q_range=[0, 0.0027959];  

% s=805.18
% A_range=[0.38034      0.3805];
% Q_range=[0   0.0029448]; 

Q=mean(Q_range);
A=mean(A_range);


x_opt=x0;
y_opt=y0;
R_opt=0;
P_opt=0;
Q_opt=Q;
A_opt=A;
RR_opt=0;
PP_opt=0;

x=x0;
y=y0;
A1_aux=Q*cos(A);
A2_aux=Q*sin(A);
s=0;

ii=1;
boi=1;
% 记录切换场的点
x_boundary=x0;
y_boundary=y0;

while 1
    dx=-A1_aux/(A1_aux^2+A2_aux^2)^0.5;
    dy=-A2_aux/(A1_aux^2+A2_aux^2)^0.5;
    % 带0是值 不带0是向量
    r0=((x-wx)^2+(y-wy)^2)^0.5;
    rw0=((x-x2)^2+(y-y2)^2)^0.5;
    r=[x-wx,y-wy];
    rw=[x-x2,y-y2];
    R_opt=R_opt+potential(r0,H,rw0,snr1,snr2,changflag)*ds/V;
    P_opt=power1(rw0,H,snr1,snr2,changflag);
%     if lastcovflag==2 && covflag==1
% %         disp('goto covert');
%         boudflag=1;
%     elseif lastcovflag==1 && covflag==2
% %         disp('goto non-covert');
%         boudflag=1;
%     else
%         boudflag=0;
%     end
    A1_aux=A1_aux+ds/V*force(der_x,r,H,rw,snr1,snr2,changflag);
    A2_aux=A2_aux+ds/V*force(der_y,r,H,rw,snr1,snr2,changflag);
    x=x+dx*ds;
    y=y+dy*ds;
    s=s+ds;
    x_opt(ii+1)=x;
    y_opt(ii+1)=y;
    % change Rs Ps
    RR_opt(ii+1)=R_opt;
    PP_opt(ii)=P_opt;
    ii=ii+1;

    % 找边界点
%     if boudflag==1 
%         x_boundary(boi)=x;
%         y_boundary(boi)=y;
%         boi=boi+1;
%     end
    if sqrt((x-x1)^2+(y-y1)^2)<=tra_ds
        break;
    end
end

%%
figure;
isopleth;
plot(x_opt,y_opt,'g');hold on;

R_opt=R_opt;
t=t+toc;

% xlswrite('testPs.xlsx',PP_opt,1,'A1')

% 三种场最优轨迹存表 对应dataplot
% if changflag==0
%     xlswrite('data.xlsx',x_opt,1,'A1')
%     xlswrite('data.xlsx',y_opt,1,'A2')
% elseif changflag==1
%     xlswrite('data.xlsx',x_opt,1,'A4')
%     xlswrite('data.xlsx',y_opt,1,'A5')
% elseif changflag==2
%     xlswrite('data.xlsx',x_opt,1,'A6')
%     xlswrite('data.xlsx',y_opt,1,'A7')
%     xlswrite('data.xlsx',x_boundary,1,'A8')
%     xlswrite('data.xlsx',y_boundary,1,'A9')
% end

% willie to bob 距离不同时的轨迹 对应wtobplot
% if changflag==1
%     xlswrite('wtob.xlsx',x_opt,1,'A7')
%     xlswrite('wtob.xlsx',y_opt,1,'A8')  
% elseif x2==40
%     xlswrite('wtob.xlsx',x_opt,1,'A1')
%     xlswrite('wtob.xlsx',y_opt,1,'A2')
% elseif x2==30
%     xlswrite('wtob.xlsx',x_opt,1,'A3')
%     xlswrite('wtob.xlsx',y_opt,1,'A4')
% elseif x2==20 
%     xlswrite('wtob.xlsx',x_opt,1,'A5')
%     xlswrite('wtob.xlsx',y_opt,1,'A6')
% end

% 不同rho的轨迹比较 对应rhoplot
% if changflag==1
%     xlswrite('rho.xlsx',x_opt,1,'A7')
%     xlswrite('rho.xlsx',y_opt,1,'A8')
% elseif rho==0.03
%     xlswrite('rho.xlsx',x_opt,1,'A1')
%     xlswrite('rho.xlsx',y_opt,1,'A2')
% elseif rho==0.05
%     xlswrite('rho.xlsx',x_opt,1,'A3')
%     xlswrite('rho.xlsx',y_opt,1,'A4')
% elseif rho==0.08
%     xlswrite('rho.xlsx',x_opt,1,'A5')
%     xlswrite('rho.xlsx',y_opt,1,'A6')
% end

% 不同T的轨迹比较 对应Ttrajectoryplot
% if T==10
%     if changflag==1
%         xlswrite('Ttra.xlsx',x_opt,1,'A1')
%         xlswrite('Ttra.xlsx',y_opt,1,'A2')
%     elseif changflag==2
%         xlswrite('Ttra.xlsx',x_opt,1,'A3')
%         xlswrite('Ttra.xlsx',y_opt,1,'A4')
%     end
% elseif T==11
%     if changflag==1
%         xlswrite('Ttra.xlsx',x_opt,1,'A5')
%         xlswrite('Ttra.xlsx',y_opt,1,'A6')
%     elseif changflag==2
%         xlswrite('Ttra.xlsx',x_opt,1,'A7')
%         xlswrite('Ttra.xlsx',y_opt,1,'A8')
%     end
% elseif T==12
%     if changflag==1
%         xlswrite('Ttra.xlsx',x_opt,1,'A9')
%         xlswrite('Ttra.xlsx',y_opt,1,'A10')
%     elseif changflag==2
%         xlswrite('Ttra.xlsx',x_opt,1,'A11')
%         xlswrite('Ttra.xlsx',y_opt,1,'A12')
%     end
% end

% 不同T的性能比较 对应Tperformanceplot
% if T==10
%     if changflag==1
%         xlswrite('Tperform.xlsx',RR_opt,1,'A1')   
%     elseif changflag==2
%         xlswrite('Tperform.xlsx',RR_opt,1,'A3')
%     end
% elseif T==11
%     if changflag==1
%         xlswrite('Tperform.xlsx',RR_opt,1,'A5')
%     elseif changflag==2
%         xlswrite('Tperform.xlsx',RR_opt,1,'A7')
%     end
% elseif T==12
%     if changflag==1
%         xlswrite('Tperform.xlsx',RR_opt,1,'A9')
%     elseif changflag==2
%         xlswrite('Tperform.xlsx',RR_opt,1,'A11')
%     end
% end

% 不同rho的发射功率比较 对应rhoPsplot
% if T==10 
%     if changflag==1
%         xlswrite('rhoPs.xlsx',PP_opt,1,'A4')
%     elseif rho==0.03
%         xlswrite('rhoPs.xlsx',PP_opt,1,'A1')
%     elseif rho==0.05
%         xlswrite('rhoPs.xlsx',PP_opt,1,'A2')
%     elseif rho==0.08
%         xlswrite('rhoPs.xlsx',PP_opt,1,'A3')
%     end
% elseif T==12
%     if changflag==1
%         xlswrite('rhoPs.xlsx',PP_opt,1,'A14')
%     elseif rho==0.03
%         xlswrite('rhoPs.xlsx',PP_opt,1,'A11')
%     elseif rho==0.05
%         xlswrite('rhoPs.xlsx',PP_opt,1,'A12')
%     elseif rho==0.08
%         xlswrite('rhoPs.xlsx',PP_opt,1,'A13')
%     end
% end

% 不同T的性能比较 对应TPsplot
% if rho==0.05 
%     if changflag==1
%         xlswrite('TPs.xlsx',PP_opt,1,'A4')
%     elseif T==8
%         xlswrite('TPs.xlsx',PP_opt,1,'A1')
%     elseif T==10
%         xlswrite('TPs.xlsx',PP_opt,1,'A2')
%     elseif T==12
%         xlswrite('TPs.xlsx',PP_opt,1,'A3')
%     end
% % elseif T==8
% %     if changflag==1
% %         xlswrite('rhoPs.xlsx',PP_opt,1,'A14')
% %     elseif rho==0.01
% %         xlswrite('rhoPs.xlsx',PP_opt,1,'A11')
% %     elseif rho==0.05
% %         xlswrite('rhoPs.xlsx',PP_opt,1,'A12')
% %     elseif rho==0.1
% %         xlswrite('rhoPs.xlsx',PP_opt,1,'A13')
% %     end
% end

% 固定rho 两场Rs 对应Rsplot rhomix部分
% if T==8
%     if changflag==1
%         xlswrite('rhomixRs.xlsx',RR_opt,1,'A1')
%     elseif changflag==2
%         xlswrite('rhomixRs.xlsx',RR_opt,1,'A3')
%     end
% elseif T==10
%     if changflag==1
%         xlswrite('rhomixRs.xlsx',RR_opt,1,'A4')
%     elseif changflag==2
%         xlswrite('rhomixRs.xlsx',RR_opt,1,'A6')
%     end
% elseif T==13
%     if changflag==1
%         xlswrite('rhomixRs.xlsx',RR_opt,1,'A7')
%     elseif changflag==2
%         xlswrite('rhomixRs.xlsx',RR_opt,1,'A8')
%     end
% end

% 固定T 两场Rs 对应Rsplot Tmix部分
% if rho==0.3
%     if changflag==1
%         xlswrite('TmixRs.xlsx',RR_opt,1,'A2')
%     elseif changflag==2
%         xlswrite('TmixRs.xlsx',RR_opt,1,'A3')
%     end
% elseif rho==0.5
%     if changflag==1
%         xlswrite('TmixRs.xlsx',RR_opt,1,'A5')
%     elseif changflag==2
%         xlswrite('TmixRs.xlsx',RR_opt,1,'A6')
%     end
% elseif rho==0.7
%     if changflag==1
%         xlswrite('TmixRs.xlsx',RR_opt,1,'A7')
%     elseif changflag==2
%         xlswrite('TmixRs.xlsx',RR_opt,1,'A8')
%     end
% end

% 部分场比较 对于dataplotpart
% if T==8 
%     if rho==0.01
%         xlswrite('datapart.xlsx',x_opt,1,'A1')
%         xlswrite('datapart.xlsx',y_opt,1,'A2')
% %         xlswrite('datapart.xlsx',x_boundary,1,'A3')
% %         xlswrite('datapart.xlsx',y_boundary,1,'A4')
%     elseif rho==0.05
%         xlswrite('datapart.xlsx',x_opt,1,'A5')
%         xlswrite('datapart.xlsx',y_opt,1,'A6')
% %         xlswrite('datapart.xlsx',x_boundary,1,'A7')
% %         xlswrite('datapart.xlsx',y_boundary,1,'A8')
%     elseif rho==0.1
%         xlswrite('datapart.xlsx',x_opt,1,'A9')
%         xlswrite('datapart.xlsx',y_opt,1,'A10')
% %         xlswrite('datapart.xlsx',x_boundary,1,'A11')
% %         xlswrite('datapart.xlsx',y_boundary,1,'A12')
%     end
% elseif T==10
%     if rho==0.01
%         xlswrite('datapart.xlsx',x_opt,1,'A13')
%         xlswrite('datapart.xlsx',y_opt,1,'A14')
% %         xlswrite('datapart.xlsx',x_boundary,1,'A3')
% %         xlswrite('datapart.xlsx',y_boundary,1,'A4')
%     elseif rho==0.05
%         xlswrite('datapart.xlsx',x_opt,1,'A15')
%         xlswrite('datapart.xlsx',y_opt,1,'A16')
% %         xlswrite('datapart.xlsx',x_boundary,1,'A17')
% %         xlswrite('datapart.xlsx',y_boundary,1,'A18')
%     elseif rho==0.1
%         xlswrite('datapart.xlsx',x_opt,1,'A19')
%         xlswrite('datapart.xlsx',y_opt,1,'A20')
% %         xlswrite('datapart.xlsx',x_boundary,1,'A21')
% %         xlswrite('datapart.xlsx',y_boundary,1,'A22')
%     end
% elseif T==12
%     if rho==1e-2
%         xlswrite('datapart.xlsx',x_opt,1,'A23')
%         xlswrite('datapart.xlsx',y_opt,1,'A24')
% %         xlswrite('datapart.xlsx',x_boundary,1,'A3')
% %         xlswrite('datapart.xlsx',y_boundary,1,'A4')
%     elseif rho==0.05
%         xlswrite('datapart.xlsx',x_opt,1,'A25')
%         xlswrite('datapart.xlsx',y_opt,1,'A26')
% %         xlswrite('datapart.xlsx',x_boundary,1,'A27')
% %         xlswrite('datapart.xlsx',y_boundary,1,'A28')
%     elseif rho==0.1
%         xlswrite('datapart.xlsx',x_opt,1,'A29')
%         xlswrite('datapart.xlsx',y_opt,1,'A30')
% %         xlswrite('datapart.xlsx',x_boundary,1,'A31')
% %         xlswrite('datapart.xlsx',y_boundary,1,'A32')
%     end
% end