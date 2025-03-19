运行方式：
用编译器打开整个文件夹，运行main.py，会弹出“选择图像编号”的对话框。输入：a1~a4,c1~c3,s1~s3 的任意编号，即可查看对应图像的分割数据和结果，并将nii格式文件保存在对应的图片编号文件夹下。

文件组成：

main.py   	---主程序，输入输出的交互
IO.py     	---图像的读入、保存和展示
Image.py        ---图像处理器的类
preProcess.py   ---Image类中的函数，负责图像预处理
Segment.py      ---Image类中的函数，负责图像分割
Evaluate.py     ---Image类中的函数，负责评估分割结果

IMG	  ---储存图像的总文件夹
- a1	    ---对应的每个图像的输入数据、输出数据、对照组数据
  a1.png      ---原始图像
  a1l.png     ---用于对比的ground_truth图像
  a1_segmented.nii  ---保存为nii格式的分割结果
- a2
...
- s3