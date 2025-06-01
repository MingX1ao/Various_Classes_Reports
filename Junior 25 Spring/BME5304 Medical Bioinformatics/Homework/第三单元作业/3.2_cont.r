setwd() # 设定工作路径
library(WGCNA)
options(stringsAsFactors = FALSE)  #开启多线程
femData = read.csv("data\\LiverMale3600.csv") #载入基因表达量数据，按学号末位，载入“Female3600.csv” 或 “Male3600.csv”
#查看表达矩阵中的信息（基因名称基因表达量等）
dim(femData)
names(femData)

# 提取出表达量的数据，删去不重要的数据
datExpr0 = as.data.frame(t(femData[, -c(1:8)]))  #提取加转置
names(datExpr0) = femData$substanceBXH #查看基因名字
rownames(datExpr0) = names(femData)[-c(1:8)]  #查看样品名字

# print(rownames(datExpr0)) #查看前四个基因名字



gsg = goodSamplesGenes(datExpr0, verbose = 3);
print(gsg$allOK) # 若返回TRUE则证明没有缺失值
# 聚类所有样本，观察是否有离群值或异常值。
sampleTree = hclust(dist(datExpr0), method = "average")
sizeGrWindow(12,9) #视图
par(cex = 0.6);
par(mar = c(0,4,2,0))
plot(sampleTree, main = "Sample clustering to detect outliers", sub="", xlab="", cex.lab = 1.5, cex.axis = 1.5, cex.main = 2)
# 去除离群值
abline(h = 15, col = "red") #划定需要剪切的枝长
clust = cutreeStatic(sampleTree, cutHeight = 15, minSize = 10)
# 这时候会从高度为15这里横切，把离群样本分开
table(clust)   
keepSamples = (clust==1)  #保留非离群(clust==1)的样本
datExpr = datExpr0[keepSamples, ]  #去除离群值后的数据
nGenes = ncol(datExpr)
nSamples = nrow(datExpr)

traitData = read.csv("data\\ClinicalTraits.csv");
dim(traitData)  # 行是样本，列是信息
names(traitData)
allTraits = traitData[, -c(31, 16)];
allTraits = allTraits[, c(2, 11:36) ];  #只保留数值型数据
dim(allTraits)
names(allTraits)
# 匹配表型数据和基因表达量数据并可视化
femaleSamples = rownames(datExpr);
traitRows = match(femaleSamples, allTraits$Mice);
datTraits = allTraits[traitRows, -1];
rownames(datTraits) = allTraits[traitRows, 1];
collectGarbage()
sampleTree2 = hclust(dist(datExpr), method = "average")
traitColors = numbers2colors(datTraits, signed = FALSE) #用颜色代表关联
plotDendroAndColors(sampleTree2, traitColors,
                    groupLabels = names(datTraits),
                    main = "Sample dendrogram and trait heatmap")

################

enableWGCNAThreads()  #Windows系统开启多线程
#allowWGCNAThreads()  #MAC开启多线程
powers = c(c(1:10), seq(from = 12, to=20, by=2))
sft = pickSoftThreshold(datExpr, powerVector = powers, verbose = 5)
sft$powerEstimate #系统自动返回合适的软阈值，这里仅介绍此种方法

# 在power中输入上一步的软阈值
net = blockwiseModules(datExpr, power = 6, TOMType = "unsigned", minModuleSize = 30, reassignThreshold = 0, mergeCutHeight = 0.25,  numericLabels = TRUE, pamRespectsDendro = FALSE, saveTOMs = TRUE,  saveTOMFileBase = "femaleMouseTOM", verbose = 3)
load("femaleMouseTOM-block.1.RData") #载入TOM矩阵
write.table(TOM,"TOM.txt")  #保留TOM值文档（在文件夹中打开femaleMouseTOM，不然会报错）
#minModuleSize：模块中最少的基因数
#mergeCutHeight ：模块合并阈值，阈值越大，模块越少（重要）
#saveTOMs = TRUE,saveTOMFileBase = "femaleMouseTOM"保存TOM矩阵，名字为"femaleMouseTOM"
#net$colors 包含模块分配，net$MEs 包含模块的模块特征基因。

