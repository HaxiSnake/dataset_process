clc;clear all;

 imgdir = 'L:\Download\Data\oxford\oxford_id\';
 imgsuffix = '.jpg';
 our_feature = [];

parfor i=0:1:5117
    i
    Img=imread(strcat(imgdir,num2str(i),imgsuffix)); 
    fea=extract_hsv(Img)
    our_feature(i+1,:) =[fea i];
end
our_feature=single(our_feature);
cname =  strcat('./result/','Oxford-HSV');
save(cname,'our_feature');

fprintf(1,'          ===========ÊµÑé½áÊø============ \n')