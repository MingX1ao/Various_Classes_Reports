import cv2
import SimpleITK as sitk
import matplotlib.pyplot as plt

def read_image(path):
    # 读取图像
    image = cv2.imread(path, cv2.IMREAD_GRAYSCALE)
    return image

def save_segmentation_as_nii(segmented_image, save_path):
    segmented_image = sitk.GetImageFromArray(segmented_image)
    # 保存为.nii文件
    sitk.WriteImage(segmented_image, save_path)

def display(image_train): 
    n = len(image_train)
    fig, axes = plt.subplots(1, n, figsize=(n*3, 3))
    for i, (name, image) in enumerate(image_train.items()):
        axes[i].imshow(image, cmap='gray')
        axes[i].set_title(name)
        axes[i].axis('off')
    plt.tight_layout()
    plt.show()