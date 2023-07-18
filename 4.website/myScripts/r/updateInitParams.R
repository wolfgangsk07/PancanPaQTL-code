library(rjson)
InitParams<-list()


#================InitParams
#更新癌种信息
SNPanno<-read.delim("/database/1_16T/GDC/TCGA_genotype_txt/annotation.txt")
cancerTypes_mat<-SNPanno[!duplicated(SNPanno$project_id),]
cancerTypes_mat<-cancerTypes_mat[order(cancerTypes_mat$project_id),]
InitParams$cancerTypes<-c("TCGA-ALL",cancerTypes_mat$project_id)
InitParams$cancerTypes_short<-gsub("TCGA-","",InitParams$cancerTypes)
InitParams$cancerTypes_full<-c("All cancers",cancerTypes_mat$disease_type)


#统计数据

cancerTypes<-unique(SNPanno$project_id)
InitParams$sampleCount<-list()
InitParams$gsea$count<-list()
for(cancerType in cancerTypes){
	cancerType<-gsub("TCGA-","",cancerType)
	f<-pipe(paste0("zcat data/aligned_proAc/TCGA-",cancerType,".gz|head -1|awk 'BEGIN{FS=\"\\t\"}{print NF}'"))
	InitParams$sampleCount[[cancerType]]<-as.numeric(readLines(f))-1
	close(f)
	
	f<-pipe(paste0("zcat data/totaleqtl/TCGA-",cancerType,"_cis.gz|sed '1d'|wc -l"))
	InitParams$cis_QTL_Count[[cancerType]]<-as.numeric(readLines(f))
	close(f)
	
	f<-pipe(paste0("zcat data/totaleqtl/TCGA-",cancerType,"_trans.gz|sed '1d'|wc -l"))
	InitParams$trans_QTL_Count[[cancerType]]<-as.numeric(readLines(f))
	close(f)
	
	f<-pipe(paste0("zcat data/survival/TCGA-",cancerType,"_*.gz|wc -l"))
	InitParams$survival[[cancerType]]<-as.numeric(readLines(f))-2
	close(f)
	
	f<-pipe(paste0("zcat data/gwas_eqtl/TCGA-",cancerType,"_*.gz|wc -l"))
	InitParams$gwasqtl[[cancerType]]<-as.numeric(readLines(f))-2
	close(f)
	
	f<-pipe(paste0("zcat data/drugs/TCGA-",cancerType,"_*.gz|wc -l"))
	InitParams$drugs[[cancerType]]<-as.numeric(readLines(f))-2
	close(f)

	f<-pipe(paste0("zcat data/immune/TCGA-",cancerType,"_*.gz|wc -l"))
	InitParams$immune[[cancerType]]<-as.numeric(readLines(f))-2
	close(f)
}
InitParams$totalSampleCount<-sum(unlist(InitParams$sampleCount))




#更新四个表格的特异性数据
#drugNames

f<-pipe("zcat data/drugs/TCGA-ALL_*.gz|awk -F \"\\t\" '{print $10}'|sort|uniq")
drugNames<-readLines(f)
drugNames<-drugNames[order(drugNames)]
InitParams$drugNames<-drugNames[drugNames!="Drug name"]
close(f)

f<-pipe("zcat data/drugs/TCGA-ALL_*.gz|awk -F \"\\t\" '{print $12}'|sort|uniq")
pathways<-readLines(f)
pathways<-pathways[order(pathways)]
pathways<-pathways[pathways!=""]
InitParams$pathways<-pathways[pathways!="Target pathway"]
close(f)

f<-pipe("zcat data/immune/TCGA-ALL_*.gz|awk -F \"\\t\" '{print $10}'|sort|uniq")
cellNames<-readLines(f)
cellNames<-cellNames[order(cellNames)]
InitParams$cellNames<-cellNames[cellNames!="Immune cell"]
close(f)

f<-pipe("zcat data/immune/TCGA-ALL_*.gz|awk -F \"\\t\" '{print $11}'|sort|uniq")
Sources<-readLines(f)
InitParams$Sources<-Sources[Sources!="Source"]
close(f)


write(toJSON(InitParams),file="initParams.json")