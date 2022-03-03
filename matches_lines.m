function [FP,FN] = matches_lines(I1, I2, X, Y, idx, CorrectIndex)

%   通过将算法去除误匹配的结果idx与ground truth的正确匹配对比，并且绘制出
%   图像匹配特征点的连线，其中蓝线表示真阳，红线表示假阳，绿线表示假阴
%   为了便于观察，在所有匹配中选取NUMPLOT个匹配进行显示

% 输入:
%   I1, I2: 两个输入的需要匹配的图像.
%
%   X, Y: 分别表示两幅图像的特征点坐标集
%
%   idx: 通过我们的算法筛选出的匹配的索引.
%
%   CorrectIndex: 正确匹配的索引.

% NumPlot可以控制显示的匹配的数目

NumPlot = 100;
n = size(X,1);
tmp=zeros(1, n);
tmp(idx) = 1;
tmp(CorrectIndex) = tmp(CorrectIndex)+1;
VFCCorrect = find(tmp == 2);
TruePos = VFCCorrect;   %真阳
tmp=zeros(1, n);
tmp(idx) = 1;
tmp(CorrectIndex) = tmp(CorrectIndex)-1;
FalsePos = find(tmp == 1); %假阳
tmp=zeros(1, n);
tmp(CorrectIndex) = 1;
tmp(idx) = tmp(idx)-1;
FalseNeg = find(tmp == 1); %假阴

FP = FalsePos;
FN = FalseNeg;

NumPos = length(TruePos)+length(FalsePos)+length(FalseNeg);
if NumPos > NumPlot
    t_p = length(TruePos)/NumPos;
    n1 = round(t_p*NumPlot);
    f_p = length(FalsePos)/NumPos;
    n2 = round(f_p*NumPlot);
    f_n = length(FalseNeg)/NumPos;
    n3 = round(f_n*NumPlot);
else
    n1 = length(TruePos);
    n2 = length(FalsePos);
    n3 = length(FalseNeg);
end

per = randperm(length(TruePos));
TruePos = TruePos(per(1:n1));
per = randperm(length(FalsePos));
FalsePos = FalsePos(per(1:n2));
per = randperm(length(FalseNeg));
FalseNeg = FalseNeg(per(1:n3));


interval = 20;
%用于三通道的rgb图像
if size(I1,3)==3
    WhiteInterval = 255*ones(size(I1,1), interval, 3);
    imagesc(cat(2, I1, WhiteInterval, I2)) ;
end

%用于灰度图像
if size(I1,3)==1
    WhiteInterval = 255*ones(size(I1,1), interval);
    imshow([I1, WhiteInterval, I2]) ;
end
hold on ;


line([X(TruePos,1)'; Y(TruePos,1)'+size(I1,2)+interval], [X(TruePos,2)' ;  Y(TruePos,2)'],'linewidth', 1, 'color','b' ) ;%[0,0.5,0.8]
line([X(FalseNeg,1)'; Y(FalseNeg,1)'+size(I1,2)+interval], [X(FalseNeg,2)' ;  Y(FalseNeg,2)'],'linewidth', 1, 'color', 'g') ;%'g'
line([X(FalsePos,1)'; Y(FalsePos,1)'+size(I1,2)+interval], [X(FalsePos,2)' ;  Y(FalsePos,2)'],'linewidth', 1, 'color','r') ;%  [0.8,0.1,0]

axis equal ;axis off  ; 
hold off
drawnow;