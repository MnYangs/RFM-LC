function r_multiK=pre_filter(Xt,Yt,idx0,multi_K)
%该函数用于初步滤波

kdtreeX = vl_kdtreebuild(Xt);
kdtreeY = vl_kdtreebuild(Yt);
[neighborX, ~] = vl_kdtreequery(kdtreeX, Xt, Xt, 'NumNeighbors',15) ;
[neighborY, ~] = vl_kdtreequery(kdtreeY, Yt, Yt, 'NumNeighbors',15) ;
neighborX = idx0(neighborX);
neighborY = idx0(neighborY);

Rst = 0;
M=length(multi_K);

for Ki = multi_K
%% 提取多重邻域中的公共元素的数目
neighborX1 = neighborX(2:Ki+1, :);   
neighborY1 = neighborY(2:Ki+1, :);
neighborIndex = [neighborX1; neighborY1];
index = sort(neighborIndex);
temp1 = diff(index);
temp2 = (temp1 == zeros(size(temp1, 1), size(temp1, 2)));
num_com = sum(temp2); %领域中公共元素的个数

rst = num_com;
Rst = Rst+ (rst)/Ki;%

end
r_multiK=Rst./M;

end