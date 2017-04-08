%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ROI�����Զ�����㷨֮��ǿ��ƽ��ֵ���������
%% Inputs:  
%%     aver - ǿ��ƽ��ֵ����
%%     length - ��Ҫ��ʾ���������ǰlength�����ص�
%%  Output:
%%     output - �����ֵͼ�񣬾������߽�Ϊ��ɫ����������Ϊ��ɫ
%%     n      - Ŀ�����ص�����������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [output,n] = getMinIntensity(aver,length)
    [lengthx,lengthy] = size(aver);
    for x =1:lengthx %��ͼ���Ϊȫ��
            for y = 1: lengthy
                output(x,y) =  0;
            end
    end
    
    [index_x,index_y] = find(aver ~= 0 & aver ~= -1);%�ҳ�b1�е�ǰlength*2������������ֵ
    value = [];
    for i = 1:size(index_x,1)
        value(i) = aver(index_x(i),index_y(i));%ʵ��ֵ
    end
     value_sort = sort(value,'ascend');
     value_turn = value_sort(length);
     value_index = find(value < value_turn);
    x = [];
    y = [];
    for i = 1:size(value_index,2)
        x(i) = index_x(value_index(i));
        y(i) = index_y(value_index(i));
        output( x(i),y(i)) = 255;%�Ҷ�ֵ��Ϊ255
    end
    n = x;
    
    
%     value_sort = sort(value,'ascend');%�����Ի����Сֵ
%     value_sort = value_sort(1:length);
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
 
    
   

end

