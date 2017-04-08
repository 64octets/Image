

%==============================================
%%      �����ƶ�ɨ����
%%      ���������������ӵ㣨n,tn��
%==============================================
function left(nopti,topti,rawIm,Rtaomax,Rt)
    global seed_n;
    global seed_t;
     left = 1
    nopti = round(nopti);
    topti = round(topti);
    tn = topti;
     %%������
    T = 1/6600000;
    Fs = 40000000;
    W = T*Fs;
    n = nopti-1;
    Line = round(n);
    framenum = 1;
    %%���ġ��岽
    
    P0t =  rawIm(:,Line, framenum);
    P1t = P0t(round(topti-W):round(topti+W));
    %������
    rlength = length(Rt);
    plength = length(P1t);
    dr = sqrt(sum(Rt.^2));
    dp = sqrt(sum(P1t.^2));
    fc = 6600000;
    
    xtao =  -Fs/(2*fc):0.8:Fs/(2*fc);
    ycross = zeros(1,length(xtao));
    i = 1;
    for tao = -Fs/(2*fc):0.8:Fs/(2*fc)
        Pt =P0t((round(tn-W)+round(tao)):(round(tn+W)+round(tao)));
        rpsum = sum(Rt.*Pt);
        crossR = rpsum/(dr*dp);
        ycross(1,i) = crossR;
        i = i+1;
    end
%ycross
    
    %rpsum = sum(Rt.*Pt);
    %crossR = rpsum/(dr*dp);
    %���߰˲�
   
   
    [Rtao0 tao0] = max(abs(ycross));
    taomax =  xtao(tao0);
    if abs(Rtao0) > 0.9
        tn = tn + xtao(tao0);
        Rt = (Rt*512+Pt)/513;
    else
        Rt = Rt;
    end
    %�ھš�ʮ��ʮһ��
    Rtaoaverage = (abs(Rtaomax)+abs(Rtao0))/2;
    Rtaomax = Rtao0;
    subplot(221),
    plot(n,tn,'r.');
    if abs(Rtaoaverage) > 0.8
        if Line > 1
        %%��������
           left1(n,tn,rawIm,Rtaomax,Rt);
        end
    end

    
    
    %==============================================
%%      �����ƶ�ɨ����
%%      ���������������ӵ㣨n,tn��
%==============================================
function left1(nopti,topti,rawIm,Rtaomax,Rt)
    global seed_n;
    global seed_t;
     left1 = 1
    %%������
    nopti = round(nopti);
    topti = round(topti);
    tn = topti;
    T = 1/6600000;
    Fs = 40000000;
    W = T*Fs;
    n = nopti-1;
    Line = round(n);
    framenum = 1;
    %%���ġ��岽
    
    P0t =  rawIm(:,Line, framenum);
    P1t = P0t(round(topti-W):round(topti+W));
    %������
    rlength = length(Rt);
    plength = length(P1t);
    dr = sqrt(sum(Rt.^2));
    dp = sqrt(sum(P1t.^2));
    fc = 6600000;
    
    xtao =  -Fs/(2*fc):0.8:Fs/(2*fc);
    ycross = zeros(1,length(xtao));
    i = 1;
    for tao = -Fs/(2*fc):0.8:Fs/(2*fc)
        Pt =P0t((round(tn-W)+round(tao)):(round(tn+W)+round(tao)));
        rpsum = sum(Rt.*Pt);
        crossR = rpsum/(dr*dp);
        ycross(1,i) = crossR;
        i = i+1;
    end
ycross;
    
    %rpsum = sum(Rt.*Pt);
    %crossR = rpsum/(dr*dp);
    %���߰˲�
   
   
    [Rtao0 tao0] = max(abs(ycross));
    taomax =  xtao(tao0);
    if abs(Rtao0) > 0.9
        tn = tn + xtao(tao0);
        Rt = (Rt*512+Pt)/513;
    else
        Rt = Rt;
    end
    %�ھš�ʮ��ʮһ��
    Rtaoaverage = (abs(Rtaomax)+abs(Rtao0))/2;
    Rtaomax = Rtao0;
    subplot(221),
plot(n,tn,'r.');
    if abs(Rtaoaverage) > 0.8
        if Line > 1
        %%��������
           left(nopti,topti,rawIm,Rtaomax,Rt);
        end
    else
         Rtao0 = Rtao0
         Rtaoaverage = Rtaoaverage
    end

    
    
    
    

