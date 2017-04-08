%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ѡȡ��ʼ���ӵ㣬�����������ӵ�
%% Inputs: 
%%     LIMA     -  ��־λ�����ڼ���������LI����MA
%%     rawIm    -   The data to view
%%     hmin,hmax -  ����Ȥ��������±߽�ֵ
%%     header   -   The file header
%%     framenum - The frame number to show
%% outputs:
%%     markPointRight   - �������Ƶ������
%%     markPointLeft    - �������Ƶ������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [markPointRight ,markPointLeft,initalSeeds,iter] = seeds(LIMA,rawIm, hmin,hmax,header, framenum)
global seed_n;
global seed_t;
markPointLeft = [];
markPointRight = [];
%%���Ȼ��ԭʼͼ��
clc
rawIm = rawIm(hmin:hmax,:);
Im = RF2Bmode(rawIm, framenum);%��������ѹ��
%Im = sqrt(abs(hilbert(rawIm(:,:,framenum))));
%Im = rawIm;
c = 340;s = .001;Fs = 40000000;
if LIMA == 0
   interval = s*Fs/(20*c);%����interval��������ӵ����Ѱ��Χ�йأ�����Խ��������ӵ����ֹ����õĳ�ʼ���ӵ��ϵԽ�������Ҫ��ѰMA��ɽ��ò������õô�һЩ�������ó�2*s*Fs/c
   rfimtitle = sprintf('select LI initial points in RF Raw Image');
else if LIMA == 1
   interval = s*Fs/(15*c);
   rfimtitle = sprintf('select MA initial points in RF Raw Image');
    end
end
figure, 
%subplot(2,2,1);
image(Im);
title(rfimtitle);
colormap(gray(256));
[n,tn] = ginput(); %�Ȳ���һ��
k=size(n);
axis on
hold on
initalSeeds = [];%������ǳ�ʼ���ӵ������
iter = [];%����ÿ�����ӵ�ĵ�������
 for i=1:k
    plot(n(i),tn(i),'r*');
    %text(n(i),tn(i),sprintf('(%d,%d)',round(n(i)),round(tn(i))),'color','red')
     Line = round(n(i)); 
      if(header.filetype == 16)
        if(n(i)<1 || n(i)>header.w)
            return;
        end    
    else
         if(n(i)<1 || n(i)>header.h)
            return;
        end
      end
      
    Snt = rawIm(:,Line,framenum);
    
    %subplot(2,2,2);
    %plot(Snt, 'b'); 
    %axis([0 541 min(Snt) max(Snt)]); 
    %rftitle = sprintf('RF Line: %d', Line);
    %title(rftitle); 
    %axis off
 %%��ó�ʼ���ӵ�[x(i),y(i)]����RFɨ���ߵ��ź�S�󣬽�ȡ��ʼ���ӵ긽�����ź�S0
    
    tn(i);
    S0nt = Snt(round(tn(i)-interval):round(tn(i)+interval));
    length(S0nt);
    min(S0nt);
    max(S0nt);
    %subplot(2,2,3);
    %plot(S0nt,'b');    
    %axis([0 length(S0nt) min(S0nt) max(S0nt)]); 
    %xlim([0,length(S0)]);
    %ylim([min(S0),max(S0)]);
    %rftitle = 'section signal around the seed';
    %title(rftitle); 
    %%��S0�İ��缰�����ֵ
    S0envelop = hilbert(S0nt);
[S0envelopmax tnop] = max(S0envelop);%���ֵ��tn
%subplot(224),plot(abs(S0envelop));
%length(S0envelop);
%max(S0envelop);
%min(S0envelop);
%axis([0 length(S0envelop) min(S0envelop) max(S0envelop)]);
%length(S0envelop)
%max(S0envelop)
%min(S0envelop)
%%��RFͼ������ʾ��������ӵ�
nopti = n(i);%������ӵ�
topti = tnop-1+round(tn(i)-interval);
seed_n = nopti;
seed_t = topti;
%subplot(221)
plot(n(i),topti,'ro');%������ͨ��S��ȡ�Ĳ���S0�źţ������Ҫ������ֵ��Ӧ����
initalSeeds = [initalSeeds;n(i),topti];%��ÿ�����ӵ�����걣������������
%text(n(i),tnop+round(tn(i)-interval),sprintf('(%d,%d)',round(n(i)),tnop+round(tn(i)-interval)),'color','red');
tnop = topti;

