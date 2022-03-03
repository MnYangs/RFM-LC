function [prob_inlier,quant_dev]=getLC_cost(Xt,Yt,idx0,lambda,total_dev,neigh_num)
%这个函数用于对运动总偏差进行量子化处理

if neigh_num<4
    Error(' K must not less than 4')
end

kdtreeX = vl_kdtreebuild(Xt( :, idx0 ));
kdtreeY = vl_kdtreebuild(Yt( :, idx0 ));
[neighborX, ~] = vl_kdtreequery(kdtreeX, Xt(:,idx0), Xt, 'NumNeighbors', neigh_num+3) ;
[neighborY, ~] = vl_kdtreequery(kdtreeY, Yt(:,idx0), Yt, 'NumNeighbors', neigh_num+3) ;
neighborX = idx0(neighborX);
neighborY = idx0(neighborY);

[~, L] = size(neighborX);
K=8;

neighborX = neighborX(2:K+1, :);   
neighborY = neighborY(2:K+1, :);
neighborIndex = [neighborX; neighborY];
index = sort(neighborIndex);
temp1 = diff(index);
temp2 = (temp1 == zeros(size(temp1, 1), size(temp1, 2)));
ni = sum(temp2);
c = K-ni;

%% 量子化处理
total_dev1 = total_dev(index);
total_dev2= repmat(total_dev,size(total_dev1,1),1);
quant_dev= total_dev2>= 0.8.*ones(size(total_dev1,1), size(total_dev1,2));
quant_dev = quant_dev(1:end-1, :).*temp2;
quant_dev = sum(quant_dev);

Cost = (c+quant_dev)/K;

prob_inlier = (Cost) <= lambda.*ones(1,L);%p表示为内点的概率



