library(edgeR)
library(limma)
library(baySeq)
library(DESeq2)

# 3. 载入数据
setwd() # 设置自己的工作路径
rm(list = ls())
options(stringsAsFactors = F)
counts <- read.csv("SCZ\\SCZ_count_data.csv", row.names=1) # 替换为你的文件
head(counts)
metadata <- read.csv("SCZ\\SCZ_count_metadata.csv") # 替换为你的文件
group <- metadata[, 'Dx']
d0 <- DGEList(counts=counts,group=group) # 创建DGEList对象
# print(d0)

# 4. 过滤表达量低的基因
d0 <- calcNormFactors(d0) # 计算标准化系数
# d0
cutoff <- 1
drop <- which(apply(cpm(d0),1,max) < cutoff)
d <- d0[-drop,]
dim(d) # 返回过滤后的样本

# 5. 绘制多维尺度分析图
png("plotMDS.png")
plotMDS(d, col = as.numeric(group))
dev.off()

# 6. Voom 转换：counts转换为log2(CPM)
mm <- model.matrix(~0 + group)
# 绘制log2-标准差图 图片保存并上传
png("plotVoom.png")
y <- voom(d, mm, plot = T)
dev.off()

# 7. Limma工具拟合线性模型
fit <- lmFit(y,mm)
head(coef(fit))
# 对比control, treated的差异表达
contr <- makeContrasts(groupControl-groupSchizo, levels = colnames(coef(fit)))
# 差异值估计
tmp <- contrasts.fit(fit,contr)
# 贝叶斯平滑
tmp <- eBayes(tmp)
# 排序并截图保存
top.table <- topTable(tmp, sort.by = "P", n = Inf)
print(head(top.table, 20))
nrDEG_limma <- top.table[,c(1,5)]

# 8. GLM（广义线性模型）方差估计
d1 <- estimateGLMCommonDisp(d,mm)
d1 <- estimateGLMTrendedDisp(d1,mm, method="power") # 平方估计
d1 <- estimateGLMTagwiseDisp(d1,mm)
# 图片保存并上传
png("plotBCV.png")
plotBCV(d1)
dev.off()

# 9. GLM差异表达分析
fit1 <- glmFit(d1,mm)
# 对比control, treated的差异表达
lrt <- glmLRT(fit1, contrast = c(1,-1))
# 排序并截图保存
nrDEG_edgeR <- topTags(lrt, n = nrow(d1))
print(head(nrDEG_edgeR))
# 取表达差异倍数和FDR值两列
nrDEG_edgeR <- nrDEG_edgeR[,c(1,5)]

# 10. 提取过滤后的表达数据，构建DESEQDataSet对象
countData <- getCounts(d)
dds <- DESeqDataSetFromMatrix(countData=countData, colData=metadata, design=~Dx, tidy=FALSE)

# 11. 运行DESeq2
dds <- DESeq(dds)
res <- results(dds)
# 排序并截图保存
nrDEG_DESeq2 <- res[order(res$padj),]
print(head(nrDEG_DESeq2))
# 取表达差异倍数和padj值两列
nrDEG_DESeq2 <- nrDEG_DESeq2[,c(2,6)]

# 12. 计算三个差异分析结果相关性
geneLists <-unique(c(rownames(nrDEG_limma),rownames(nrDEG_edgeR),rownames(nrDEG_DESeq2)))
# 合并三个差异分析结果
DEGLists <- data.frame(limma=nrDEG_limma[geneLists,1], edgeR=nrDEG_edgeR[geneLists,1], DESeq2=nrDEG_DESeq2[geneLists,1])
# 计算相关性
DEGLists_cor <- cor(DEGLists)
print(DEGLists_cor)
