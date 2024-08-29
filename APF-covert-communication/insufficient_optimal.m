tic;
%% optimal trajectory generation
ds=0.01; % resolution for 1.curve generation 2.same point judge 3.rope length judge
tra_ds=5;
A_range=[angle(x0-x1+1j*(y0-y1)) angle(x0-wx+1j*(y0-wy))];%atan([(y1-y0)/(x1-x0) (wy-y0)/(wx-x0)]);
% A_range=[-1 0.7];
Q_range=[0 1000];

% 求偏导 der_x,der_y 分别为x,y的偏导
der_x=1;der_y=2;
% A_range=[0.443757226562477,0.443757226562942];
% Q_range=[0,0.013801454150707];

A=mean(A_range); 
Q=mean(Q_range);

opt_mark=0; % marker: 1 -- optimal found; 0 -- optimal not found
% isopleth; %绘等值线图
% flag
ang_flag=0;

% plot([x0 x1],[y0 y1],'^');hold on;
% % user position
% plot(wx,wy,"k"+"^",'MarkerFaceColor','k','markersize',7);
% % warden position
% plot(x2,y2,'or','markersize',12);

while opt_mark==0
    %disp(A_range)
    %disp(Q_range)
    %disp([A Q]);
    
    A1_aux=Q*cos(A);
    A2_aux=Q*sin(A);
    x=x0;
    y=y0;
    
    x_opt=x0;
    y_opt=y0;
    ii=1;
    s=0;
    
%     intforce=0; %力场积分
%     r_last=((x-wx)^2+(y-wy)^2)^0.5;
%    disp(A_range);
%    disp(Q_range);
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
        
%         dr=r-r_last;
%         intforce=intforce+force(r,H,rw,snr1,snr2,changflag)*dr;
%         r_last=r;
%         if intforce<0
%             disp(['intforce<0:'num2str(intforce)]);
%         end
        
        x_opt(ii+1)=x;
        y_opt(ii+1)=y;
        ii=ii+1;
        
        if sqrt((x-x1)^2+(y-y1)^2)>tra_ds
            % 绳子轨迹(x,y)还未接近目的点(x1,y1)
            % 最佳拉力范围的选择  Q↑ r(s)↓
            p_temp=abs(x1*y0-x0*y1)/((x1-x0)^2+(y1-y0)^2)^0.5;
            ang_temp=angle(x1-x0+1j*(y1-y0))-pi/2;
            r_temp=((x-wx)^2+(y-wy)^2)^0.5;
            ang2_temp=angle(x-wx+1j*(y-wy));
            r1_temp=((x1-wx)^2+(y1-wy)^2)^0.5;
            ang3_temp=asin(100*ds/r1_temp);
            if r_temp>p_temp/cos(ang2_temp-ang_temp)
                % 需增大Q 所以Q在
                % 上1/2处
%                 if ((x-x0)^2+(y-y0)^2)^0.5>((x-x1)^2+(y-y1)^2)^0.5
%                     % 无回环 变化与之前一致
% %                     disp('...........................................');
%                     disp('increasing Q');
                    Q_range(1)=Q;
                    if abs(Q_range(1)-Q_range(2))<1e-6
                        Q_range=[Q Q*2];
                    end               
                    Q=mean(Q_range);
                    break;
%                 else
                    % 有回环 变化不一致
%                     disp('decreasing Q in in');
%                     Q_range(2)=Q;
%                     if abs(Q_range(1)-Q_range(2))<1e-14
%                         Q_range=[Q/2 Q];
%                     end
%                     Q=mean(Q_range);
%                     break;
%                 end
%                     if angle(x-x_opt(ii-1)+1j*(y-y_opt(ii-1)))<angle(x1-wx+1j*(y1-wy)) & angle(x-x_opt(ii-1)+1j*(y-y_opt(ii-1)))>0
%                         ang_flag=1;
% %                         disp(['angle(x-x_opt(ii-1)+1j*(y-y_opt(ii-1))): ' num2str(angle(x-x_opt(ii-1)+1j*(y-y_opt(ii-1))))]);
%                         disp('increasing Q in in for ang-flag');
%                         Q_range(1)=Q;
%                         if abs(Q_range(1)-Q_range(2))<1e-14
%                             Q_range=[Q Q*2];
%                         end               
%                         Q=mean(Q_range);
% 
% %                         Q_range(2)=Q;
% %                         if abs(Q_range(1)-Q_range(2))<1e-14
% %                             Q_range=[Q/2 Q];
% %                         end
% %                         Q=mean(Q_range);
%                         break;                                                
%                     else
%                         disp('decreasing Q in in');
%                         Q_range(2)=Q;
%                         if abs(Q_range(1)-Q_range(2))<1e-14
%                             Q_range=[Q/2 Q];
%                         end
%                         Q=mean(Q_range);
%                         break;
%                     end
            elseif ang2_temp>angle(x1-wx+1j*(y1-wy)) %&& (ang_flag==0)
                % 需减小Q 所以Q在下1/2处
%                 disp('...........................................');
%                 if ((x-x0)^2+(y-y0)^2)^0.5>((x-x1)^2+(y-y1)^2)^0.5
%                     disp('decreasing Q');
                    Q_range(2)=Q;
                    if abs(Q_range(1)-Q_range(2))<1e-6
                        Q_range=[Q/2 Q];
                    end
                    Q=mean(Q_range);
                    break;
%                 else
%                     disp('increasing Q in de');
%                     Q_range(1)=Q;
%                     if abs(Q_range(1)-Q_range(2))<1e-14
%                         Q_range=[Q Q*2];
%                     end               
%                     Q=mean(Q_range);
%                     break;
%                 end
            elseif ang_flag==1
            % Q不变 继续迭代
            end
        else
            ang_flag=0;
            disp('close to destination');
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
%                         if A+0.01>angle(x0-wx+1j*(y0-wy))
%                             A_range=[A angle(x0-wx+1j*(y0-wy))];
%                         else
                            A_range=[A A+0.01];
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
    end
%    plot(x_opt,y_opt);hold on;%xlim([0 100]);ylim([0 80]);
%    disp(['S -- ' num2str(s)]);
%    disp('......................................................................................');
%    pause;
end
disp('success !');
disp('......................................................................................');
% 得到最佳 Q A 
% 根据最佳拉力得到最优解
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

    if sqrt((x-x1)^2+(y-y1)^2)<=tra_ds
        break;
    end
end

%%
% isopleth;
% plot(x_opt,y_opt,'g');hold on;
% if x_boundary(1)~=x0
%     plot(x_boundary,y_boundary,'p');
% end

xlim([0 500]);ylim([0 500])

R_opt=R_opt;
t=t+toc;

% power 
x_p=(1:1:length(RR_opt))/1000; 

plot(x_p,RR_opt);hold on;


% save('data\apf-RRopt-T11','RR_opt');
% save('data\apf-PPopt-T11','PP_opt');

% figure;
% XR=(1:1:T*1000)/1000;
% 
% % XR=(1:1:80000)/1000;
% % for i=1:1:23000
% %     RR_opt(T*1000+i)=RR_opt(T*1000);
% % end
% plot(XR,RR_opt(1:80000)); hold on;
% ylim([0 1]);
% xlim([0 T]);

% save('data\T57_RRopt','RR_opt');
% load('data\T57_RRopt');
% plot(XR,RR_opt); hold on;

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