tag<-commandArgs(T)[1]
short_tag<-gsub("TCGA-","",tag)
load(paste0("/backup/lr/promoterQTL/",short_tag,"/proRs_Drug.rdata"))
load(paste0("/backup/lr/promoterQTL/",short_tag,"/proPval_Drug.rdata"))
rownames(proRs_Drug)<-gsub("id_","prmtr_",rownames(proRs_Drug))
for(i in 1:nrow(proRs_Drug)){
	proid<-rownames(proRs_Drug)[i]
	for(j in 1:ncol(proRs_Drug)){
		drugname<-colnames(proRs_Drug)[j]
		drugname<-strsplit(drugname,"_")[[1]][1]
		if(proPval_Drug[i,j]<5e-4){
			writeLines(paste(c(proid,drugname,sprintf("%.2g",proRs_Drug[i,j]),sprintf("%.4g",proPval_Drug[i,j])),collapse="\t"),stdout())
		}
	}
}