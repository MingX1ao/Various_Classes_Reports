from Image import ImageProcessor
import cv2
import numpy as np
from IO import display

def doulbe_threshold(image, low_threshold=105, high_threshold=120):
    _, hole = cv2.threshold(image, low_threshold, 255, cv2.THRESH_BINARY)
    _, binary_image = cv2.threshold(image, high_threshold, 255, cv2.THRESH_BINARY)
    return hole, binary_image

def mix_edges_and_image(image):
    edges = cv2.Canny(image, 100, 200)
    return cv2.add(image, edges)

def remove_components(image, min_area_threshold):
    num_labels, labels, stats, centroids = cv2.connectedComponentsWithStats(image, connectivity=8)
    for i in range(1, num_labels):
        if stats[i, cv2.CC_STAT_AREA] < min_area_threshold:
            image[labels == i] = 0
    middle_column = image.shape[1] // 2
    for i in range(1, num_labels):
        if np.any(labels[:, middle_column] == i):
            image[labels == i] = 0
    return image

def fill_gaps(image):
    kernel = np.ones((20, 20), np.uint8)
    return cv2.morphologyEx(image, cv2.MORPH_CLOSE, kernel)

def fill_blocks(image):
    image = ~image
    num_labels, labels, stats, centroids = cv2.connectedComponentsWithStats(image, connectivity=8)
    mean_area_threshold = np.mean(stats[1:, cv2.CC_STAT_AREA])
    for i in range(1, num_labels):
        if stats[i, cv2.CC_STAT_AREA] < mean_area_threshold:
            image[labels == i] = 0
    return ~image

def select_mid_area(image):
    num_labels, labels, stats, centroids = cv2.connectedComponentsWithStats(image, connectivity=8)
    middle_row = image.shape[0] // 2  # 修改为获取图像的中间行
    for i in range(1, num_labels):
        for row in range(middle_row-100, middle_row):  # 修改为遍历中间行的像素
            if np.any(labels[row, :] == i):  # 检查中间行是否有标签 i
                image[labels == i] = 1
                break
            else:
                image[labels == i] = 0
    return image


def segment_image(self, type):
    hole, binary_img = doulbe_threshold(self.preprocessed_image)
    edged_image = mix_edges_and_image(binary_img)
    if type == 'a':
        remained_image = remove_components(edged_image, 500)
        self.segmented_image = fill_gaps(remained_image)
        self.segmented_image = cv2.bitwise_and(self.segmented_image, hole)
        return self.segmented_image
    else:
        remained_image = remove_components(edged_image, 600)
        filled_blocks_image = fill_blocks(remained_image)
        self.segmented_image = select_mid_area(filled_blocks_image)
        self.segmented_image = cv2.bitwise_and(self.segmented_image, hole)
        return self.segmented_image

setattr(ImageProcessor, 'segment_image', segment_image)