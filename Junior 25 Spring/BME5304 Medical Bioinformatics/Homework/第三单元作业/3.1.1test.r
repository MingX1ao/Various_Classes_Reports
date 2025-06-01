setwd() # 设置自己的工作路径
rm(list = ls())
options(stringsAsFactors = F)
counts <- read.csv("data\\all_counts.csv",row.names=1) # 替换为你的文件
head(counts)
metadata <- read.csv("data\\all_counts_metadata.csv") # 替换为你的文件
group <- metadata[,'dex']
d0 <- DGEList(counts=counts,group=group) # 创建DGEList对象
d0

d0 <- calcNormFactors(d0) # 计算标准化系数
d0
cutoff <- 1
drop <- which(apply(cpm(d0),1,max) < cutoff)
d <- d0[-drop,]
dim(d) # 返回过滤后的样本

mm <- model.matrix(~0 + group)
# 绘制log2-标准差图 图片保存并上传
y <- voom(d, mm, plot = T)
dev.off()


fit <- lmFit(y,mm)
head(coef(fit))
# 对比control, treated的差异表达
contr <- makeContrasts(groupcontrol-grouptreated, levels = colnames(coef(fit)))
# 差异值估计
tmp <- contrasts.fit(fit,contr)
# 贝叶斯平滑
tmp <- eBayes(tmp)
# 排序并截图保存
top.table <- topTable(tmp, sort.by = "P", n = Inf)
print(head(top.table, 20))
