function kernel = GenerateKernel(nk, method)
%这个函数用来求解高斯核距离矩阵
switch method
  case 1
     a = zeros(nk,nk);
     CT= floor(nk./2)+1;
     for i = 1:nk
         for j = 1:nk
            a(i,j) = (i-CT)^2+(j-CT)^2;
         end
     end
      kernel = exp(-sqrt(a)); 
      kernel = kernel ./sum(kernel(:));
      %根据（5）式可以得到高斯核距离矩阵
    otherwise
     kernel = fspecial('gaussian',[nk,nk],1);%生成高斯滤波器
end