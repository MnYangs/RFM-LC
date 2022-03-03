function [idxUnique,indi_Bin] = removeRepeat(X,Y)
%这个函数用于去除初始匹配集中重复的元素
CC = UniqueSearch(X);
EE = UniqueSearch(Y);
indi_Bin = (CC&EE);% 得到二进制指示矩阵，如果为1则说明不重复，为0则为重复的
idxUnique=find(indi_Bin==1);%找到不重复的元素的序号

function indNew = UniqueSearch(X)
ind0 = false(size(X,1),1);%FALSE(M,N)，是NxM逻辑零的矩阵
[aa,bb] = sortrows(X,1);%按照第一列升序排列，如果遇到重复数字，则按照第二列升序排列，依次类推（同一行的跟着移动）
%Y是排序后的矩阵，I 排序后的行在之前矩阵中的行标
cc0=logical(sum(abs(diff(aa)),2));%logical函数是把数值变成逻辑值,logical(x)将把x中的非0的值 变成1,把所有的数值0值变成逻辑0 
%函数diff计算数组第一个尺寸不等于1的X的相邻元素之间的差值:Y = diff(X)：Y = [X(2)-X(1) X(3)-X(2) ... X(m)-X(m-1)]
%sum(X,2)表示求出每一行的和
cc1 = [true;cc0];
cc2 = [cc0;true];
idx=cc1&cc2;
ind0(bb(idx))= true;
indNew=ind0;%找到不相同的元素的索引