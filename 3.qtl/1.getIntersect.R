onlytag=commandArgs(T)[1]
setwd("/backup/wdy/Projects/promoterActiv-qtl/totalQTL")
library(data.table)
snpdir<-"/backup/wdy/processedData/TCGA_genotype/result"
proAcDir<-"/backup/wdy/processedData/proActiv/result/annoed/absolutePromoterActivity_filtered"
tags<-dir(snpdir)
tags<-tags[grep("imputed_",tags)]
tags<-tags[grep(".txt.gz",tags)]
tags<-gsub("imputed_","",tags)
tags<-gsub(".txt.gz","",tags)
dir.create("aligned_SNPs")
dir.create("aligned_proAc")
#dir.create("aligned_Covariates")
for(tag in tags){

	print(paste0("============",tag))
	#snpinput<-fread(paste0(snpdir,"/imputed_",tag,".txt.gz"),nrows=0)
	snpinput<-as.character(read.table(pipe(paste0("zcat ",snpdir,"/imputed_",tag,".txt.gz|head -1"))))[-1]
	proAcInput<-as.character(read.table(pipe(paste0("zcat ",proAcDir,"/",tag,".gz|head -1"))))[-1]
	proAc_samples<-substr(proAcInput,1,16)
	#Covariatesinput<-fread(paste0("/backup/wdy/processedData/TCGA_genotype/Covariates/",tag,".txt"),nrows=0)
	snp_samples<-snpinput
	#co_samples<-as.character(colnames(Covariatesinput)[-1])
	common_samples<-intersect(snp_samples,proAc_samples)
	common_samples<-common_samples[substr(common_samples,14,15)!="11"]
	common_samples<-common_samples[!stringr::str_detect(common_samples,"-sub-")]
	if(length(common_samples)==0){
		next
	}
	print(paste0("newly added:",sum(substr(common_samples,14,15)!="11")-sum(substr(common_samples,14,15)=="01")))
	snp_index<-c(1,match(common_samples,snp_samples)+1)
	proAc_index<-c(1,match(common_samples,proAc_samples)+1)
	
	system(paste0("zcat ",snpdir,"/imputed_",tag,".txt.gz|awk 'BEGIN{OFS=\"\\t\";FS=\"\\t\"}{print ",paste(paste0("$",snp_index),collapse='\"\\t\"'),"}'>aligned_SNPs/",tag,".txt"))
	system(paste0("zcat ",proAcDir,"/",tag,".gz|awk 'BEGIN{OFS=\"\\t\";FS=\"\\t\"}{if(FNR==1){for(i=2;i<=NF;i++){$i=substr($i,1,16)}}print ",paste(paste0("$",proAc_index),collapse='\"\\t\"'),"}'>aligned_proAc/",tag,".txt"))
	
}