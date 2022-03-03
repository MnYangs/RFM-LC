function [mainV]=getMainV_filter_Gaussian(meanV,kernel,ncVec_Grid,nc)   
%ͨ����˹�˾�������ȡ�����˶�����mainV

temp0 = logical(ncVec_Grid);% ���˶������������Ӧλ������Ϊ1��û�е�����Ϊ0
%����logical�����ǰ���ֵ����߼�ֵ��logical(x)����x�еķ�0��ֵ���1��
%�����е���ֵ0ֵ����߼�0 


%% ��ÿ��������и�˹�˾���˲�
temp00 = imfilter(double(temp0).*ncVec_Grid, kernel);
nk = size(kernel,1);
CT= floor(nk./2)+1;
temp00 = temp00- temp0.*kernel(CT,CT);
temp1 = repmat(temp00 , [1,1,2]); % ����Ȩ�ز���
mainV = imfilter(meanV .* repmat(ncVec_Grid, [1,1,2]), kernel); 
%�Ծ��������и�˹�˲�


%% ������һ������Ӱ��
mainV = mainV-meanV.*kernel(CT,CT);

%% ÿ���������������������Ȩ�ز���
temp = logical(temp1);
mainV(temp) = mainV(temp) ./ temp1(temp); % ��ÿ�������������������Ȩ�ز���

%% ������ЩȨ��Ϊ0������ֱ�Ӷ���������˶�����Ϊ0����
temp2 = zeros(nc, nc, 2)-0;
mainV(~temp) = temp2(~temp);




