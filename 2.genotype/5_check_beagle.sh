

#将012转换成vcf文件
cancerTypes=`cat /database/1_16T/GDC/TCGA_genotype_txt/annotation.txt|sed "1d"|awk -F '\t' '{print $8}'|sort|uniq`
for cancer in ${cancerTypes[@]}
do
	echo ===========result/imputed_$cancer.txt.gz==============
	if [ -f result/imputed_$cancer.txt.gz ];then
		zcat result/imputed_$cancer.txt.gz|awk 'BEGIN{
			OFS="\t"
		}{
			if(FNR!=1){
				for (i=2;i<=NF;i++) {
					a[$i]++
				}
			}else{
				print NF-1,"samples in total"
				for(i=2;i<=NF;i++){
					types[substr($i,14,2)]++
				}
				for (i in types){
					print types[i],"\""i"\" sample types "
				}
			}
			}END {
				print NR" SNPs in total"
				for (i in a){
					print a[i],"genotypes \""i"\""
				}
			}'
	else
		echo not exists.
	fi
	
done