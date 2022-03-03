function [Num_dev,Len_ratio_dev,Angle_dev]=get_MotionDev(V_norm,mainV,grid_xy)
%这个函数用来计算运动向量偏差，包含数值误差、长度比误差和角度误差
for i = 1:size(V_norm,1)
    
    dv=0.0000001;
    
    temp_V = V_norm(i, :)+dv;     
    temp_mainV = permute( mainV(grid_xy(i, 1), grid_xy(i,2), :), [3 2 1] )';
    
%%  求取运动向量数值偏差
    tmp_num = (temp_V-temp_mainV)*(temp_V-temp_mainV)';
    Num_dev(i,:) = 1-exp(-tmp_num./0.08);%归一化处理

%%  求取运动向量长度偏差    
    tmp_len=min(sqrt(temp_V(1)^2+temp_V(2)^2),sqrt(temp_mainV(1)^2+temp_mainV(2)^2))/max(sqrt(temp_V(1)^2+temp_V(2)^2),sqrt(temp_mainV(1)^2+temp_mainV(2)^2));  
    Len_ratio_dev(i,:)= gaussmf(tmp_len,[0.4,1]);

%%  求取运动向量角度偏差   
    tmp_angle=acos((temp_V*temp_mainV')/(sqrt(temp_V(1)^2+temp_V(2)^2)*sqrt(temp_mainV(1)^2+temp_mainV(2)^2)));
    Angle_dev(i,:)=gaussmf(tmp_angle,[0.8,0]);


end

