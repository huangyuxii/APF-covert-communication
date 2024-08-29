%% simulation setup
clear all;
% covert rho
L=5; rho=0.05; error=0.01;
snr1=Bisection(L,rho,error);
disp(['max sinr in covert = ' num2str(snr1)]);
snr2=1e3;
disp(['max sinr in noncovert = ' num2str(snr2)]);

% initial setup
H=100;
V=10;%10 15
T=72; %57.5 %80 %72
%T=30; %30
%dT=30/256;%dT_res(13);%15;
dT=1;

global x0 y0 x1 y1;
x0=500;%500;%100;%200; % 100 200                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
y0=200;%200;%50;%40; % 20 40
x1=200; %200;   %40;%0;
y1=500; %500;    %80;%100;

% x0=160;%200; % 100 200                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
% y0=40;%40; % 20 40
% x1=0;%0;
% y1=100;%100;

global wx wy x2 y2; 
wx=0;
wy=0;
x2=150;
y2=150;

% 为具体情况 0遮蔽 1非遮蔽 2部分遮蔽
changflag=2 ;
% 计时
t=0;
% 隐蔽范围
R_w=(snr2/snr1-H^2)^0.5;


disp('...........................................');
disp('Parameters:');
disp(['distance=' num2str(norm([x1-x0 y1-y0])) 'm']);
disp(['total length=' num2str(V*T) 'm']);
disp(['max path=' num2str(norm([x0-wx y0-wy])+norm([x1-wx y1-wy])) 'm']);
disp(['changflag=' num2str(changflag)]);
disp(['convert rho= ' num2str(rho) ' convert Rw=' num2str(R_w)]);
disp('...........................................');
if norm([x1-x0 y1-y0])>V*T
    disp('Not feasible');
    disp('...........................................');
else
    if V*T>=norm([x0-wx y0-wy])+norm([x1-wx y1-wy])
        disp('Sufficient length.');
        disp('...........................................');
        tic;
        sufficient_optimal;
        toc;
        disp(['Optimal result -- ' num2str(R_opt)]);
        disp('...........................................');
    else
        disp('Insufficient length ... ');
        disp('...........................................');
        %disp('SCP solution:')
        if abs(norm([x0-wx y0-wy])+norm([x1-wx y1-wy])-V*T)/V/T<0.01
            disp('The length is too close to the sufficient length.');
            disp('The result may be inaccurate, due to computational accuracy limit.');
            tic;
            sufficient_optimal;
            toc;
            disp(['Optimal result -- ' num2str(R_opt)]);
            disp('...........................................');
        else
            tic;
%             insufficient_optimal;
              insufficient_optimal;
%             suffplot_test;
            toc;
            disp(['Optimal result -- ' num2str(R_opt)]);
            disp('...........................................');
        end
    end
end