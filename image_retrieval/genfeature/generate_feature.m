test_set            = 'oxford5k';                   % oxford5k, paris6k, instre, oxford105k, paris106k 
data_dir            = 'L:/Download/Data';           % this is where descriptors should be stored
gnd_file            = sprintf('%s/%s/gnd_%s.mat',data_dir,test_set,test_set);
img_suffix          = '.jpg';                       % .jpg/.png
load(gnd_file);
Q={};
V={};
color = [8 3 3;12 3 3;8 4 4;12 4 4];     % ------- HSV¿Õ¼ä
% color = [4 2 2;8 2 2;16 2 2;8 4 4];      % ------- RGB¿Õ¼ä 
% color = [5 3 3;10 3 3;15 3 3;20 3 3];      % ------- Lab¿Õ¼ä 
gd = [6 12 18 24 30];
colorbin = 3;
gdbin = 2;
CB = color(colorbin,:);
DB = gd(gdbin);
parfor j = 1:length(imlist)
    fprintf('Generating %d query features... \n',j);
    img_path = sprintf('%s/%s/images/%s%s',data_dir,test_set,char(imlist(j)),img_suffix);
    fprintf('%s\n',img_path);
    img=imread(img_path);
    [M,N,P] = size(img);
    hsv = rgb2hsv(img);
    ColorX = color_transfer(hsv,2,CB);
    [ dir,ori ] = coloredge( hsv,DB );
    Texton = -1*ones(M,N);
    mapping=getmapping(8,'u2');
    LBP = lbp(rgb2gray(img),1,8,mapping,'i');
    Texton(2:end-1,2:end-1) = LBP;
    FC = corr_color( hsv,ColorX,CB(1)*CB(2)*CB(3) );
    FO = corr_color(hsv,ori,DB);
    FT = corr_color(hsv,Texton,59);
    V{j} = [FC FO FT]; 
end
for k = 1:length(qidx)
    fprintf('Generating %d query features... \n',k);
    img_path = sprintf('%s/%s/images/%s%s',data_dir,test_set,char(imlist(qidx(k))),img_suffix);
    fprintf('%s\n',img_path);
    roi = round(gnd(k).bbx);
    roi(roi==0)=1;
    img=imread(img_path);
    %img=img(roi(2):roi(4),roi(1):roi(3),:);
    [M,N,P] = size(img);
    hsv = rgb2hsv(img);
    ColorX = color_transfer(hsv,2,CB);
    [ dir,ori ] = coloredge( hsv,DB );
    Texton = -1*ones(M,N);
    mapping=getmapping(8,'u2');
    LBP = lbp(rgb2gray(img),1,8,mapping,'i');
    Texton(2:end-1,2:end-1) = LBP;
    FC = corr_color( hsv,ColorX,CB(1)*CB(2)*CB(3) );
    FO = corr_color(hsv,ori,DB);
    FT = corr_color(hsv,Texton,59);
    Q{k} = [FC FO FT]; 
end
data.V = V;
data.Q = Q;
feature_name = 'cot';
save_path = sprintf('%s/feature/%s_%s_nroi',data_dir,test_set,feature_name);
save(save_path,'data');