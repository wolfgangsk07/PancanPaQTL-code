library(peer)
inputfile<-commandArgs(T)[1]
outputfile<-commandArgs(T)[2]
a<-read.table(inputfile)
a<-as.matrix(a)
rownames(a)<-a[,1]
colnames(a)<-a[1,]
a<-a[-1,-1]

expr<-apply(as.matrix(a),2,as.numeric)
rownames(expr)<-rownames(a)
rm(a)
gc()
expr<-t(expr)
dim(expr)
model = PEER()   #创建模型
PEER_setPhenoMean(model,as.matrix(expr))
dim(PEER_getPhenoMean(model))
PEER_setNk(model,15)   #文献推荐factors数目为样本量的1/4
PEER_getNk(model)
PEER_setNmax_iterations(model,1000)
PEER_update(model)  #Converged (var(residuals)) after 8 iterations
factors = PEER_getX(model)
rownames(factors)<-rownames(expr)
colnames(factors)<-paste0("factor",1:ncol(factors))
write.table(factors,file=outputfile,quote=FALSE)

