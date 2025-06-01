# 加载必要的库
library(WGCNA)

# 设置工作目录
setwd()

# 1. 加载基因表达数据
femData = read.csv("BP\\bp_count2fpkm.csv")  
exprMat = t(femData[, -1])  # 转置
colnames(exprMat) = as.character(femData[, 1])  # 设置列名为基因名
rownames(exprMat) = names(femData)[-1]          # 设置行名为样本名
datExpr0 = as.data.frame(scale(exprMat))        # 标准化 & 转为 data frame

# 检查缺失值和异常值
gsg = goodSamplesGenes(datExpr0, verbose = 3)
if (!gsg$allOK) {
  datExpr0 = datExpr0[gsg$goodSamples, gsg$goodGenes]  # 移除不合格的样本或基因
}

# 基于样本聚类移除异常值
sampleTree = hclust(dist(datExpr0), method = "average")
plot(sampleTree, main = "样本聚类以检测异常值", sub = "", xlab = "")
abline(h = 350, col = "red")  # 根据数据调整高度阈值
clust = cutreeStatic(sampleTree, cutHeight = 350, minSize = 10)
keepSamples = (clust == 1)
datExpr = datExpr0[keepSamples, ]  # 保留正常样本

# 2. 加载表型数据
traitData = read.table("BP/BP_sample_detail.txt", sep = "\t", header = TRUE)  # 表型数据文件

# 提取样本ID和疾病状态，转换为二进制格式
datTraits = data.frame(
  Sample = traitData[, "X.Sample_title"],                     # 样本标题
  Disease = ifelse(grepl("Bipolar Disorder", traitData[, "X.Sample_source_name_ch1"]), 1, 0)  # 1 为双相障碍，0 为对照
)

# 3. 调整表型数据的样本名以匹配基因表达数据
# 假设 datExpr 的行名格式为 "SL32229"，从 datTraits$Sample 中提取
datTraits$SampleID = sub(".*_SL", "SL", datTraits$Sample)

# 匹配样本
femaleSamples = rownames(datExpr)
traitRows = match(femaleSamples, datTraits$SampleID)

# 检查未匹配的样本数量
print(sum(is.na(traitRows)))  # 理想情况下应为 0 或很少

# 仅保留匹配的样本
keepSamples = !is.na(traitRows)
datExpr = datExpr[keepSamples, ]
# print(names(datExpr))
femaleSamples = femaleSamples[keepSamples]
traitRows = traitRows[keepSamples]
datTraits = datTraits[traitRows, "Disease", drop = FALSE]  # 保留疾病状态列
rownames(datTraits) = femaleSamples

# 确保 Disease 为数值型
datTraits$Disease = as.numeric(datTraits$Disease)

# 4. 可视化样本聚类与表型热图
sampleTree2 = hclust(dist(datExpr), method = "average")
traitColors = numbers2colors(datTraits, signed = FALSE)  # 将疾病状态转换为颜色
plotDendroAndColors(sampleTree2, traitColors,
                    groupLabels = "疾病状态",
                    main = "样本树状图与表型热图")



# 2. 构建网络

# 2.1 构建自动化检测网络和检测模块
enableWGCNAThreads(nThreads = 11)  #Windows系统开启多线程
#allowWGCNAThreads()  #MAC开启多线程
powers = c(c(1:10), seq(from = 12, to=20, by=2))
# sft = pickSoftThreshold(datExpr, powerVector = powers, verbose = 5)
# print("power:", sft$powerEstimate) #系统自动返回合适的软阈值，这里仅介绍此种方法


# 2.2 一步法构建网络和模块检测
# 在power中输入上一步的软阈值
net = blockwiseModules(datExpr, 
                       power = 6, 
                       TOMType = "unsigned", 
                       minModuleSize = 30, 
                       reassignThreshold = 0, 
                       mergeCutHeight = 0.25,  
                       numericLabels = TRUE, 
                       pamRespectsDendro = FALSE, 
                       saveTOMs = TRUE,  
                       saveTOMFileBase = "femaleMouseTOM", 
                       verbose = 3)
# write.table(TOM,"TOM.txt")  #保留TOM值文档（在文件夹中打开femaleMouseTOM，不然会报错）
for (i in 1:1) {
  tom_rdata <- paste0("femaleMouseTOM-block.", i, ".RData")  # 注意是 .RData
  tom_txt   <- paste0("TOM_block", i, ".txt")

  load(tom_rdata)  # 加载后通常生成名为 TOM 的矩阵
  write.table(as.matrix(TOM), file = tom_txt, sep = "\t", quote = FALSE)
}



#minModuleSize：模块中最少的基因数
#mergeCutHeight ：模块合并阈值，阈值越大，模块越少（重要）
#saveTOMs = TRUE,saveTOMFileBase = "femaleMouseTOM"保存TOM矩阵，名字为"femaleMouseTOM"
#net$colors 包含模块分配，net$MEs 包含模块的模块特征基因。

# 绘制模块标识的层次聚类树状图，并保存
table(net$colors)
sizeGrWindow(12, 9)
mergedColors = labels2colors(net$colors)
png("Cluster_Dendrogram.jpg", width = 1200, height = 900)
plotDendroAndColors(net$dendrograms[[1]], mergedColors[net$blockGenes[[1]]], "Module colors", dendroLabels = FALSE, hang = 0.03, addGuide = TRUE, guideHang = 0.05)
dev.off()
# 查看划分的模块数和每个模块里面包含的基因个数，记录分块基因信息
moduleLabels = net$colors
moduleColors = labels2colors(net$colors)
MEs = net$MEs
geneTree = net$dendrograms[[1]]


# 3. 模块与表型数据关联识别重要基因
# 3.1 模块-表型数据关联

