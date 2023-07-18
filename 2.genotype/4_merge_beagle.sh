#下载1000G
chrs=({1..22})
chrs[23]=X


#将012转换成vcf文件
cancerTypes=`cat /database/1_16T/GDC/TCGA_genotype_txt/annotation.txt|sed "1d"|awk -F '\t' '{print $8}'|sort|uniq`
for cancer in ${cancerTypes[@]}
do
	echo ${cancer}

	zcat ./beagle_tmp/${cancer}_*.gt.vcf.gz|sed '/^##/d'|awk '{
	if(FNR!=1){
		if(substr($1,1,1)!="#"){
			print $0
		}
	}else{
		print $0
	}
	}'|plink --vcf /dev/stdin --snps-only -geno 0.05 -mind 0.05 -maf 0.05 -hwe 0.0001 --recode vcf-iid --out ./beagle_tmp/${cancer}&& \
	
	cat ./beagle_tmp/${cancer}.vcf|sed '/^##/d'|awk '{
		#mergebeagle
		if(FNR==1){
			header="snpid"
			for(i=10;i<=NF;i++){
				header=header"\t"$i
			}
			print header
		}else{
			if(length($4)==1 && length($5)==1 && index($3,";")==0){
				gt=$3
				for(i=10;i<=NF;i++){
					gt1=substr($i,1,3)
					if(gt1=="0/0"){
						gt1=0
					}else if(gt1=="1/0"){
						gt1=1
					}else if(gt1=="0/1"){
						gt1=1
					}else if(gt1=="1/1"){
						gt1=2
					}else{
						next
					}
					gt=gt"\t"gt1
				}
				print gt
			}
		}
	
	}'|pigz>./result/imputed_${cancer}.txt.gz.tmp&&\
	mv ./result/imputed_${cancer}.txt.gz.tmp ./result/imputed_${cancer}.txt.gz&
	while :
	do
		if [ `ps -aux|grep -v grep|grep plink|wc -l` -lt 18 ];then
			break
		fi
		sleep 1
	done
	
done