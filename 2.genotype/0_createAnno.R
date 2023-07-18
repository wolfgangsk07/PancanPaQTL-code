library(data.table)
setwd("/backup/wdy/TCGA_genotype")
if(!file.exists("/backup/wdy/genotype/scripts/SNPanno.rdata")){
	anno_full<-fread("GenomeWideSNP_6.na35.annot.csv",stringsAsFactors=FALSE)
	anno<-as.matrix(anno_full[,2])[,1]
	names(anno)<-as.matrix(anno_full[,1])[,1]
	save(anno,file="/backup/wdy/genotype/scripts/SNPanno.rdata")
}else{
	load(file="/backup/wdy/genotype/scripts/SNPanno.rdata")
}

orgSNPAnno<-as.matrix(fread(,"/database/1_16T/GDC/TCGA_genotype_txt/000bb862-6277-4041-b920-749b07df11cb/CHESS_p_TCGAb_112_347_367_NSP_GenomeWideSNP_6_B03_1438850.birdseed.data.txt"))[-1,1]
write(anno[orgSNPAnno],file="annoed.txt")