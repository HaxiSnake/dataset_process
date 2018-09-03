import numpy as np 
from scipy.io import loadmat
import argparse

def parse_args():
    parser = argparse.ArgumentParser(description="search script")
    parser.add_argument(
        '--feature_path',
        type=str,
        required=True,
        help="The path of dataset feature(*.mat)")
    parser.add_argument(
        '--result_path',
        type=str,
        required=True,
        help="The path of search result")
    return parser.parse_args()
def search():
    args = parse_args()
    # read features
    features=loadmat(args.feature_path)
    # split querys
    try:
        features = np.asarray(features['our_feature1'])
    except:
        print("keys:",features.keys())
        print("There is no 'our_feature1' key in features, you need to change features name in this code\n")
    querys=features[features[:,-1]%100==0]
    features,features_number = features[:,:-1],features[:,-1] 
    querys,querys_number = querys[:,:-1],querys[:,-1] 
    
    # calculate distance
    result=np.sum(np.abs(features-querys[:,np.newaxis,:]),axis=2)
    
    # sort
    rank_ID = np.argsort(result,axis=1)

    # output result
    with open(args.result_path,'w') as output:
        for i,query_num in enumerate(querys_number):
            pic_suffix = ".jpg"
            query_name = "%6d%s"%(query_num,pic_suffix)
            line=[query_name]
    #         for rank,img_name in enumerate(features_number[rank_ID[i,1:21]]):
    #             line.append("%d %6d%s"%(rank,img_name,pic_suffix))
            for rank,img_name in enumerate(features_number[rank_ID[i,1:]]):
                if(img_name//100 == query_num //100):
                    line.append("%d %6d%s"%(rank,img_name,pic_suffix))       
            output.write(' '.join(line) + '\n')
if __name__ == '__main__':
    search()