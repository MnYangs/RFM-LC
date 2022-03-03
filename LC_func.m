function [inliers_ind,prob_inlier,runtime,mainV,nc]=LC_func(X,Y)

initialization;  %初始化vlfeat工具箱
%% parameters setting参数设置
lambda1   =0.4; 
neigh_num = 8;
    

tic;
%% 数据归一化处理
    Xt = X';Yt = Y'; 
    V=Y-X;
    X_norm=(mapminmax(X', 0.01, 0.99))';
    V_norm = (V)./ (max(abs((V)))+0.00001);%归一化
    X_V_norm = [X_norm,V_norm];

%% 自适应参数的设置
    [~,indi_Bin] = removeRepeat(X,Y);
    nc = min(max(round(sqrt(length(indi_Bin))),15),20);
    nk= round(nc./3)-1;
    
%% 高斯核卷积处理求取运动向量偏差
    kernel = GenerateKernel(nk,1);
    [grid_xy,meanV,numVec_Grid]=Grid_images(X_V_norm,nc,indi_Bin);
    
    mainV = getMainV_filter_Gaussian(meanV,kernel,numVec_Grid,nc);
    [Num_dev,Len_ratio_dev,Angle_dev]=get_MotionDev(V_norm,mainV,grid_xy);
    total_dev = (Num_dev+2-Len_ratio_dev-Angle_dev)/3;
    total_dev=total_dev'; 

%% 初步滤波       
    eta=0.3;  
    N = size(Xt,2);
    idx0=1:N;

    multi_K = [9,10,11];
    r_multiK=pre_filter(Xt,Yt,idx0,multi_K);             
    p0=(r_multiK>=eta.*ones(1,size(r_multiK,2)));        
    idx0 = find(p0==1); 

%%  量子化处理得到代价函数，并得到最终的内点集
    if length(idx0)>= neigh_num+4        
    [prob_inlier, quant_dev] = getLC_cost(Xt,Yt,idx0, lambda1, total_dev,neigh_num);
    end

    runtime=toc; 
   
    inliers_ind = find(prob_inlier == 1);    
end