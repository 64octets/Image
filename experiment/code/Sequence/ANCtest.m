%==============================================
%%  �����ϵ��
%% ���������
%%     ROI_Im       -    ����Ȥ����
%%     windowMeanPoint_MA     -   �ϳ������ĵ�
%% ���������
%%     point         -   ����windowMeanPoint_MA��49֡��ƥ��ĵ�
%% ==============================================
function [point] = ANCtest(ROI_Im,windowMeanPoint_MA)
interval_1 = 20;%7 x7
interval_2 = 30;%11 x 11
% ROI_Im =  ROI_Im(:,:,2:end);
framenum = 1;
Im_framenum1 = ROI_Im(:,:,framenum);%ǰһ֡
windowMeanPoint_MA(:,3)=[];
point(:,:,1) = windowMeanPoint_MA;%��һ֡�ĵ�

for framenum = 2:size(ROI_Im,3)%��һ֡��
    Im_framenum2 = ROI_Im(:,:,framenum);%��һ֡
    for index = 1:size(windowMeanPoint_MA,1)   %��һ���㣿
         p = windowMeanPoint_MA(index,:);
         x_double = p(:,1);%�����꣬��ʾ����ɨ����
         y_double = p(:,2);%�����꣬��ʾ�ĸ�������
         x = round(p(:,1));%������
         y = round(p(:,2));%������
         if ((size(ROI_Im,2)-x) > interval_1)%����ƥ�䴰û�г����߽�
             window_1 = Im_framenum1((y-interval_1):(y+interval_1),(x-interval_1):(x+interval_1));
             mean_1 = mean(mean(window_1));
             siegema_1 = sqrt(sum(sum((window_1 - mean_1).^2)));
         else                                %�����߽�
             zero_w1 = interval_1 - (size(ROI_Im,2)-x);
             zero_domain1 = zeros((interval_1*2+1),zero_w1);
             window_1 = Im_framenum1((y-interval_1):(y+interval_1),(x-interval_1):end);
             window_1 = [window_1,zero_domain1];
             mean_1 = mean(mean(window_1));
             siegema_1 = sqrt(sum(sum((window_1 - mean_1).^2)));
         end
         
         %��һ֡
         i = 1;
         space = 0.5;
         for m = (x_double-(interval_2-interval_1)):space:(x_double+(interval_2-interval_1))
             for n = ( y_double-(interval_2-interval_1)):space:( y_double+(interval_2-interval_1))
                m_integer = round(m)
                n_integer = round(n)
                if ((size(ROI_Im,2)-m_integer) >= interval_1)
%                     window_2 = Im_framenum2(round(n-interval_1):round(n+interval_1),round(m-interval_1):round(m+interval_1));
                    window_2 = Im_framenum2((round(n)-interval_1):(round(n)+interval_1),(round(m)-interval_1):(round(m)+interval_1));
                    mean_2 = mean(mean(window_2 ));
                    siegema_2 = sqrt(sum(sum((window_2-mean_2).^2 )));
                else
                    zero_w2 = interval_1 - (size(ROI_Im,2) - m_integer);
                    zero_domain2 = zeros((interval_1*2+1),zero_w2);
                    window_2 = Im_framenum2((round(n)-interval_1):(round(n)+interval_1),(round(m)-interval_1):end);
                    window_2 = [window_2,zero_domain2];
                    mean_2 = mean(mean(window_2 ));
                    siegema_2 = sqrt(sum(sum((window_2-mean_2).^2 )));
                end
                
                window_1 = window_1 - mean_1;
                window_2 = window_2 - mean_2;
                ANC(index,i) = sum(sum((window_1.*window_2)/(siegema_1*siegema_2)));
                i = i + 1
             end
         end
         
    end
    
    %[max_ANC,index_ANC] = max(ANC,[],2);%ÿ�е����ֵ��max_ANC�����ֵ��index_ANC�����ֵ��ÿ��������λ��
    
%     figure,
    for i = 1:size(ANC,1)
        ANCD = ANC(i,:);
        ANCD = (double(reshape(ANCD,sqrt(size(ANCD,2)),sqrt(size(ANCD,2)))))';
%         ma = (x_double-(interval_2)):space:(x_double+(interval_2));
%         na = ( y_double-(interval_2)):space:( y_double+(interval_2));
%         mesh(ma,na,ANCD);
%         pause(0.05);
         p = windowMeanPoint_MA(i,:);
         x_double = p(:,1);%�����꣬��ʾ����ɨ����
         y_double = p(:,2);%�����꣬��ʾ�ĸ�������
        close all,
        [xx,yy] = find(ANCD == max(max(ANCD)))%��xx�е�yy��
        point(i,1,framenum) = x_double-(interval_2-interval_1)+(xx(1,1)-1)*space;                  
        point(i,2,framenum) = y_double-(interval_2-interval_1)+yy(1,1)*space;
             
     end
    
    %���m��n�����˼���
%     clear iter;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
%     for i = 1:length(index_ANC)
% %          iter(i,1) = fix(index_ANC(i,1)/(sqrt(size(ANC,2))));
% %          iter(i,2) = mod(index_ANC(i,1),(sqrt(size(ANC,2))));
%         ANCD = ANC(1,:);
%         ANCD = reshape(ANCD,81,81);
%         ma = (x_double-(interval_2-interval_1)):space:(x_double+(interval_2-interval_1));
%         na = ( y_double-(interval_2-interval_1)):space:( y_double+(interval_2-interval_1));
%         
% 
%     end
%     %��m��n�����Ĵ�������������
%     for index = 1:length(windowMeanPoint_MA)
%          p = windowMeanPoint_MA(index,:);
%          x_double = p(:,1);%������
%          y_double = p(:,2);%������
%          point(index,1,framenum) = x_double-(interval_2-interval_1)+iter(index,1)*space;
%          if (iter(index,2) == 0)
%              point(index,2,framenum) = y_double+(interval_2-interval_1);
%          else
%             point(index,2,framenum) = y_double-(interval_2-interval_1)+(iter(index,2) - 1)*space;
%          end
%     end
   
    Im_framenum1 = Im_framenum2;%��һ�ε�����ǰһ֡
    
 end
 %ÿ�������������᷽����λ�Ƶ�����(�����꣺֡�������꣺���ص�)
 test;
 
%  figure,
%  axis on
%  hold on
% for index = 1:size(point,1) %��һ���㣿
%     distension_index = point(index,:,:);
%     distension = [];
%      for i = 1:size(ROI_Im,3)            %������һ֡��
%          distension = [distension;distension_index(:,:,i)];
%      end
%       
%       distension_y = distension(2:end,2)-distension(1,2);%%%%%%%%%%%������ĸ��㣿��������ĩ����һ֡��ô�ҵ���
%       x = 0:(length(distension_y)-1);
%       plot(x,distension_y);
% end
end





