%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% �ܳ���
%% 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 clc;
  clear all;
  close all;
 
 %% ����׼����ԭʼBͼ���Ҷ�ͼ
%  I = imread('carotid.png');
%  G = rgb2gray(I);
%  figure;
%  subplot(121),imshow(I);
%  subplot(122),imshow(G);
 %% ��ȡRF����
 figure;

 [Im,header] = RPread('22-55-09.rf');
%  Im = Im(:,2:2:end,:);
 for i = 1: size(Im, 3)
       
%     image(Im(:,:,i));
%     colormap(gray(256));
%     axis off;
    %axis([0 256 0 2080]);
    
    
    Imin = abs(hilbert(Im(:,:,i)));
    A = 35;
    M = 30;
    Imout = (20*log10(Imin/max(Imin(:))) + A)/ M * 255;
    image(Imout);
    rfimtitle = sprintf('RF Raw Image %d',i);
    title(rfimtitle);
    colormap(gray(256));
    
    
    drawnow;
    title(i);
    
    pause(0.05);
 end
 %% ��ʾɨ����1,2,3,4
 figure;
rf1 = Im(:,50);
rf2 = Im(:,100);
rf3 = Im(:,150);
rf4 = Im(:,200);
subplot(221),plot(rf1);
subplot(222),plot(rf2);
subplot(223),plot(rf3);
subplot(224),plot(rf4);
%% �ĺ�ɨ���ߵİ����ź�
enve_rf4 = abs(hilbert(rf4));
figure;
plot(enve_rf4);

%% ��ʾrfԭʼͼ��
framenum = 1;
RPviewrf(Im, header,framenum);%�õ�rfԭʼͼ��

%% �õ�ROI-RFͼ��
[ROI_rf,hmin,hmax,out] = getrfimage(Im, header, framenum);
ROI_Im = Im(hmin:hmax,:);
ROI_Imsc = sqrt(abs(hilbert(ROI_Im(:,:,framenum))));
figure;
imagesc(ROI_Imsc);
title('ROI in RF image');
colormap(gray);
%% �˲���

%% ���ӵ㣬�ָ���طָ����㼯
LIMA = 0;
[ markPointRight_LI ,markPointLeft_LI] = seeds(LIMA,Im, hmin,hmax,header, 1);%�ȷָ�LI
LIMA = 1;
[ markPointRight_MA ,markPointLeft_MA] = seeds(LIMA,Im, hmin,hmax,header, 1);%�ٷָ�MA
%% �����ϳ�
 LIMA = 0;
 markPoint_LI = [markPointRight_LI ;markPointLeft_LI];%��������ĺϳ�
 markPoint_LI = unique(markPoint_LI,'rows');%ɾ����������ͬ���У�unique�������������յ�һ������
 windowMeanPoint_LI = coherentPro(LIMA,markPoint_LI,ROI_Imsc);%�����ĺϳ�
 LIMA = 1;
 markPoint_MA = [markPointRight_MA ;markPointLeft_MA];
 markPoint_MA = unique(markPoint_MA,'rows');
 windowMeanPoint_MA = coherentPro(LIMA,markPoint_MA,ROI_Imsc);
 %% %��LI��MA��ͬһ��ͼ����ʾ����
showLIMA (ROI_Imsc,windowMeanPoint_LI, windowMeanPoint_MA);
%%  LI��ǿ
enhancedLI( ROI_Imsc,windowMeanPoint_LI );
%% ��һ֡ NC



