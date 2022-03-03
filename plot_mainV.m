function plot_mainV(real,nc)
%用来画出估计运动向量的向量场图

figure;

x1(:,1)=1/(2*nc):1/nc:(2*nc-1)/(2*nc);
x1(:,2)=1/(2*nc):1/nc:(2*nc-1)/(2*nc);

real(nc,nc,1)=0;
real(nc,nc,2)=0;

for i=1:nc
    for j=1:nc       
    
       quiver(x1(i, 1),x1(j, 2), ((real(i,j,1))/8), ((real(i,j, 2))/8),1, 'c','Linewidth',1.5,'MaxHeadSize',2), hold on
         
    end
end

   set(gca,'XTick',0:1/nc:1);
   set(gca,'YTick',0:1/nc:1);

   set(gca,'xticklabel',[]) ;
   set(gca,'yticklabel',[]) ;

   grid on

axis equal
axis([0 1 0 1]);

