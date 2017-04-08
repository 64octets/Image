clear all;
close all;
clc


figure;
[Im,header] = RPread('p3.rf');
%% ��ʾrfԭʼͼ��
if(size(Im,2) > 256)
    Im = Im(:,2:2:end,:);%ȡż����ɨ����
end
for framenum = 1 : 37%
    RPviewrfs(Im, header, framenum);%�õ�rfԭʼͼ��
end
for framenum = 38 : size(Im, 3)%37%
    RPviewrfs(Im, header, framenum);%�õ�rfԭʼͼ��
end
%% 
%Im = Im(:,2:2:end,:);
%% ��һ֡ RF�ź�
framenum = 1;
Im_1 = Im(:,:,framenum);
close all;
RPviewrfs(Im, header, 1);
figure;
rf1 = Im_1(:,1);
rf2 = Im_1(:,round(size(Im_1,2)*0.5));
rf3 = Im_1(:,round(size(Im_1,2)*0.7));
rf4 = Im_1(:,round(size(Im_1,2)*1));
subplot(221),plot(rf1);
subplot(222),plot(rf2);
subplot(223),plot(rf3);
subplot(224),plot(rf4);
% j = 1;
% space = 20;
% rf22 = zeros(1,(length(rf2)/space));
% for i = 1:space:(length(rf2)-space)
%     rf22(1,j) = mean(rf2(i:(i+space)));
%     j = j+1;
% end
% figure,plot(rf22);
% extrMaxIndex = find(diff(sign(diff(rf22)))==-2)+1;
%% �ĺ�ɨ���ߵİ����ź�
enve_rf4 = abs(hilbert(rf4));
figure;
plot(enve_rf4);
%% ��ʾrfԭʼͼ��
framenum = 1;
RPviewrf(Im, header,framenum);%�õ�rfԭʼͼ��
%% �õ�ROI-RFͼ��
[ROI_rf,hmin,hmax,out] = getrfimage(Im_1, header, framenum);
% ���ߣ�
% load('hmax.mat');
% load('hmin.mat');
ROI_Im_1 = Im_1(hmin:hmax,:);
ROI_Imsc = RF2Bmode(ROI_Im_1, framenum);%��������ѹ��
%ROI_Imsc = sqrt(abs(hilbert(ROI_Im_1)));%(:,:,framenum)
%figure;
%imagesc(ROI_Imsc);
%title('ROI in RF image');
%colormap(gray);

%% ���ӵ㣬�ָ���طָ����㼯
LIMA = 0;
[ markPointRight_LI ,markPointLeft_LI,initalSeeds_LI,iter_LI] = seeds(LIMA,Im_1, hmin,hmax,header, 1);%�ȷָ�LI
% LIMA = 1;
% [ markPointRight_MA ,markPointLeft_MA,initalSeeds_MA,iter_MA] = seeds(LIMA,Im_1, hmin,hmax,header, 1);%�ٷָ�MA
%% �����ϳ�
 LIMA = 0;
 markPoint_LI = [markPointRight_LI ;markPointLeft_LI];%��������ĺϳ�
 markPoint_LI = unique(markPoint_LI,'rows');%ɾ����������ͬ���У�unique�������������յ�һ������
 windowMeanPoint_LI = coherentPro(LIMA,markPoint_LI,ROI_Imsc,initalSeeds_LI,iter_LI);%�����ĺϳ�
%  LIMA = 1;
%  markPoint_MA = [markPointRight_MA ;markPointLeft_MA];
%  markPoint_MA = unique(markPoint_MA,'rows');
%  markPoint_MA = sortrows(markPoint_MA,1);
%  windowMeanPoint_MA = coherentPro(LIMA,markPoint_MA,ROI_Imsc,initalSeeds_MA,iter_MA);
 %% %��LI��MA��ͬһ��ͼ����ʾ����
% showLIMA (ROI_Im_1,windowMeanPoint_LI, windowMeanPoint_MA);
%%  LI��ǿ
enhanced_ROI = delaysum( ROI_Im_1,windowMeanPoint_LI );
IMAGE_1 = Im_1(1:(hmin-1),:);%��������ԭʼͼ������ʾ��ǿ���LIЧ��
IMAGE_2 = Im_1((hmax+1):end,:);
IMAGE = [IMAGE_1;enhanced_ROI;IMAGE_2];
RF2Bmode(IMAGE, 1);
title('Enhanced LI');
%% ����֡
 ROI_Im = Im(hmin:hmax,:,:);
 [point] = ANCtest(ROI_Im,windowMeanPoint_LI);





























