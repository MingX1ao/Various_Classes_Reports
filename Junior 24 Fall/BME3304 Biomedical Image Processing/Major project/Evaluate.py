import numpy as np
from sklearn.metrics import confusion_matrix
from Image import ImageProcessor

def evaluate_segmentation(self):
    # 将图像转换为二值图像
    ground_truth = np.where(self.ground_truth > 0, 1, 0)
    segmented_image = np.where(self.segmented_image > 0, 1, 0)
    
    # 计算混淆矩阵
    tn, fp, fn, tp = confusion_matrix(ground_truth.flatten(), segmented_image.flatten()).ravel()
    
    # 计算评价指标
    dice_score = (2 * tp) / (2 * tp + fp + fn)
    sensitivity = tp / (tp + fn)
    specificity = tn / (tn + fp)
    precision = tp / (tp + fp)
    accuracy = (tp + tn) / (tp + tn + fp + fn)
    
    return {
        'Dice Score': dice_score,
        'Sensitivity': sensitivity,
        'Specificity': specificity,
        'Precision': precision,
        'Accuracy': accuracy,
    }

setattr(ImageProcessor, 'evaluate_segmentation', evaluate_segmentation)