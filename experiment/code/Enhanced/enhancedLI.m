%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LI ����ǿ(XXXXXXX)
%% Inputs:  
%%      ROI_Imsc               - ����Ȥ����
%%      windowMeanPoint_LI     - LI�ϵĵ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function  enhancedLI( ROI_Imsc,windowMeanPoint_LI )
for in = 1:length(windowMeanPoint_LI)
     p = windowMeanPoint_LI(in,:);
     x = p(:,1);
     y = p(:,2);
     ROI_Imsc(((round(y)-1):round(y)),round(x)) = 130;%֮���Խ�����Χ������Ϊ�߽�����Ϊ�ý����ʾ�ø�����һЩ
end
figure;
imagesc(ROI_Imsc);
title('enhanced LI profile');
colormap(gray);

end

