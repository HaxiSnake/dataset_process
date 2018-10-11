This MATLAB code generates 1000-dim HSV histogram for an input image, and perform global search using rootHSV.

Notes:
1) The number of bins for H, S, and V is 20, 10, 5, respectively.
2) We pre-calculate the features on the Ukbench dataset. One can test it on other datasets as well.
3) We use l1-norm for similarity measurement in this code.
 
If you find this code helpful in your research, please kindly cite any of the following papers, which use the same code for HSV search.

1) Liang Zheng, Shengjin Wang, Ziqiong Liu, and Qi Tian. "Packing and Padding: Coupled Multi-index for Accurate Image Retrieval". In: CVPR, 2014.
2) Liang Zheng, Shengjin Wang, and Qi Tian. "Lp-norm IDF for Scalable Image Retrieval", Lp-norm IDF for Scalable Image Retrieval". Image Processing, IEEE Transactions on, Vol 23, No. 8, pp. 3604-3617, June, 2014.
3) Liang Zheng, Shengjin Wang, and Qi Tian. "Coupled Binary Embedding for Scalable Image Retrieval". Image Processing, IEEE Transactions on, Vol 23, No. 8, pp. 3368-3380, June, 2014.
