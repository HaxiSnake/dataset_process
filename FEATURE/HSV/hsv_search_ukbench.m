% image search using HSV histogram on Ukbench
% If you find this code helpful in your research, please kindly cite any of the following papers, which use the same code for HSV search.

% 1) Liang Zheng, Shengjin Wang, Ziqiong Liu, and Qi Tian. "Packing and Padding: Coupled Multi-index for Accurate Image Retrieval". In: CVPR, 2014.
% 2) Liang Zheng, Shengjin Wang, and Qi Tian. "Lp-norm IDF for Scalable Image Retrieval", Lp-norm IDF for Scalable Image Retrieval". Image Processing, IEEE Transactions on, Vol 23, No. 8, pp. 3604-3617, June, 2014.
% 3) Liang Zheng, Shengjin Wang, and Qi Tian. "Coupled Binary Embedding for Scalable Image Retrieval". Image Processing, IEEE Transactions on, Vol 23, No. 8, pp. 3368-3380, June, 2014.

% load data
fid = fopen('HSV_HIST.txt');
Hist = fread(fid, 'single');
fclose(fid);
Hist = reshape(Hist, 1000, []);

% calculate rootHSV (HSV*)
sum_val = sum(Hist);
for n = 1:1000
    Hist(n, :) = Hist(n, :)./sum_val;
end
Hist = sqrt(Hist);

% image search
NS = 0;
for n = 1:10200
    n
    hist = Hist(:, n);
    dist = zeros(10200, 1);
    for i = 1:10200
        dist(i) = sum(abs(hist-Hist(:, i)));
    end
    [~, rank] = sort(dist, 'ascend');
    tmp = ceil(n/4);
    for j = 1:4
        if ceil(rank(j)/4) == tmp
            NS = NS + 1;
        end
    end
end
fprintf('NS-score = %f\r\n', NS/10200);