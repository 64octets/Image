%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ROI�����Զ�����㷨
%% 
%%
%% Inputs:  
%%     I     - unit���͵�B-ͼ
%%     rawIm - ԭʼrf����
%%  Output:
%%     ROI - ��ȡ������ROI����
%%     hmin,hmax - ROI����������ֵ��ֱ�Ӵ���ROI�ڽ���seeds�㷨��ʱ�����ڲ���double�����������˴���ROI�ı߽�����ֵ
%%     out - һ���м�����������ڵ���neighbor����ʱ����ʱ��ϳ�����������ʱ�����㣬���Խ��䵥������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ROI,hmin,hmax,out] = testostu(I,rawIm)
    %% ����׼����ԭʼBͼ���Ҷ�ͼ
    [A B C] = size(I);%���ж��ǲ��ǻҶ�ͼ
    if C ~= 1
        G = rgb2gray(I);
        Imsc = G;
    else
        Imsc = I;
        G = I;
    end
    %% ostu����Ӧ��ֵ��ֵ��
    [counts x] = imhist(Imsc);
    [m n] = size(Imsc);  
    level = otsu(counts, m*n);  
    output =Imsc;  
    output(output<level) = 0;  
    output(output>=level) = 255;  
    [lengthy,lengthx] = size(output);
    figure;
    subplot(121),imagesc(Imsc);colormap(gray);
    axis([0 lengthx 0 lengthy]); 
    subplot(122),imagesc(output);colormap(gray);
    axis([0 lengthx 0 lengthy]); 

    %% �����򲢽�ͼ��ת��Ϊ�ڻҰ���ɫ
    output = neighbor( 5,lengthy,lengthx,output);%����ʱ�䳤������ʱ����15�Ĵ�С�йأ�����ʱ������31 x 31
    figure;
    imagesc(output);colormap(gray);
    out = output;
    %% ���ڶ�߽��з����������Զ�˱߽�  
    [ROI,hmin,hmax] = findObj( out ,G,rawIm);
    
end

