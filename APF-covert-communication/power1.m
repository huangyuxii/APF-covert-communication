function P = power1(rw,H,snr1,snr2,changflag)
%artificial potential calculation
%   we use the transmission rate under free space path loss model as an
%   example.
% input:r 为(x,y)到用户(wx,wy)的距离
% input:H 为无人机飞行高度
% input:rw 为(x,y)到窃听者(x2,y2)的距离
% input:snr1 为遮蔽要求的最大信噪比
% input:snr2 为设定最大信噪比
% input:changflag 为具体情况 0遮蔽 1非遮蔽 2部分遮蔽
% output:P 为发射功率

if changflag==1
    % 非遮蔽情况下
    snr=snr2;
elseif changflag==2
    % % 部分场位于遮蔽情况下
    if snr1*(rw^2+H^2)>snr2
        snr=snr2;
    else
        snr=snr1*(rw^2+H^2);
    end
end    
P=snr*10^(-4);
