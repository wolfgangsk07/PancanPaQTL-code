
MatrixEQTL<-function(SNP_file_name=SNP_file_name,expression_file_name=expression_file_name,covariates_file_name=covariates_file_name,c){
	####设置####
	# 使用modelLINEAR模型
	useModel = modelLINEAR; # modelANOVA, modelLINEAR, or modelLINEAR_CROSS

	#输出文件名，分为顺式和反式
	#output_file_name_cis = tempfile(); #顺式
	#output_file_name_tra = tempfile(); #反式
	output_file_name_cis = gzfile(paste0("cis/part_",c,".gz.tmp"),"w"); #顺式
	output_file_name_tra = gzfile(paste0("trans/part_",c,".gz.tmp"),"w"); #反式
	# 只有在高于阈值重要的gene-SNP关联对才会被保存
	pvOutputThreshold_cis = 0.05;
	pvOutputThreshold_tra = 0.0001
	 
	# 误差协方差矩阵
	#设置为numeric()
	errorCovariance = numeric();
	# errorCovariance = read.table("Sample_Data/errorCovariance.txt");
	 
	# Distance for local gene-SNP pairs
	cisDist = 1e6;
	 
	##加载基因型数据
	snps = SlicedData$new();
	snps$fileDelimiter = "\t";       # 指定SNP文件的分隔符Tab键
	snps$fileOmitCharacters = "NA"; #定义缺失值;
	snps$fileSkipRows = 1;        #跳过第一行（适用于第一行是列名的情况）
	snps$fileSkipColumns = 1;     #跳过第一列（适用于第一列是SNP ID的情况）
	snps$fileSliceSize = 2000;      #每次读取2000条数据
	snps$LoadFile(SNP_file_name); #载入SNP文件

	
	## 加载基因表达量数据
	gene = SlicedData$new();
	gene$fileDelimiter = "\t";
	gene$fileOmitCharacters = "NA"; 
	gene$fileSkipRows = 1; 
	gene$fileSkipColumns = 1; 
	gene$fileSliceSize = 2000; 
	gene$LoadFile(expression_file_name);
	 
	## 加载协变量
	cvrt = SlicedData$new();
	cvrt$fileDelimiter = "\t"; 
	cvrt$fileOmitCharacters = "NA";
	cvrt$fileSkipRows = 1; 
	cvrt$fileSkipColumns = 1;
	if(length(covariates_file_name)>0) {
	  cvrt$LoadFile(covariates_file_name);
	}
	writeLines(as.character(as.numeric(gene$nRows())*as.numeric(snps$nRows())),paste0("trans/totalcounts_",c,".txt"))
	## 运行分析
	me<-Matrix_eQTL_main(
	  snps = snps, 
	  gene = gene, 
	  cvrt = cvrt,
	  output_file_name  = output_file_name_tra,
	  pvOutputThreshold = pvOutputThreshold_tra,
	  useModel = useModel, 
	  errorCovariance = errorCovariance, 
	  verbose = TRUE, 
	  output_file_name.cis = output_file_name_cis,
	  pvOutputThreshold.cis = pvOutputThreshold_cis,
	  snpspos = snpspos, 
	  genepos = genepos,
	  cisDist = cisDist,
	  pvalue.hist = "qqplot",
	  min.pv.by.genesnp = FALSE,
	  noFDRsaveMemory = TRUE);
	close(output_file_name_cis)
	close(output_file_name_tra)
	system(paste0("mv ","cis/part_",c,".gz.tmp"," ","cis/part_",c,".gz"))
	system(paste0("mv ","trans/part_",c,".gz.tmp"," ","trans/part_",c,".gz"))
	#unlink(output_file_name_tra);
	#unlink(output_file_name_cis);

	#me$cis$eqtls$FDR<-p.adjust(me$cis$eqtls$pvalue,method="fdr")
	#me$trans$eqtls$FDR<-p.adjust(me$trans$eqtls$pvalue,method="fdr")
	#return(list(cis=me$cis$eqtls[me$cis$eqtls$FDR<0.05,],trans=me$trans$eqtls[me$trans$eqtls$FDR<0.05,]))
	#return(list(cis=me$cis$eqtls,trans=me$trans$eqtls))
}


setwd("/backup/wdy/Projects/promoterActiv-qtl/totalQTL")


## 读取基因型和基因位置文件
#print("Loading gene and snp location file")
snpspos = read.table(gzfile("./gene_snp_loc/snploc.gz"), header = TRUE, stringsAsFactors = FALSE);
genepos = read.table(gzfile("./gene_snp_loc/geneloc.gz"), header = TRUE, stringsAsFactors = FALSE);

c<-commandArgs(T)[1]
library(MatrixEQTL) #加载R包
#print(paste0("============",c))
SNP_file_name<-paste0(paste0(getwd(),"/aligned_SNPs/"),c,".txt")
expression_file_name<-paste0(paste0(getwd(),"/aligned_proAc/"),c,".txt")
covariates_file_name<-paste0(paste0(getwd(),"/aligned_Covariates/"),c,".txt")
MatrixEQTL(SNP_file_name,expression_file_name, covariates_file_name,c)
#write.table(res$cis,file=paste0("cis/",c,".txt"),quote=FALSE,sep="\t",col.names=TRUE,row.names=FALSE)
#write.table(res$trans,file=paste0("trans/",c,".txt"),quote=FALSE,sep="\t",col.names=TRUE,row.names=FALSE)