%%������
tn(i) = tnop;
T = 1/6600000;
W = 2*T*Fs;%ԼΪ6
Rt = Snt(round(tn(i)-W):round(tn(i)+W));
%%���ġ��岽
n(i) = round(n(i))+1;
Line = round(n(i));
tn(i) = tn(i)
P0t = rawIm(:,Line,framenum);
P1t =P0t(round(tn(i)-W):round(tn(i)+W));
fc = 6600000;
%������
rlength = length(Rt);
plength = length(P1t);
rmean = mean(Rt);

dr = sqrt(sum((Rt - rmean).^2));
% dp = sqrt(sum((P1t - pmean).^2));
% dr = sqrt(sum((Rt).^2));
% dp = sqrt(sum((P1t).^2));

%tao = -Fs/(2*fc):0.2:Fs/(2*fc);
%Pt =P0t(round(tn-W+tao):round(tn+W+tao))

%tao = Fs/(2*fc);
pace = 0.1;
xtao =  (-Fs/(fc)):pace:(Fs/(fc));
ycross = zeros(1,length(xtao));
j = 1;
for tao = -Fs/(fc):pace:Fs/(fc)
        Pt =P0t((round(tn(i))-round(W)+round(tao)):(round(tn(i))+round(W)+round(tao)));
        length(Rt)
        length(Pt)
        pmean = mean(Pt);
%         dp = sqrt(sum((P1t).^2));
         dp = sqrt(sum((Pt - pmean).^2));
        rpsum = sum(Rt.*Pt);
        crossR = rpsum/(dr*dp);
        ycross(1,j) = crossR;
        j = j+1;
end
ycross;
ycross = ycross;
%rpsum = sum(Rt.*Pt);
%crossR = rpsum/(dr*dp)%%%%%%%%%%%%%%%%%%%%%%%%%%%%���Ǿ���
%���߰˲�
Rtaomax = 0.8;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
firstright = 1
% [Rtao0 tao0] = max(abs(ycross))%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Rtao0 tao0] = max(ycross);
taomax =  xtao(tao0)
if abs(Rtao0) > 0.9
    tn(i)
    tn(i) = tn(i) + xtao(tao0);
    tn(i)
    Rtn = (Rt*(size(Im,2))+Pt)/(size(Im,2));
else
     Rtn = Rt;
end
%�ھš�ʮ��ʮһ��
Rtaoaverage = (abs(Rtaomax)+abs(Rtao0))/2
Rtaomax = Rtaoaverage;
%subplot(221),
plot(n(i),tn(i),'r+');
 mark_left = [];
 mark_right = [];
if abs(Rtaoaverage) < 0.8
   
    mark_li = 1;
    mark_left(mark_li,:) = [n(i),tn(i)];
    mark_li = mark_li + 1;
    %%�෴�����ظ��㷨
   mark_left = left(mark_li,mark_left,seed_n,seed_t,rawIm,0.8,Rt);
else
    %%��������
    n(i)
    tn(i)
    if n(i) < 511
       
        mark_ri = 1;
        mark_right(mark_ri,:) = [n(i),tn(i)];
        mark_ri = mark_ri + 1;
        markpoint_right = mark_right;
        [ mark_right ,mark_left] = right(mark_ri,mark_right,n(i),tn(i),rawIm,Rtaomax,Rtn,Rt);
    else
    end
end
%% ��ÿ�����ӵ��������
%length_left = [];
%length_left = [length_left;length(markPointLeft)];
%length_right = [];
%length_right = [length_right;length(markPointRight)];
%iteration = length_left + length_right;
%% ��ÿһ����ѳ�ʼ��õ��ı߽�㱣��
mark_left = [mark_left ones(size(mark_left,1),1)*i];%�����Ϊ��x,y,flag����flagλ�Ǳ�־λ����ʾ������һ�����ӵ����ɵ�
mark_right = [mark_right ones(size(mark_right,1),1)*i];
markPointLeft = [markPointLeft;mark_left];
markPointRight = [markPointRight;mark_right];
%% ÿ�����ӵ�������� 
mark_left = unique(mark_left,'rows');
mark_right = unique(mark_right,'rows');
%markPointofNseeds = [mark_left;mark_right];
iter = [iter;size(mark_left,1) + size(mark_right,1)];
mark_left = [];
mark_right = [];
 end 
% markPointLeft = [markPointLeft;seed_n,seed_t];
end



    
    
   
    
    

