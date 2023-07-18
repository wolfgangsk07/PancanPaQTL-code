awk 'BEGIN{
		OFS="\t"
	}{
	if(FILENAME==ARGV[1]){

		gene[$4]

	}else{
		if(FNR==1){
			print $0>FILENAME".include"
		}else{
			if($1 in gene){
				print $0>FILENAME".include"
			}else{
				print $0>FILENAME".exclude"
			}
		}
	}
}' \
<(pigz -cd gene_snp_loc/shrinked_pro_anno.gz) \
aligned_proAc/TCGA*.txt
for file in aligned_proAc/TCGA*.txt.include
do
	mv $file ${file%.*}
done



awk 'BEGIN{
		OFS="\t"

	}{
	if(FILENAME==ARGV[1]){

		gene[$5]

	}else{
		if(FNR==1){
			print $0>FILENAME".include"
		}else{
			if($1 in gene){
				print $0>FILENAME".include"
			}else{
				print $0>FILENAME".exclude"
			}
		}
	}
}' \
<(pigz -cd gene_snp_loc/shrinked_SNP_anno.gz) \
aligned_SNPs/TCGA*.txt
for file in aligned_SNPs/TCGA*.txt.include
do
	mv $file ${file%.*}
done
