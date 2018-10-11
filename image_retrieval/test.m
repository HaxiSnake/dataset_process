test_set            = 'oxford5k';                   % oxford5k, paris6k, instre, oxford105k, paris106k
feature             = 'cot';                        % siamac or resnet
  
data_dir            = 'L:/Download/Data/feature';   % this is where descriptors should be stored
data_file = sprintf('%s/%s_%s_nroi.mat',data_dir,test_set,feature);
gnd_file  = sprintf('%s/gnd_%s.mat',data_dir,test_set);

load(data_file);
load(gnd_file);
V = data.V;
qV = data.Q;
DataSet.Data=[];
for j = 1:length(V)
    temp = cell2mat(V(j));
    DataSet.Data(j,:)=temp;
end
scores=[];
for k = 1:length(qV)
    query=cell2mat(qV(k));
    sub=DataSet.Data-repmat(query,length(V),1);
    scores(k,:)=sum(abs(sub)');
end
[~, ranks] = sort(scores');
map = compute_map (ranks, gnd);
fprintf('map %.4f\n', map);