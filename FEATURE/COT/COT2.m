clc;
 imgdir = '/share/dong/Data/OxfordBuilding/rename_imgs/';
 imgsuffix = '.jpg';
color = [8 3 3;12 3 3;8 4 4;12 4 4];     % ------- HSV空间
% color = [4 2 2;8 2 2;16 2 2;8 4 4];      % ------- RGB空间 
% color = [5 3 3;10 3 3;15 3 3;20 3 3];      % ------- Lab空间 
gd = [6 12 18 24 30];
colorbin = 3;
CB = color(colorbin,:);
gdbin = 2;
DB = gd(gdbin);
our_feature = {};
k=1;
%our_feature={};
g1 = [ 1 1 1 ; 1 1 1 ; 1 1 1 ] / 9;
g2=zeros(3,3);g2(2,2)=2;g2=single(g2-g1);
%  myPool = parpool(4);
% addAttachedFiles(myPool, 'conv2.m');
tic
parfor jj=0:5117
    jj
           %Img1=imread([imgdir,num2str(jj),imgsuffix]);
%            Img1(:,:,1)= conv2(single(Img(:,:,1)), g1);
%            Img1(:,:,2)= conv2(single(Img(:,:,2)), g1);
%            Img1(:,:,3)= conv2(single(Img(:,:,3)), g1);
%            Img1=uint8(Img1);
           % Img1=imread([imgdir,strcat('obj',num2str(i),'__',num2str((j-1)*5)),imgsuffix]);
            %Img=reshape(Y(i,:),32,32,3);
             Img1=imread([imgdir,num2str(jj),imgsuffix]);
            [M,N,P] = size(Img1);
            hsv = rgb2hsv(Img1);
            ColorX = color_transfer(hsv,2,CB);
            [ dir,ori ] = coloredge( hsv,DB );
            Texton = -1*ones(M,N);
            mapping=getmapping(8,'u2');
            LBP = lbp(rgb2gray(Img1),1,8,mapping,'i');
            Texton(2:end-1,2:end-1) = LBP;
            
            FC = corr_color( hsv,ColorX,CB(1)*CB(2)*CB(3) );
            FO = corr_color(hsv,ori,DB);
            FT = corr_color(hsv,Texton,59);
           our_feature{jj+1} = [FC FO FT jj];
    %         our_feature1{jj} =[0.1*FC FO 0.5*FT];% 0.5,1.62
end
toc
        our_feature=cat(1, our_feature{:});
        cname =  strcat('./results/','Oxford-COT2');
        save(cname,'our_feature');
fprintf(1,'          ===========实验结束============ \n')
