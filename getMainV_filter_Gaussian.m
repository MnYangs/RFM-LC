function [mainV]=getMainV_filter_Gaussian(meanV,kernel,ncVec_Grid,nc)   
%通过高斯核卷积处理获取估计运动向量mainV

temp0 = logical(ncVec_Grid);% 有运动向量的网格对应位置设置为1，没有的设置为0
%函数logical函数是把数值变成逻辑值，logical(x)将把x中的非0的值变成1，
%把所有的数值0值变成逻辑0 


%% 对每个网格进行高斯核卷积滤波
temp00 = imfilter(double(temp0).*ncVec_Grid, kernel);
nk = size(kernel,1);
CT= floor(nk./2)+1;
temp00 = temp00- temp0.*kernel(CT,CT);
temp1 = repmat(temp00 , [1,1,2]); % 用作权重补偿
mainV = imfilter(meanV .* repmat(ncVec_Grid, [1,1,2]), kernel); 
%对距离矩阵进行高斯滤波


%% 消除单一样本的影响
mainV = mainV-meanV.*kernel(CT,CT);

%% 每个含有主向量的网格进行权重补偿
temp = logical(temp1);
mainV(temp) = mainV(temp) ./ temp1(temp); % 对每个含有主向量网格进行权重补偿

%% 对于那些权重为0的网格，直接定义其估计运动向量为0向量
temp2 = zeros(nc, nc, 2)-0;
mainV(~temp) = temp2(~temp);




