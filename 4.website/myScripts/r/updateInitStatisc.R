library(rjson)
InitParams<-list()


#================InitParams
#更新癌种信息
SNPanno<-read.delim("/database/1_16T/GDC/TCGA_genotype_txt/annotation.txt")
cancerTypes_mat<-SNPanno[!duplicated(SNPanno$project_id),]
cancerTypes_mat<-cancerTypes_mat[order(cancerTypes_mat$project_id),]
stats<-data.frame(Cancer=cancerTypes_mat$project_id,"FullName"=cancerTypes_mat$disease_type)



#统计数据

for(i in 1:nrow(stats)){
	cancerType<-gsub("TCGA-","",stats[i,1])
	f<-pipe(paste0("zcat data/aligned_proAc/TCGA-",cancerType,".gz|head -1|awk 'BEGIN{FS=\"\\t\"}{print NF}'"))
	stats[i,"SampleSize"]<-as.numeric(readLines(f))-1
	close(f)
	
	f<-pipe(paste0("zcat data/totaleqtl/TCGA-",cancerType,"_cis.gz|sed '1d'|wc -l"))
	stats[i,"CisPairs"]<-as.numeric(readLines(f))
	close(f)
	
	
	f<-pipe(paste0("zcat data/totaleqtl/TCGA-",cancerType,"_cis.gz|sed '1d'|awk '{print $3}'|sort|uniq|wc -l"))
	stats[i,"CisPuQTLs"]<-as.numeric(readLines(f))
	close(f)
	
	f<-pipe(paste0("zcat data/totaleqtl/TCGA-",cancerType,"_cis.gz|sed '1d'|awk '{print $6}'|sort|uniq|wc -l"))
	stats[i,"CisPromoters"]<-as.numeric(readLines(f))
	close(f)
	
	
	f<-pipe(paste0("zcat data/totaleqtl/TCGA-",cancerType,"_trans.gz|sed '1d'|wc -l"))
	stats[i,"TransPairs"]<-as.numeric(readLines(f))
	close(f)
	
	
	f<-pipe(paste0("zcat data/totaleqtl/TCGA-",cancerType,"_trans.gz|sed '1d'|awk '{print $3}'|sort|uniq|wc -l"))
	stats[i,"TransPuQTLs"]<-as.numeric(readLines(f))
	close(f)
	
	f<-pipe(paste0("zcat data/totaleqtl/TCGA-",cancerType,"_trans.gz|sed '1d'|awk '{print $6}'|sort|uniq|wc -l"))
	stats[i,"TransPromoters"]<-as.numeric(readLines(f))
	close(f)
	
	

	
	f<-pipe(paste0("zcat data/survival/TCGA-",cancerType,"_*.gz|wc -l"))
	stats[i,"SurvivalPuQTLs"]<-as.numeric(readLines(f))-2
	close(f)
	
	f<-pipe(paste0("zcat data/gwas_eqtl/TCGA-",cancerType,"_*.gz|wc -l"))
	stats[i,"GWASPuQTLs"]<-as.numeric(readLines(f))-2
	close(f)
	
	f<-pipe(paste0("zcat data/drugs/TCGA-",cancerType,"_*.gz|wc -l"))
	stats[i,"DrugPuQTLs"]<-as.numeric(readLines(f))-2
	close(f)

	f<-pipe(paste0("zcat data/immune/TCGA-",cancerType,"_*.gz|awk -F \"\\t\" '{if($11==\"TIMER\"){print $0}}'|wc -l"))
	stats[i,"ImmunePuQTLs-TIMER"]<-as.numeric(readLines(f))
	close(f)
	
	f<-pipe(paste0("zcat data/immune/TCGA-",cancerType,"_*.gz|awk -F \"\\t\" '{if($11==\"ImmuCellAI\"){print $0}}'|wc -l"))
	stats[i,"-ImmuCellAI"]<-as.numeric(readLines(f))
	close(f)
	
	f<-pipe(paste0("zcat data/immune/TCGA-",cancerType,"_*.gz|awk -F \"\\t\" '{if($11==\"MCPCOUNTER\"){print $0}}'|wc -l"))
	stats[i,"-MCPCOUNTER"]<-as.numeric(readLines(f))
	close(f)
}

write.table(stats,file="stats.txt",quote=FALSE,sep="\t",row.names=FALSE)