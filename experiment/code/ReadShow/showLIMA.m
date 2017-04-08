%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ��LI��MA��ͬһ��ͼ����ʾ����
%% Inputs:  
%%      ROI_Imsc                -   ����Ȥ����
%%      windowMeanPoint_LI      -   LI�ϵĵ�
%%      windowMeanPoint_MA      ��  MA�ϵĵ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function showLIMA (ROI_Im_1,windowMeanPoint_LI, windowMeanPoint_MA)
ROI_Imsc = RF2Bmode(ROI_Im_1, 1);%��������ѹ��
%figure;
%ROI_Imsc = sqrt(abs(hilbert(ROI_Im_1)));
%imagesc(ROI_Imsc);
title('coherent profile');
colormap(gray);
axis on
hold on
if size(windowMeanPoint_MA,1) ~=0
    windowMeanPoint_MA = sortrows(windowMeanPoint_MA,1);
end
windowMeanPoint_LI = sortrows(windowMeanPoint_LI,1);
for in = 1:(size(windowMeanPoint_LI,1) -1)
     p1 = windowMeanPoint_LI(in,:);%�������ߵķ���
     p2 = windowMeanPoint_LI((in+1),:);
     plot([p1(1,1),p2(1,1)],[p1(1,2),p2(1,2)],'y');
%      x = p1(:,1);% ���㷽��
%      y = p1(:,2);
%     plot(x,y,'y--');
end
for in = 1:(size(windowMeanPoint_MA,1) - 1)
     p1 = windowMeanPoint_MA(in,:);
     p2 = windowMeanPoint_MA((in+1),:);
     plot([p1(1,1),p2(1,1)],[p1(1,2),p2(1,2)],'r');
%      x = p1(:,1);
%      y = p1(:,2);
%     plot(x,y,'r--');
end


end

