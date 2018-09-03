# holiday数据集使用说明

## 特征生成

特征使用matlab生成.mat格式文件，保存的变量名称为feature1，格式为： 特征+图片编号，可参考案例example.mat

## 检索

使用search.py进行检索,eg:
    
    python3 search.py --feature_path example.mat --result_path result.dat 

    feature_path: 特征路径
    result_path: 结果输出路径

## 评测

使用holidays_map.py进行评测

**tips:需要保证目录下有holidays_images.dat文件**

eg:

    python2 holidays_map.py result.dat
