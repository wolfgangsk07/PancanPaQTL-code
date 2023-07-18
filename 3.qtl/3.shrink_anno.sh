
mkdir gene_snp_loc -p



if [ ! -f /database/1_16T/anno/hg38_snp151.txt.gz ];then
	axel http://hgdownload.cse.ucsc.edu/goldenPath/hg38/database/snp151.txt.gz -o /database/1_16T/anno/hg38_snp151.txt.gz
fi



echo start creating snp locs
awk 'BEGIN{
		OFS="\t"
		for(i=1;i<23;i++){
			chrs["chr"i]
		}
		chrs["chrX"]
		chrs["chrY"]
	}
	{
		if(NR==FNR){
			if($1!="snpid"){
				id[$1]
			}
		}else{
			if($2 in chrs){
				if($5 in id){
					print $0
				}
			}
		}
	}' \
<(cat aligned_SNPs/TCGA-*.txt) \
<(pigz -cd /database/1_16T/anno/hg38_snp151.txt.gz)| \
pigz>gene_snp_loc/shrinked_SNP_anno.gz
zcat gene_snp_loc/shrinked_SNP_anno.gz|wc -l

echo starting creating pro locs
awk 'BEGIN{
		OFS="\t"
		FS="\t"
	}
	{
	if(FNR!=1){
		print substr($4,4),$5,$5,"id_"$2
	
	}
	
	}' <(zcat /backup/wdy/processedData/proActiv/result/anno.txt.gz)|pigz>gene_snp_loc/shrinked_pro_anno.gz

