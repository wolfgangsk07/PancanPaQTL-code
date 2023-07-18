library(ggplot2)
library(ggrepel)

inputfile<-commandArgs(T)[1]
outputfile<-commandArgs(T)[2]
print("reading file")
a<-read.table(inputfile)
print("Prepare b")
a<-as.matrix(a)
#a<-a[a[,2]!="---",]
#a<-a[!duplicated(a[,1]),]
rownames(a)<-a[,1]
colnames(a)<-a[1,]
a<-a[-1,-1]
b<-apply(as.matrix(a),2,as.numeric)
rownames(b)<-rownames(a)
rm(a)
gc()

iris_input<-t(b)
rm(b)
gc()
print("Calculating PCA")
iris_input<-iris_input[,apply(iris_input, 2, var, na.rm=TRUE) != 0]
pca1 <- prcomp(iris_input,center = TRUE,scale. = TRUE)
df1 <- pca1$x
df1 <- as.data.frame(df1)
write.table(df1,file=outputfile,quote=FALSE)