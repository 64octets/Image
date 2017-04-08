%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ROI�㷨֮��ÿ������Ϊ255�ĵ�����domain������RF��ֵ��ƽ��
%% Inputs:  
%%      output           �� �ϴδ���õ��ĺڰױ߽�㼯ͼ��
%%      rawIm            -  RFԭʼ���ݾ���
%%      domain           -  ����ƽ���ķ�Χ
%% Outputs:  
%%      output           -  ���
%%      x                -  ����Ϊ255���������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [output,x] = findObjByRF(output,rawIm,domain)
    [lengthy,lengthx] = size(output);
    RFmeanMatrix = zeros(lengthy,lengthx);
    %domain = 15;
    counter = 0;
    for x =1:lengthx
            for y = 1: lengthy
                if  output(y,x) == 255
                    if( (y <= domain)) 
                        scanLine = rawIm(y:(y+domain),x);
                     
                    else if y >= (lengthy - domain)
                        scanLine = rawIm((y-domain):y,x);    
                        
                        else
                            scanLine = rawIm((y-domain):(y+domain),x);
                         end
                    end
                    
                    extrMaxIndex = find(diff(sign(diff(scanLine)))==-2)+1;%����ֵ
                    RFmaxMean = mean(scanLine(extrMaxIndex));%����ֵƽ��
                    extrMinIndex = find(diff(sign(diff(scanLine)))== 2)+1;%��Сֵ
                    RFminMean = mean(scanLine(extrMinIndex));%��Сֵƽ��
                    RFmean =  RFmaxMean - RFminMean;%����ֵ��ȥ��Сֵ
                    %RFmean =  RFmaxMean;
                    RFmeanMatrix(y,x) = RFmean;
                    counter = counter + 1;
                end
           
           end
    end
     for i =1:lengthx %��ͼ���Ϊȫ��
            for j = 1: lengthy
                output(j,i) =  0;
            end
     end
    value_1D = reshape(RFmeanMatrix,1,lengthx*lengthy);
    value_sort = sort(value_1D,'descend');
    value_turn = value_sort(2000);
    [x,y] = find(RFmeanMatrix >= value_turn);
     for i = 1:length(x)
        output( x(i),y(i)) = 255;%�Ҷ�ֵ��Ϊ255
    end
    figure;
    imagesc(output);colormap(gray);
    axis([0 lengthx 0 lengthy]); 
end