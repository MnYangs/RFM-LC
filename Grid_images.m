function [grid_xy,meanV,numVec_Grid]=Grid_images(X_V_norm,nc,indi_Bin)
%用网格法将输入数据划分为nc^2的单元格
%X_V_norm中的每个元素的范围都是0到1
%输出网格位置矩阵grid_xy，用于判断特征点属于那个网格
%输出每个网格的平均运动向量meanV
%输出每个网格中运动向量的数目numVec_Grid

interval=1/nc;
grid_xy=floor(X_V_norm(:,1:2)./interval)+1;
meanV = zeros(nc, nc, 2);
density = zeros(nc, nc);

numVec_Grid = density;  

for i = 1:nc
    for j = 1:nc
        temp1 = (grid_xy(:,1) == i & grid_xy(:,2) == j & indi_Bin==1 );% 用来判断向量是否属于这个i，j单元，并挑选出来
        temp2 = sum(temp1);
        numVec_Grid(i, j) = temp2;%第i，j个单元中向量的数目
        if numVec_Grid(i, j) ~=0
        meanV(i, j, 1:2) = mean(X_V_norm(temp1,3:4),1);   %求出这些向量的平均值
         
        else 
            meanV(i, j, 1:2)=[0,0];
        end
    end
end


