function [idxUnique,indi_Bin] = removeRepeat(X,Y)
%�����������ȥ����ʼƥ�伯���ظ���Ԫ��
CC = UniqueSearch(X);
EE = UniqueSearch(Y);
indi_Bin = (CC&EE);% �õ�������ָʾ�������Ϊ1��˵�����ظ���Ϊ0��Ϊ�ظ���
idxUnique=find(indi_Bin==1);%�ҵ����ظ���Ԫ�ص����

function indNew = UniqueSearch(X)
ind0 = false(size(X,1),1);%FALSE(M,N)����NxM�߼���ľ���
[aa,bb] = sortrows(X,1);%���յ�һ���������У���������ظ����֣����յڶ����������У��������ƣ�ͬһ�еĸ����ƶ���
%Y�������ľ���I ����������֮ǰ�����е��б�
cc0=logical(sum(abs(diff(aa)),2));%logical�����ǰ���ֵ����߼�ֵ,logical(x)����x�еķ�0��ֵ ���1,�����е���ֵ0ֵ����߼�0 
%����diff���������һ���ߴ粻����1��X������Ԫ��֮��Ĳ�ֵ:Y = diff(X)��Y = [X(2)-X(1) X(3)-X(2) ... X(m)-X(m-1)]
%sum(X,2)��ʾ���ÿһ�еĺ�
cc1 = [true;cc0];
cc2 = [cc0;true];
idx=cc1&cc2;
ind0(bb(idx))= true;
indNew=ind0;%�ҵ�����ͬ��Ԫ�ص�����