%==============================================
%% �����ƶ�ɨ����
%% ������������Ƴ�ʼ���꣨nopti,topti��
%%          RFͼ��rawIm
%%          ������ϵ��ƽ��ֵRtaomax
%%          �ο��ź� Rtn,Rt
%==============================================
    function right(nopti,topti,rawIm,Rtaomax,Rtn,Rt)
        global seed_n;
        global seed_t;
        
         right = 2
         nopti = round(nopti);
         tn = round(topti);
    %%������;
    
    T = 1/6600000;
    Fs = 40000000;
    W = T*Fs;
    n = nopti+1;
    Line = round(n);
    framenum = 1;
    %%���ġ��岽
    P0t =  rawIm(:,Line,framenum);
    P1t = P0t(round(topti-W):round(topti+W));
    %������
    rlength = length(Rtn);
    plength = length(P1t);
    dr = sqrt(sum(Rtn.^2));
    dp = sqrt(sum(P1t.^2));
    fc = 6600000;
    
    xtao =  -Fs/(2*fc):0.8:Fs/(2*fc);
    ycross = zeros(1,length(xtao));
    i = 1;
    for tao = -Fs/(2*fc):0.8:Fs/(2*fc)
        Pt =P0t((round(tn)-round(W)+round(tao)):(round(tn)+round(W)+round(tao)));
        rpsum = sum(Rtn.*Pt);
        crossR = rpsum/(dr*dp);
        ycross(1,i) = crossR;
        i = i+1;
    end
    ycross;
    
    %rpsum = sum(Rtn.*Pt);
    %crossR = rpsum/(dr*dp);
    %���߰˲�
    [Rtao0 tao0] = max(abs(ycross));
    taomax =  xtao(tao0);
    if abs(Rtao0) > 0.9
        tn = tn + taomax;
        Rtn = (Rtn*512+Pt)/513;
    else
        Rtn = Rt;
    end
    %�ھš�ʮ��ʮһ��
    Rtaoaverage = (abs(Rtaomax)+abs(Rtao0))/2;
    Rtaomax = Rtaoaverage;
    subplot(221),
plot(n,tn,'r.');
    if abs(Rtaoaverage) < 0.8
        if Line > 1
           Rtao0 = Rtao0
           Rtaoaverage = Rtaoaverage
           left(seed_n,seed_t,rawIm,0.8,Rt);
        end
    else
        %%��������
        n;
        tn ;
        if Line < 511
            right1(n,tn,rawIm,Rtaomax,Rtn,Rt);
        else
        end
    end

    
    
    
    
    %==============================================
%% �����ƶ�ɨ����
%% ������������Ƴ�ʼ���꣨nopti,topti��
%%          RFͼ��rawIm
%%          ������ϵ��ƽ��ֵRtaomax
%%          �ο��ź� Rtn,Rt
%==============================================
    function right1(nopti,topti,rawIm,Rtaomax,Rtn,Rt)
        global seed_n;
        global seed_t;
         right1 = 2
         nopti = round(nopti);
         tn = round(topti);
    %%������
    
    T = 1/6600000;
    Fs = 40000000;
    W = T*Fs;
    n = nopti+1;
    Line = round(n);
    framenum = 1;
    %%���ġ��岽
    P0t =  rawIm(:,Line,framenum);
    P1t = P0t(round(topti-W):round(topti+W));
    %������
    rlength = length(Rtn);
    plength = length(P1t);
    dr = sqrt(sum(Rtn.^2));
    dp = sqrt(sum(P1t.^2));
    fc = 6600000;
    
    xtao =  -Fs/(2*fc):0.8:Fs/(2*fc);
    ycross = zeros(1,length(xtao));
    i = 1;
    for tao = -Fs/(2*fc):0.8:Fs/(2*fc)
        Pt =P0t((round(tn)-round(W)+round(tao)):(round(tn)+round(W)+round(tao)));
        rpsum = sum(Rtn.*Pt);
        crossR = rpsum/(dr*dp);
        ycross(1,i) = crossR;
        i = i+1;
    end
    ycross;
    
    %rpsum = sum(Rtn.*Pt);
    %crossR = rpsum/(dr*dp);
    %���߰˲�
    [Rtao0 tao0] = max(abs(ycross));
    taomax =  xtao(tao0);
    if abs(Rtao0) > 0.9
        tn = tn + taomax;
        Rtn = (Rtn*512+Pt)/513;
    else
        Rtn = Rt;
    end
    %�ھš�ʮ��ʮһ��
    Rtaoaverage = (abs(Rtaomax)+abs(Rtao0))/2;
    Rtaomax = Rtaoaverage;
    subplot(221),
    plot(n,tn,'r.');
    if abs(Rtaoaverage) < 0.8
        if Line > 1
            Rtao0 = Rtao0
           Rtaoaverage = Rtaoaverage
           left(seed_n,seed_t,rawIm,0.8,Rt);
          
        end
    else
        %%��������
        n;
        tn ;
        if Line < 511
            right(n,tn,rawIm,Rtaomax,Rtn,Rt);
        else
        end
    end
