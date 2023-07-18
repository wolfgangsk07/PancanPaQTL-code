tag<-commandArgs(T)[1]
type<-commandArgs(T)[2]
genotypes<-data.frame()

getSNP<-function(f){
	genotypes<-read.table(f,header=TRUE,check.names=FALSE)
	genotypes<-genotypes[!duplicated(genotypes[,1]),]
	rownames(genotypes)<-genotypes[,1]
	genotypes<-genotypes[,-1]
	gc()
	return(genotypes)
}


#writeLines(paste(tag,"Genotype loaded"),stderr())
anno<-read.table("/database/1_16T/GDC/TCGA_genotype_txt/annotation.txt",sep="\t")
anno<-anno[!duplicated(anno$case_id),]
rownames(anno)<-anno$case_id
anno$days_to_end<-as.numeric(anno$days)-as.numeric(anno$age_at_diagnosis)
anno<-anno[,c("vital_status","days_to_end")]
anno<-anno[!is.na(anno$days_to_end),]

#for(type in c("cis","trans")){
	res<-data.frame()
	#writeLines(paste(c("Cancer","Type","SNP","SNP position","Alleles","KM P-value","aa OS","Aa OS","AA OS"),collapse="\t"),stdout())
	qtl_tab<-read.table(paste0("data/totaleqtl/",tag,"_",type,".gz"),sep="\t",header=TRUE,check.names=FALSE)
	qtl_tab<-qtl_tab[order(qtl_tab$SNP),]
	qtl_tab<-qtl_tab[!duplicated(qtl_tab$SNP),]
	qtl_tab<-qtl_tab[order(qtl_tab$SNP),]
	print(paste(tag,"QTL loaded"))
	for(i in 1:nrow(qtl_tab)){
		snp<-qtl_tab[i,"SNP"]
		if(!snp %in% rownames(genotypes)){
			snpfile<-paste0("data/aligned_SNPs/",tag,"/",substr(snp,1,4),"_.gz")
			if(file.exists(snpfile)){
				genotypes<-getSNP(snpfile)
				#print(paste(tag,snpfile,"loaded"))
			}
			if(!snp %in% rownames(genotypes)){
				next
			}
		}
			
		genotype<-genotypes[snp,]
		
		genotype<-genotype[,!duplicated(substr(colnames(genotype),1,12))]
		colnames(genotype)<-substr(colnames(genotype),1,12)
		
	
		commonSamples<-intersect(rownames(anno),colnames(genotype))
		genotype<-genotype[,commonSamples]
		
		survival_os<-c()
		
		for(j in 0:2){
			case_id<-colnames(genotype)[genotype==j]
			sub_anno<-anno[case_id,]
			sub_anno<-sub_anno[!is.na(sub_anno$days_to_end),]
			val<-round(median(sub_anno[sub_anno$vital_status==1,"days_to_end"])/365,2)
			if(is.na(val)){
				val<-"-"
			}
			survival_os<-c(survival_os,val)
			
		}
		surv_anno<-anno[commonSamples,]
		
		survivaldata<-data.frame(surv=surv_anno$vital_status  ,surv.time=surv_anno$days_to_end/365,group=as.numeric(genotype[1,]))
		survfit <-survival::survfit(survival::Surv(surv.time , surv)~group,data=survivaldata)
		pval<-survminer::surv_pvalue(survfit,data=survivaldata)$pval
		if(pval>0.08)next
		res[i,c("Cancer","Type","SNP","SNP position","Alleles")]<-qtl_tab[i,1:5]
		res[i,c("KM P-value","aa OS","Aa OS","AA OS")]<-c(pval,survival_os)
		#writeLines(paste(c(qtl_tab[i,1:5],sprintf("%.4g", pval),survival_os),collapse="\t"),stdout())
	}
	res<-res[order(res$"KM P-value"),]
	res$FDR<-sprintf("%.4g",p.adjust(res$"KM P-value",method="fdr"))
	res$"KM P-value"<-sprintf("%.4g",as.numeric(res$"KM P-value"))
	res<-res[res$FDR<=0.05,]
	write.table(res,file=gzfile(paste0("data/survival/",tag,"_",type,".gz")),sep="\t",row.names=FALSE,quote=FALSE)
#}

