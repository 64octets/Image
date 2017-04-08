%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ROI�����Զ�����㷨֮���ڶ�߽����ҳ�Ŀ��߽磬���������߽�
%% Inputs:  
%%     out - �ڰ׻���ɫͼ��
%%     Imsc   - rf��hilbert�任�õ���ͼ��
%%     rawIm  - ԭʼrf����
%%  Output:
%%     ROI - ��ȡ����Ŀ��ROI
%%     hmin,hmax - ROI�����±߽�����ֵ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ROI,hmin,hmax] = findObj( out ,Imsc,rawIm)
output = out;
[lengthy,lengthx] = size(output);
 %% ����ÿ�����أ�����ɫ���ص�ת��Ϊ��ɫ������ͼ���Ϊ�ڰ׶�ֵͼ�񣬲�ͳ�ư�ɫ255���ص����
    length255 = 0;%�Ҷ�ֵΪ255���ص�ĸ���
    for x =1:lengthx
            for y = 1: lengthy
               if output(y,x) == 100
                   output(y,x) = 0;
              end
                if  output(y,x) == 255
                    length255 = length255 + 1;
                end

           end
    end
    length255
    figure;
    imagesc(output);colormap(gray);
    axis([0 lengthx 0 lengthy]);
    %%  ����RF������СĿ������ķ�Χ
    domain = 20;
    [output,n] = findObjByRF(output,rawIm,domain);
    %%  Ϊ�˴��ڶ�߽����ҳ�������Զ�˱߽磬���ݾ���������ѧ�ṹ��ԭʼͼ���У�G����������Զ�˱߽��Ϸ�����С��ǿ��ֵ��intensity��
    length_aver =250;%��255�����ص��Ϸ���ƽ�������ص㳤��
    aver = getIntensityMatrix(length_aver,output,Imsc,rawIm);



    %%  �ҳ��������߽���
    length =round(size(n,1)*0.1);%��ʾ���س���Ϊ2900�����õ�Խ��˵����ʾ�İ�ɫ������Խ��
    [output,n] = getMinIntensity(aver,length);
    figure;
    imagesc(output);colormap(gray);
    axis([0 lengthx 0 lengthy]); 
%     [output,n] = findObjByRF(output, rawIm);
    %%  ȷ��ROI�ĸ߶ȣ�����ԭʼBͼ�ĻҶ�ͼ���ҵ�ROI����ȵ���ԭʼͼ����
     a = n - mean(n);%3sigemaԭ��ȥ���ӵ�
     b = 1 * std(n);
     index = find(a > b | a<(-b));
     n(index) = [];
     a = [];
     b = [];
     index = [];
     a = n - mean(n);%3sigemaԭ��ȥ���ӵ�
     b = 1 * std(n);
     index = find(a > b | a<(-b));
     n(index) = [];
     
     max_y = max(n);
     min_y = min(n);
     h = (max_y-min_y);
     hmin = min_y-7*h;
     hmax = max_y+7*h;
     if hmin <= 1
         hmin = 1;
     end
     if hmax >= size(Imsc,1)
         hmax = size(Imsc,1);
     end

     ROI = Imsc(hmin:hmax,:);
     %imshow���Խ�ROI��ʾ�������Ҷ����������ǿ�߱Ⱥ㶨�����ܵ��ڳɾ�����״
     %figure;
     %imshow(ROI);
     %image��imagescһ����Ҫ����corlormap�����ǲ�ͬ����image�õ���ROIͼ��������ף���imagesc����
     %figure;
     %image(ROI);
     %colormap(gray);
     figure;
     imagesc(ROI);
     colormap(gray);%imagesc�õ���ͼ����״��Щʧ�棬����ͨ������figure�Ĵ��ڴ�С�ı�ROI��״

end