# 绘制模块标识的层次聚类树状图，并保存
table(net$colors)
sizeGrWindow(12, 9)
mergedColors = labels2colors(net$colors)
png("Cluster Dendrogram.jpg")
plotDendroAndColors(net$dendrograms[[1]], mergedColors[net$blockGenes[[1]]], "Module colors", dendroLabels = FALSE, hang = 0.03, addGuide = TRUE, guideHang = 0.05)
dev.off()
# 查看划分的模块数和每个模块里面包含的基因个数，记录分块基因信息
moduleLabels = net$colors
moduleColors = labels2colors(net$colors)
MEs = net$MEs
geneTree = net$dendrograms[[1]]


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
png("Module-trait relationship.jpg", width = 800, height = 600)
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



total_fat = as.data.frame(datTraits$total_fat);
names(total_fat) = "total_fat";
modNames = substring(names(MEs), 3)
geneModuleMembership = as.data.frame(cor(datExpr, MEs, use = "p"));
MMPvalue = as.data.frame(corPvalueStudent(as.matrix(geneModuleMembership), nSamples));
names(geneModuleMembership) = paste("MM", modNames, sep="");
names(MMPvalue) = paste("p.MM", modNames, sep="");
geneTraitSignificance = as.data.frame(cor(datExpr, total_fat, use = "p"));# 和体重性状的关联
GSPvalue = as.data.frame(corPvalueStudent(as.matrix(geneTraitSignificance), nSamples));
names(geneTraitSignificance) = paste("GS.", names(total_fat), sep="");
names(GSPvalue) = paste("p.GS.", names(total_fat), sep="");



module = "turquoise"; # 选择模块
column = match(module, modNames);
moduleGenes = moduleColors==module;
sizeGrWindow(7, 7);
par(mfrow = c(1,1));
# 绘制MM-GS图，并保存
png("module_gene.jpg", width = 800, height = 600)
verboseScatterplot(abs(geneModuleMembership[moduleGenes, column]),
                   abs(geneTraitSignificance[moduleGenes, 1]),
                   xlab = paste("Module Membership in", module, "module"),
                   ylab = "Gene significance for body total_fat",
                   main = paste("Module membership vs. gene significance\n"),
                   cex.main = 1.2, cex.lab = 1.2, cex.axis = 1.2, col = module)
dev.off()


names(datExpr)#会返回所有在分析中的基因ID
names(datExpr)[moduleColors=="turquoise"]#返回属于棕色模块的基因ID
annot = read.csv(file = "data\\GeneAnnotation.csv"); #输入注释文件
dim(annot)
names(annot)
probes = names(datExpr) # 匹配信息
probes2annot = match(probes, annot$substanceBXH);
sum(is.na(probes2annot)) # 检测是否有没有匹配上的ID号，正常来说为0，即全匹配上了。
# 输出必要的信息：
geneInfo0 = data.frame(substanceBXH = probes,
                       geneSymbol = annot$gene_symbol[probes2annot],
                       LocusLinkID = annot$LocusLinkID[probes2annot],
                       moduleColor = moduleColors,
                       geneTraitSignificance,
                       GSPvalue);
 # 按照与体重的显著水平将模块进行排序:
 modOrder = order(-abs(cor(MEs, total_fat, use = "p")));
 # 添加模块成员的信息：
 for (mod in seq_len(ncol(geneModuleMembership)))
{
  oldNames = names(geneInfo0)
  geneInfo0 = data.frame(geneInfo0, geneModuleMembership[, modOrder[mod]],
                         MMPvalue[, modOrder[mod]]);
  names(geneInfo0) = c(oldNames, paste("MM.", modNames[modOrder[mod]], sep=""),
                       paste("p.MM.", modNames[modOrder[mod]], sep=""))
}
geneOrder = order(geneInfo0$moduleColor, -abs(geneInfo0$GS.total_fat));  # 排序
geneInfo = geneInfo0[geneOrder, ]
# 输出为CSV格式：
write.csv(geneInfo, file = "geneInfo.csv")


# 4.1 输出基因列表
annot = read.csv(file = "data\\GeneAnnotation.csv");
probes = names(datExpr);
probes2annot = match(probes, annot$substanceBXH);
allgenes = annot$geneSymbol[probes2annot];
allLLIDs = annot$LocusLinkID[probes2annot];
intModules = c("blue") # 根据自己实验得到的颜色修改
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
