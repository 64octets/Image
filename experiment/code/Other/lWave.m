%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% С���任����ź�ͻ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rfLine = (Im_1(:,100))';
% rfLine = rfLine(1000:1500);
figure,
plot(rfLine);
xlabel('time');ylabel('amp');
title('RF scanline signal');
figure,
[d,a] = wavedec(rfLine,5,'db6');
% [c,l] = wavedec(rfLine,5,'db6');
% cfd = zeros(5,2080);
% for k = 1:5
%     d = detcoef(c,l,k);
%     d = d(ones(l,2^k),:);
%     cfd(k,:) = wkeep(d(:)',2080);
% end
% cfd = cfd(:);
% I=find(abs(cfd)<sqrt(eps));
% cfd(I)=zeros(size(I));
% cfd=reshape(cfd,5,2080);
% colormap(pink(64));
% img=image(flipud(wcodemat(cfd,64,'row')));
% set(get(img,'parent'),'YtickLabel',[]);
% title('��ɢС���任��ϵ���ľ���ֵ')
% ylabel('����'); 
% figure(3)  
% ccfs=cwt(rfLine,1:32,'haar','plot'); 
% title('����С���任ϵ���ľ���ֵ') 
% colormap(pink(64)); ylabel('�߶�')  
% xlabel('ʱ��(���߿ռ�)')


a3=wrcoef('a',d,a,'db5',3); 
d3=wrcoef('d',d,a,'db5',3); 
d2=wrcoef('d',d,a,'db5',2); 
d1=wrcoef('d',d,a,'db5',1); 
subplot(411);plot(a3);ylabel('�����ź�a3'); 
title('С���ֽ��ʾ��ͼ'); 
subplot(412);plot(d3);ylabel('ϸ���ź�'); 
subplot(413);plot(d2);ylabel('ϸ���ź�'); 
subplot(414);plot(d1);ylabel('ϸ���ź�'); 
xlabel('�ź�');
figure,plot(a3);ylabel('��������ź�a3');