%==============================================
%%  �����ƶ�ɨ����
%% ���������
%%     mark_li       -   �ڼ�������
%%     mark_left     -   ������������
%%     nopti,topti   -   ������ӵ�
%%     rawIm         -   ԭʼͼ��
%%     Rtaomax       -   �ж��Ƿ����ƶ��Ĳ�����seeds������
%%     Rt            -   ������ӵ�����ɨ���ߵ��ź�
%% ���������
%%     mark_left     -   �������������
%%  ==============================================
function  mark_left = left(mark_li,mark_left,nopti,topti,rawIm,Rtaomax,Rt)
    global seed_n;
    global seed_t;
     left = 1
    nopti = round(nopti);
    topti = round(topti);
    tn = topti;
     %%������
    T = 1/6600000;
    Fs = 40000000;
    W = 2*T*Fs;
    n = nopti-1;
    Line = round(n);
    framenum = 1;
    %%���ġ��岽
    
    P0t =  rawIm(:,Line, framenum);
    P1t = P0t(round(topti-W):round(topti+W));
    %������
    rlength = length(Rt);
    plength = length(P1t);
    rmean = mean(Rt);
   
   dr = sqrt(sum((Rt - rmean).^2));
    % dp = sqrt(sum((P1t - pmean).^2));
%     dr = sqrt(sum((Rt).^2));
    
    fc = 6600000;
    pace = 0.1;
    xtao =  -Fs/(2*fc):pace:Fs/(2*fc);
    ycross = zeros(1,length(xtao));
    i = 1;
    for tao = -Fs/(2*fc):pace:Fs/(2*fc)
        Pt =P0t((round(tn-W)+round(tao)):(round(tn+W)+round(tao)));
        rpsum = sum(Rt.*Pt);
         pmean = mean(Pt);
         dp = sqrt(sum((Pt - pmean).^2));
%         dp = sqrt(sum((P1t).^2));
        crossR = rpsum/(dr*dp);
        ycross(1,i) = crossR;
        i = i+1;
    end
%ycross
ycross = ycross;
    
    %rpsum = sum(Rt.*Pt);
    %crossR = rpsum/(dr*dp);
    %���߰˲�
   
   
    [Rtao0 tao0] = max((ycross));
    taomax =  xtao(tao0);
    if abs(Rtao0) > 0.9
        tn = tn + xtao(tao0);
        Rtn = (Rt*(size(rawIm,2))+Pt)/(size(rawIm,2));
    else
        Rt = Rt;
    end
    %�ھš�ʮ��ʮһ��
    Rtaoaverage = (abs(Rtaomax)+abs(Rtao0))/2;
    Rtaomax = Rtao0;
    %subplot(221),
    plot(n,tn,'r+');
    mark_left(mark_li,:) = [n,tn];
    if abs(Rtaoaverage) > 0.8
        if Line > 1
        %%��������
           mark_li = mark_li+1;
          mark_left = left1(mark_li,mark_left,n,tn,rawIm,Rtaomax,Rt);
        end
    end
   if length(mark_left) == 0
       mark_left = [nopti,topti];
   end
end