nGenes = ncol(datExpr);
nSamples = nrow(datExpr);
# 重新计算带有颜色标签的模块
MEs0 = moduleEigengenes(datExpr, moduleColors)$eigengenes
MEs = orderMEs(MEs0)
moduleTraitCor = cor(MEs, datTraits, use = "p");
moduleTraitPvalue = corPvalueStudent(moduleTraitCor, nSamples);
# 通过相关值对每个关联进行颜色编码
sizeGrWindow(10,6)
# 展示模块与表型数据的相关系数和 P值
textMatrix = paste(signif(moduleTraitCor, 2), "\n(",
                   signif(moduleTraitPvalue, 1), ")", sep = "");
dim(textMatrix) = dim(moduleTraitCor)
par(mar = c(6, 8.5, 3, 3));
# 用热图的形式展示相关系数，并保存作图
png("Module-trait relationship.jpg", width = 1200, height = 900)
labeledHeatmap(Matrix = moduleTraitCor,xLabels = names(datTraits),yLabels = names(MEs),
               ySymbols = names(MEs),
               colorLabels = FALSE,
               colors = blueWhiteRed(50),
               textMatrix = textMatrix,
               setStdMargins = FALSE,
               cex.text = 0.5,
               zlim = c(-1,1),
               main = paste("Module-trait relationships"))
dev.off()

# 3.2 基因与表型数据的关系、重要模块：基因显著性和模块成员
DiseaseCondition = as.data.frame(datTraits$Disease);
names(DiseaseCondition) = "is_diseased";
modNames = substring(names(MEs), 3)
geneModuleMembership = as.data.frame(cor(datExpr, MEs, use = "p"));
MMPvalue = as.data.frame(corPvalueStudent(as.matrix(geneModuleMembership), nSamples));
names(geneModuleMembership) = paste("MM", modNames, sep="");
names(MMPvalue) = paste("p.MM", modNames, sep="");
geneTraitSignificance = as.data.frame(cor(datExpr, DiseaseCondition, use = "p"));# 和表型数据相关
GSPvalue = as.data.frame(corPvalueStudent(as.matrix(geneTraitSignificance), nSamples));
names(geneTraitSignificance) = paste("GS.", names(DiseaseCondition), sep="");
names(GSPvalue) = paste("p.GS.", names(DiseaseCondition), sep="");

# 3.3	模块内分析：鉴定具有高GS和高MM的基因
module = "turquoise"; # 选择模块
column = match(module, modNames);
moduleGenes = moduleColors==module;
sizeGrWindow(7, 7);
par(mfrow = c(1,1));
# 绘制MM-GS图，并保存
png("module_gene.jpg", width=1200, height=900)
verboseScatterplot(abs(geneModuleMembership[moduleGenes, column]),
                   abs(geneTraitSignificance[moduleGenes, 1]),
                   xlab = paste("Module Membership in", module, "module"),
                   ylab = "Gene significance for was diseased",
                   main = paste("Module membership vs. gene significance\n"),
                   cex.main = 1.2, cex.lab = 1.2, cex.axis = 1.2, col = module)
dev.off()

# 3.4	 输出网络分析结果
# print(names(datExpr))#会返回所有在分析中的基因ID
names(datExpr)[moduleColors=="turquoise"]#返回属于棕色模块的基因ID
annot = read.csv(file = "SCZ\\brainseq_genedetail.csv"); #输入注释文件
dim(annot)
names(annot)
probes = names(datExpr) # 匹配信息
# print(probes)
probes2annot = match(probes, annot$ensemblID);
print(sum(is.na(probes2annot))) # 检测是否有没有匹配上的ID号，正常来说为0，即全匹配上了。
# 输出必要的信息：
geneInfo0 = data.frame(substanceBXH = probes,
                       geneSymbol = annot$Symbol[probes2annot],
                       LocusLinkID = annot$EntrezID[probes2annot],
                       moduleColor = moduleColors,
                       geneTraitSignificance,
                       GSPvalue);
 # 按照与体重的显著水平将模块进行排序:
modOrder = order(-abs(cor(MEs, DiseaseCondition, use = "p")));
# 添加模块成员的信息：
for (mod in seq_len(ncol(geneModuleMembership)))
{
  oldNames = names(geneInfo0)
  geneInfo0 = data.frame(geneInfo0, geneModuleMembership[, modOrder[mod]],
                         MMPvalue[, modOrder[mod]]);
  names(geneInfo0) = c(oldNames, paste("MM.", modNames[modOrder[mod]], sep=""),
                       paste("p.MM.", modNames[modOrder[mod]], sep=""))
}
geneOrder = order(geneInfo0$moduleColor, -abs(geneInfo0$GS.is_diseased));  # 排序
geneInfo = geneInfo0[geneOrder, ]
# 输出为CSV格式：
write.csv(geneInfo, file = "geneInfo.csv")


# 4.	GO富集分析
# 4.1	 输出基因列表供metascape使用

annot = read.csv(file = "SCZ\\brainseq_genedetail.csv");
probes = names(datExpr);
probes2annot = match(probes, annot$ensemblID);
allgenes = annot$Symbol[probes2annot];
allLLIDs = annot$EntrezID[probes2annot];
intModules = c("turquoise") # 根据自己实验得到的颜色修改
for (module in intModules)
{
  # Select module probes
  modGenes = (moduleColors==module);
  # Get their entrez ID codes
  modLLIDs = allLLIDs[modGenes];
  # Write them into a file
  fileName = paste("geneSymbol-", module, ".txt", sep="");
  write.table(as.data.frame(modLLIDs), file = fileName,
              row.names = FALSE, col.names = FALSE,quote=F)
}
