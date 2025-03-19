# 构建一个图像处理类，用于图像处理
from IO import read_image,save_segmentation_as_nii

class ImageProcessor:
    def __init__(self):
        input_path = None
        ground_truth_path = None
        image,preprocessed_image,segmented_image,ground_truth = None,None,None,None

    def load_image(self,input_path,ground_truth_path):
        self.input_path = input_path
        self.image = read_image(input_path)
        self.ground_truth_path = ground_truth_path
        self.ground_truth = read_image(ground_truth_path)
        return self.image
    
    def save_segmentation(self,output_path):
        save_segmentation_as_nii(self.segmented_image,output_path)
        return self.segmented_image


