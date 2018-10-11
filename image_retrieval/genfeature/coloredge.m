function [ dir,ori ] = coloredge( Lab,num )

%使用sobel算子，计算三个分量图像的x,y偏导数
sh=fspecial('sobel');                 % sh = [1 2 1;0 0 0;-1 -2 -1]
sv=sh';                               % sv = [1 0 -1;2 0 -2;1 0 -1]
Rx=imfilter(double(Lab(:,:,1)),sh,'replicate'); 
Ry=imfilter(double(Lab(:,:,1)),sv,'replicate'); 
Gx=imfilter(double(Lab(:,:,2)),sh,'replicate'); 
Gy=imfilter(double(Lab(:,:,2)),sv,'replicate'); 
Bx=imfilter(double(Lab(:,:,3)),sh,'replicate'); 
By=imfilter(double(Lab(:,:,3)),sv,'replicate'); 

%compute the parameters of the vector gradient. 
gxx=Rx.^2+Gx.^2+Bx.^2; 
gyy=Ry.^2+Gy.^2+By.^2; 
gxy=Rx.*Ry+Gx.*Gy+Bx.*By; 

A1=0.5*(atan(2*gxy./(gxx-gyy+0.0001))); 
G1=0.5*((gxx+gyy)+(gxx-gyy).*cos(2*A1)+2*gxy.*sin(2*A1)); 
A2=A1+pi/2; 
G2=0.5*((gxx+gyy)+(gxx-gyy).*cos(2*A2)+2*gxy.*sin(2*A2)); 
G1=G1.^0.5; 
G2=G2.^0.5;

a=size(G1,1);b=size(G1,2);
dir=zeros(a,b);
ori=dir;
DD = (G1-G2)>=0;
dir(DD)=90 + A1(DD).*(180/pi);
ori(DD)=round(dir(DD).*(num/360));
CC=(G1-G2)<0;
dir(CC)=180 + A2(CC).*(180/pi);
ori(CC)=round(dir(CC).*(num/360));
ori(ori>=(num-1))= num-1;
% for i=1:size(A1,1)
%     for j=1:size(A1,2)
%         if max(G1(i,j),G2(i,j)) == G1(i,j)
%             dir(i,j) = 90 + A1(i,j)*180/pi;
%             ori(i,j) = round(dir(i,j)*num/360);
%         else 
%             dir(i,j) = 180 + A2(i,j)*180/pi;
%             ori(i,j) = round(dir(i,j)*num/360);
%         end
%         if ori(i,j)>=num-1
%             ori(i,j) = num-1;
%         end
%     end
% end

end

