anno<-read.table("data/genotype_annotion.txt",sep="\t")
anno$short_sampleid<-substr(anno$sample_id,1,15)
anno<-anno[!duplicated(anno$short_sampleid),]
rownames(anno)<-anno$short_sampleid
cancerTypes<-unique(anno$project_id)


immune_res<-read.table("/backup/lgx/promoter/TCGA_Immune_infiltration.gz",sep="\t",check.names=FALSE)
for(cancer in cancerTypes){
	sub_anno<-anno[anno$project_id==cancer,]
	commonSamples<-intersect(rownames(sub_anno),rownames(immune_res))
	sub_immune<-immune_res[commonSamples,]
	sub_immune<-t(sub_immune)
	write.table(sub_immune,gzfile(paste0("data/immune_matrix/",cancer,".gz")),sep="\t",quote=FALSE)
}