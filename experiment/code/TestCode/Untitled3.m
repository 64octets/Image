% figure;
%  [Im,header] = RPread('avib8.b8');%avirf.rf����out of memory
%  for i = 1: size(Im, 3)
%        
%     image(Im(:,:,i));
%     colormap(gray(256));
%     axis('image');
%     
%     drawnow;
%     title(i);
%     
%     pause(0.05);
%  end
% % figure;
% %rf = Im(:,1);
% %plot(rf);
% RPviewrf(Im, header, 1);
% 
% 
% 
% 
% function [output,n] = getMinIntensity(aver,length)
%     [lengthx,lengthy] = size(aver);
%     aver1 = aver';%ת�õ�Ŀ���ǰ���
%     b1 = reshape(aver1,1,[]);%�����Ϊ������������
%     c1 = find(b1>0,length*2);%�ҳ�b1�е�ǰlength*2������������ֵ
%     c2 = b1(c1);%ʵ��ֵ
%     c3 = sort(c2,'ascend');%�����Ի����Сֵ
%    % c4 = find(c3>min(c3),length);
%     %c5 = c3(c4);
%     b2 = find(b1>min(c3),length);%����ֵ
%     b3 = b1(b2);%ʵ��ֵ
%     b4 = sort(b3,'ascend');%����
%     c = b2;
%     m = zeros(1,length);
%     n = zeros(1,length);
%     for x =1:lengthx %��ͼ���Ϊȫ��
%             for y = 1: lengthy
%                 output(x,y) =  0;
%             end
%     end
%     
%     for i = 1:length
%         if rem(c(i),lengthy) == 0
%             n(i) = floor(c(i)/lengthy);
%             m(i) = lengthy;
%         else
%             if (c(i)/lengthy) <  lengthx
%                 n(i) = floor(c(i)/lengthy+1);%ȡ��������
%                 m(i) = rem(c(i),lengthy);%ȡ����������
%             else
%                 n(i) = floor(c(i)/lengthy);%ȡ��������
%                 m(i) = rem(c(i),lengthy);%ȡ����������
%             end
%         end
%         output(n(i),m(i)) = 255;%�Ҷ�ֵ��Ϊ255
%     end
%     
%    
% 
% end





figure,
 axis on
 hold on
for index = 1:size(windowMeanPoint_MA,1) 
    distension_index = point(index,:,:);
    distension = [];
     for i = 1:size(ROI_Im,3)
         distension = [distension;distension_index(:,:,i)];
     end
      
      distension_y = distension(2:end,2)-distension(2,2);%%%%%%%%%%%������ĸ��㣿��������ĩ����һ֡��ô�ҵ�
      x = 1:(length(distension)-0);
      plot(x,distension(:,2));
end