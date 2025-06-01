# Homework 3



## 3.1 **基因差异表达分析**

我选择精神分裂症尸脑表达数据



### 3.1.1 程序运行结果

**第六步坐标图片**

<center><img src="IMG\522031910576_王君豪_plotVoom.png" width="500"></center>



**第八步坐标图片**

<center><img src="IMG\522031910576_王君豪_plotBCV.png" width="500"></center>



**第七步终端截图**

<center><img src="IMG\522031910576_王君豪_limma.png" width="500"></center>



**第九步终端截图**

<center><img src="IMG\522031910576_王君豪_edgeR.png" width="500"></center>



**第十一步终端截图**

<center><img src="IMG\522031910576_王君豪_DESeq2.png" width="500"></center>



**第十二步终端截图**

<center><img src="IMG\522031910576_王君豪_corr.png" width="500"></center>



### 3.1.2 三个工具结果的异同点

**FC > 2/3**

看每个工具的$|\log_2FC|$和1/1.58的关系

 在$FC>2$的约束下

* limma返回PKHD1L1、LINC00996异常表达
* edgeR返回HILPDA、CXCL9、IL1RL1异常表达
* DESqe2返回HILPDA、IL1RL1表达异常



在$FC>3$的约束下

* limma返回没有异常
* edgeR返回CXCL9、IL1RL1异常表达
* DESqe2返回IL1RL1表达异常



edgeR和DESeq2的结果相近，但是默认的分母好像不一样，导致两个结果的对数是相反的

limma的结果与其他两个差的比较多，可能是因为其他两个的假定分布都是负二项分布，而limma是正态分布且适用于较小的数据集的原因

这个数据集太大了，3-1跑了40min才出结果，3-2一小时了数据还没洗完。。。



**q-value / FDR < .05 / 0.1**

图里的都满足，但是limma的计算结果比其余两个都大

说明三个工具都支持图中出现的基因表达异常，但是edgeR和DESeq2更加支持，因为他们的值更小，说明没有异常的可能性更小



### 3.1.2 3个top差异表达基因

* HILPDA：后两个表出现，q-value极小，且FC > 2
* ADAMTS2：三个表都有出现，q-value极小，但FC没到2
* IL1RL1：后两个表出现，q-value极小，且FC > 2

HILPDA和IL1RL1可能是通过量的积累引起的疾病，而ADAMTS2应该是关键的发病基因，虽然表达量差异不显著，但是三种方法都认为”这个基因异常表达“这个结论出错的概率极小，因此认为这是个关键基因



## 3.2 WGCNA & 富集分析

果断换小数据集了，用双相情感障碍的去了，小了25倍。。。



### 3.2.1 程序运行结果

观察图像后选择h=350作为阈值进行剪切

<center><img src="IMG\1.png" width="500"></center>



**步骤2.2的图片**

仅一个Block的结果，因为太大了

<center><img src="IMG\522031910576_王君豪_Cluster_Dendrogram.jpg" width="700"></center>



**步骤3.1的图片**

<center><img src="IMG/522031910576_王君豪_Module-trait relationship.jpg" width="800"></center>

由于仅是否患病一个表型，故只有一列

发现turquoise是最深的，使用它进行下一步的分析



**步骤3.3的图片**

<center><img src="IMG/522031910576_王君豪_module_gene.jpg" width="800"></center>

可以看出还是有正相关的



### 3.2.2 富集分析

选择turquoise进行GO富集分析，得到的WGCNA_GO结果为

<center><img src="IMG/WGCNA_GO_王君豪.png" width="800"></center>

下面给出富集通路与BD的关系：

* **强关联**：纤毛相关过程[1]（GO:0044782等）、DNA损伤修复[2]（GO:0042276）、RNA剪接[3]（GO:0008380）与BD的神经发育、基因表达和氧化应激机制直接相关。研究表明，BD患者中纤毛形成减少[1]，DNA损伤修复缺陷[2]，以及RNA剪接异常[3]是重要的病理特征
* **中度关联**：IL-27信号通路[4]（GO:0070106）和微管调控[5]（GO:0032886）通过神经炎症和神经发育与BD相关，文献支持BD患者存在神经炎症标志物升高[4]和微管相关蛋白异常[5]
* **弱关联**：染色质环化（GO:0140588）和脂质羟基化（GO:0002933）可能通过表观遗传和代谢机制间接影响BD；减数分裂（GO:0007127）、DNA重组（GO:0006310）等与生殖过程相关，关联性较弱

总体而言，变异与双相情感障碍的相关性大致符合GO分析的排序



参考文献

[1] [Primary cilia formation is diminished in schizophrenia and bipolar disorder: A possible marker for these psychiatric diseases - ScienceDirect](https://www.sciencedirect.com/science/article/pii/S0920996417305303)

[2] [Oxidatively-induced DNA base damage and base excision repair abnormalities in siblings of individuals with bipolar disorder DNA damage and repair in bipolar disorder | Translational Psychiatry](https://www.nature.com/articles/s41398-024-02901-3)

[3] [Dysfunctional Gene Splicing as a Potential Contributor to Neuropsychiatric Disorders - PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC3082621/)

[4] [Frontiers | Non-canonical pathways in the pathophysiology and therapeutics of bipolar disorder](https://www.frontiersin.org/journals/neuroscience/articles/10.3389/fnins.2023.1228455/full)

[5] [Biological Pathways Associated with Neuroprogression in Bipolar Disorder](https://www.mdpi.com/2076-3425/11/2/228)