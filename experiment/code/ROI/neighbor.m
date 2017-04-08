%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ROI�㷨֮���������ص��n x n ����,ͳ�Ƹ������ڻҶ�ֵΪ255��0�����ص������
%% ���������������ص���100�Ҷ�ֵ����0�Ҷ�ֵ
%% Inputs:  
%%      n                - n x n����
%%      lengthx,lengthy  - ԭͼ��ߴ�
%%      output           �� ԭͼ��
%% Outputs:  
%%      output - ����������ͼ�񣬺ڰ׻���ɫ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function output = neighbor( n ,lengthy,lengthx,output)
b1 = 0;
b2 = 0;
for x =(n+1):(lengthx-n)
        for y = (n+1): (lengthy-n)
            output(y,x);%�������ص�
            for i = (x-n):(x+n)
                for j = (y-n):(y+n)
                    b1 = b1 + ROIfb(output(j,i),255);
                    b2 = b2 + ROIfb(output(j,i),0);
                end
            end
            if (b1 - b2)>12%Ϊ��ʹ�ñ�Ե��Ҷ�ֵΪ255�������趨һ����Χ
                output(y,x) = 100;
             end
            if (b1 - b2)<-22
                output(y,x) = 0;           
            end
            b1 =0;
            b2 = 0;
        end
       end
end


