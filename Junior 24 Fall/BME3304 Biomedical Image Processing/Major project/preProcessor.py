import cv2
import numpy as np
from Image import ImageProcessor

def preprocess_image(self):
    kernel = np.ones((3, 3), np.uint8)
    # 形态学开运算去噪
    opened_image = cv2.morphologyEx(self.image, cv2.MORPH_OPEN, kernel)
    # 形态学闭运算去噪
    closed_image = cv2.morphologyEx(opened_image, cv2.MORPH_CLOSE, kernel)
    
    self.preprocessed_image = closed_image
    return self.preprocessed_image

setattr(ImageProcessor, 'preprocess_image', preprocess_image)