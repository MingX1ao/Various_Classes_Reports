import numpy as np
import matplotlib.pyplot as plt
import os
from Image import ImageProcessor
from IO import display, read_image, save_segmentation_as_nii
import preProcessor
import Segment
import Evaluate

# 生成文件路径
def make_path(idx):
    type = idx[0]
    base_path = os.path.join('IMG', idx)
    image_path = os.path.join(base_path, idx + '.png')
    ground_truth_path = os.path.join(base_path, idx + 'l.png')
    segmented_path = os.path.join(base_path, idx + '_segmented.nii')
    return type, base_path, image_path, ground_truth_path, segmented_path

def main():
    # 读取图像
    image_processor = ImageProcessor()
    while True:
        idx = input('请在 a1~a4,c1~c3,s1~s3 中选择图像: \n')
        if idx in ['a1', 'a2', 'a3', 'a4', 'c1', 'c2', 'c3', 's1', 's2', 's3']:
            type,path,image_path,ground_truth_path,segmented_path = make_path(idx)
            break
        print("编号错误，请重新输入")

    image = read_image(image_path)
    ground_truth_image = read_image(ground_truth_path)
    image_processor.load_image(image_path, ground_truth_path)
    
    # 预处理图像
    preprocessed_image = image_processor.preprocess_image()
    
    # 图像分割
    segmented_image = image_processor.segment_image(type)
    
    # 保存分割结果
    image_processor.save_segmentation(segmented_path)
    
    # 计算评价指标
    evaluation_result = image_processor.evaluate_segmentation()
    for key, value in evaluation_result.items():
        print(f'{key}: {value:.4f}')
    display({'image': image, 'segmented_image': segmented_image, 'ground_truth_image': ground_truth_image})

if __name__ == "__main__":
    main()