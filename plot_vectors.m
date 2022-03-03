function plot_vectors(I1,I2,X, Y, inliers_ind, CorrectIndex)


%   通过将算法去除误匹配的结果idx与ground truth的正确匹配对比，并且绘制出
%   匹配图像的特征点之间的运动向量场，其中蓝线表示真阳，红线表示假阳，绿线表示假阴



n = size(X,1);
tmp=zeros(1, n);
tmp(inliers_ind) = 1;
tmp(CorrectIndex) = tmp(CorrectIndex)+1;
VFCCorrect = find(tmp == 2);
TruePos = VFCCorrect;   %真阳
tmp=zeros(1, n);
tmp(inliers_ind) = 1;
tmp(CorrectIndex) = tmp(CorrectIndex)-1;
FalsePos = find(tmp == 1); %假阳
tmp=zeros(1, n);
tmp(CorrectIndex) = 1;
tmp(inliers_ind) = tmp(inliers_ind)-1;
FalseNeg = find(tmp == 1); %假阴
all = 1:size(X,1);

TrueNeg = setdiff(all,FalsePos);
TrueNeg = setdiff(TrueNeg,TruePos);
TrueNeg = setdiff(TrueNeg,FalseNeg); %真阴



k = 0;
siz = size(I1);
figure;


%画出向量场
quiver(X(FalseNeg, 1), siz(1)-X(FalseNeg, 2), (Y(FalseNeg, 1)-X(FalseNeg, 1)), (-Y(FalseNeg, 2)+X(FalseNeg, 2)), k, 'g','linewidth', 1), hold on
quiver(X(FalsePos, 1), siz(1)-X(FalsePos, 2), (Y(FalsePos, 1)-X(FalsePos, 1)), (-Y(FalsePos, 2)+X(FalsePos, 2)), k, 'r','linewidth', 1), hold on
quiver(X(TrueNeg, 1), siz(1)-X(TrueNeg, 2), (Y(TrueNeg, 1)-X(TrueNeg, 1)), (-Y(TrueNeg, 2)+X(TrueNeg, 2)), k, 'k','linewidth', 1), hold on
quiver(X(TruePos, 1), siz(1)-X(TruePos, 2), (Y(TruePos, 1)-X(TruePos, 1)), (-Y(TruePos, 2)+X(TruePos, 2)), k, 'b','linewidth', 1), hold on


   set(gca,'XTick',0:siz(2)/20:siz(2));
   set(gca,'YTick',0:siz(1)/20:siz(1));

   set(gca,'xticklabel',[]) ;
   set(gca,'yticklabel',[]) ;

   grid on

axis equal
axis([0 siz(2) 0 siz(1)]);





