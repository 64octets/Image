%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ROI�����Զ�����㷨֮����֯�߽�֮�ϳ���Ϊlength_aver�����ص�ǿ��ֵƽ���ľ���
%% Inputs:  
%%     length_aver - ��ƽ�������ص�ĳ���
%%     output - �ڰ׶�ֵͼ��
%%     G - ԭʼͼ��
%%  Output:
%%     aver - ƽ��ǿ��ֵ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function aver = getIntensityMatrix( length_aver,output,G,rawIm)
framenum = 1;
Imout = RF2Bmode(rawIm, framenum);%��������ѹ��
sum50 = 0; 
[lengthy,lengthx] = size(output);
aver = zeros(lengthy,lengthx);
for x =1:lengthx
        for y = (length_aver+1): lengthy
           if output(y,x) == 255%ֻ������ɫ���ص㣬������ķ���ֵֵΪ-1
               sum50 = sum(Imout((y-length_aver):y,x));
               aver(y,x) = sum50/length_aver;
           else
               aver(y,x) = -1;
           end         
            sum50 = 0; 
           
        end
end

end


