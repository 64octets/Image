%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ROI�����Զ�����㷨֮һ���õ�ԭʼrfͼ�񲢽��к���ROI��ȡ
%% 
%% Inputs:  
%%     rawIm - rfԭʼ����
%%     header - �ļ�ͷ
%%     framenum - ֡��
%%  Output:
%%     ROI����rf - ��ȡ������ROI����(uint8��)
%%     hmin,hmax - ROI����������ֵ��ֱ�Ӵ���ROI�ڽ���seeds�㷨��ʱ�����ڲ���double�����������˴���ROI�ı߽�����ֵ
%%     out - һ���м�����������ڵ���neighbor����ʱ����ʱ��ϳ�����������ʱ�����㣬���Խ��䵥������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function  [ROI_rf,hmin,hmax,out] = getrfimage(rawIm, header, framenum)

    %Imsc = sqrt(abs(hilbert(rawIm(:,:,framenum))));
    Imsc = RF2Bmode(rawIm, framenum);%��������ѹ��
    %figure;
    %imagesc(Imsc);
    %rfimtitle = sprintf('RF Raw Image %d',framenum);
    %title(rfimtitle);
    %colormap(gray);
    I = uint8(Imsc); %��double�͵�Imscת��Ϊuint8�͵�I����Ϊ��ֱ��ͼʱҪ��uint8�͵����ݼ���
    %G = rgb2gray(I);
    %Imsc = rgb2gray(I);
    %G = I;
    %Imsc = I;
    [lengthx lengthy] = size(rawIm);
    %%   ROI�Զ����
    [ROI_rf,hmin,hmax,out] = testostu(I,rawIm);
    %%   ��ԭʼrfͼ���ϻ���ROI��������
    figure;
    image(Imsc);
    %imagesc(Imsc);
    rfimtitle = sprintf('RF Raw Image %d',framenum);
    title(rfimtitle);
    colormap(gray(256));
    hold on;
    rectangle('position',[1,hmin,lengthy,(hmax-hmin)],'curvature',[0,0],'edgecolor','r');%rectangle('Position',[x,y,w,h]) �ӵ�x,y ��ʼ����һ�����Σ����Ϊw ����Ϊ h.
end



