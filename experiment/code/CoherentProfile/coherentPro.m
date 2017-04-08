%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% �����ĺϳ�
%% 
%% Inputs:  
%%     markPoint         -   �������ӵ����ɵı߽��
%%     ROI_Imsc          -   ROI����������ͼ
%%     LIMA              -   ��־λ�����ڼ���������LI����MA 
%%     initalSeeds_LI    -   ��ʼ���ӵ�����꣬�������ϳɵ�ʱ������ɾ����Щ����߽�Զ�Ļ����ӵ�
%%     iter_LI           -   ���ӵ�ĵ�������
%% Outputs:  
%%     windowMeanPoint   -   �����ϳɺ�ı߽��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function windowMeanPoint = coherentPro(LIMA,markPoint,ROI_Imsc,initalSeeds_LI,iter_LI)
c = 340;s = .001;Fs = 40000000;
 if LIMA == 0
       interval =s*Fs/(10*c);%����interval��������ӵ����Ѱ��Χ�йأ�����Խ��������ӵ����ֹ����õĳ�ʼ���ӵ��ϵԽ�������Ҫ��ѰMA��ɽ��ò������õô�һЩ�������ó�2*s*Fs/c
    else if LIMA == 1
       interval = s*Fs/(5*c);   
        end
 end
iterThreshold = 5;
iterLessThan10 = find(iter_LI < iterThreshold);%��������С��5��
if size(iterLessThan10,1) > 1
    for i = 1:size(iterLessThan10,1)
        deleteIndex = find(markPoint(:,3) == iterLessThan10(i,:));
        markPoint(deleteIndex',:,:) = [];
    end
end

seedsPoint_y = initalSeeds_LI(:,2);%��ʼ���ӵ�Զ��Ŀ��߽� 
seedsPointMean_y = mean(seedsPoint_y);
seedsPointDiff = seedsPoint_y - seedsPointMean_y;
seedsPointSiegema = std(seedsPoint_y);
deleteIndex = [];
farFromObject = find((seedsPointDiff > seedsPointSiegema) | (seedsPointDiff < -(seedsPointSiegema)));
if size(farFromObject,1) > 1
    for i = 1:size(farFromObject,1)
        deleteIndex = find(markPoint(:,3) == farFromObject(i,:));
        markPoint(deleteIndex',:,:) = [];%�޳����᷽����ƫ���ĵ�
    end
end

 

windowMeanPoint = [];
for in = 1:length(markPoint)
     p = markPoint(in,:);
     x = p(:,1);
     y = p(:,2);
     
     windowPoint_index = find((markPoint(:,1)>=(x-interval)) & (markPoint(:,1)<=(x+interval)) &(markPoint(:,2)>=(y-interval)) & (markPoint(:,2)<=(y+interval)));
     %�������ĳߴ������պϳ��������ܶ��й�ϵ���ߴ��С����ȥ��һЩ��������ĵ㣬�ر������᷽�����ײ���һ��ɨ�����ж���߽������
     
     windowPoint = markPoint(windowPoint_index,:);
     [r,c] = size(windowPoint);
     if r == 1
         windowMeanPoint = [windowMeanPoint;windowPoint];
     else
         windowMeanPoint = [windowMeanPoint;mean(windowPoint)];
     end 
     
 end
windowMeanPoint = unique(windowMeanPoint,'rows');




figure;
image(ROI_Imsc);
if LIMA == 0
       title('coherent LI profile');
    else if LIMA == 1
       title('coherent MA profile'); 
        end
end

colormap(gray(256));
axis on
hold on
for in = 1:(size(windowMeanPoint,1)-1)
     p1 = windowMeanPoint(in,:);
     p2 = windowMeanPoint((in+1),:);
     x = p1(:,1);
     y = p1(:,2);
     if LIMA == 0
        plot([p1(1,1),p2(1,1)],[p1(1,2),p2(1,2)],'r.');
%         plot(x,y,'y-');
        else if LIMA == 1
              plot([p1(1,1),p2(1,1)],[p1(1,2),p2(1,2)],'r.');                  
%              plot(x,y,'r-');  
        end
     end
      
end
end
