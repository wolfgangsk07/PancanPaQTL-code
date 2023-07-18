library(proActiv)
promoterAnnotation <- preparePromoterAnnotation(file = '/backup/wdy/processedData/genome_ref/Homo_sapiens.GRCh38.109.gtf.gz',species = 'Homo_sapiens')

files <- list.files('/backup/wdy/processedData/proActiv/junctions',full.names = TRUE)

## Promoter annotation for human genome GENCODE v34


result <- proActiv(files = files, promoterAnnotation = promoterAnnotation)

for(i in 1:length(result@assays@data@listData)){
	tag<-names(result@assays@data@listData)[i]
	write.table(result@assays@data@listData[[i]],file=gzfile(paste0("result/",tag,".txt.gz")),sep="\t",quote=FALSE)


}
anno<-data.frame(promoterId=result@elementMetadata@listData$promoterId,
	geneId=result@elementMetadata@listData$geneId,
	seqnames=result@elementMetadata@listData$seqnames,
	start=result@elementMetadata@listData$start,
	strand=result@elementMetadata@listData$strand,
	internalPromoter=result@elementMetadata@listData$internalPromoter,
	promoterPosition=result@elementMetadata@listData$promoterPosition,
	txId=sapply(result@elementMetadata@listData$txId,function(x){paste(x,collapse=",")})
	)
write.table(anno,file=gzfile("result/anno.txt.gz"),quote=FALSE,sep="\t")