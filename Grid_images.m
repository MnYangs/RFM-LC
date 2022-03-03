function [grid_xy,meanV,numVec_Grid]=Grid_images(X_V_norm,nc,indi_Bin)
%�����񷨽��������ݻ���Ϊnc^2�ĵ�Ԫ��
%X_V_norm�е�ÿ��Ԫ�صķ�Χ����0��1
%�������λ�þ���grid_xy�������ж������������Ǹ�����
%���ÿ�������ƽ���˶�����meanV
%���ÿ���������˶���������ĿnumVec_Grid

interval=1/nc;
grid_xy=floor(X_V_norm(:,1:2)./interval)+1;
meanV = zeros(nc, nc, 2);
density = zeros(nc, nc);

numVec_Grid = density;  

for i = 1:nc
    for j = 1:nc
        temp1 = (grid_xy(:,1) == i & grid_xy(:,2) == j & indi_Bin==1 );% �����ж������Ƿ��������i��j��Ԫ������ѡ����
        temp2 = sum(temp1);
        numVec_Grid(i, j) = temp2;%��i��j����Ԫ����������Ŀ
        if numVec_Grid(i, j) ~=0
        meanV(i, j, 1:2) = mean(X_V_norm(temp1,3:4),1);   %�����Щ������ƽ��ֵ
         
        else 
            meanV(i, j, 1:2)=[0,0];
        end
    end
end


