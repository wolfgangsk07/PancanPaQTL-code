cancerTypes=`cat /database/1_16T/GDC/TCGA_genotype_txt/annotation.txt|sed "1d"|awk -F '\t' '{print $8}'|sort|uniq`




for cancer in ${cancerTypes[@]}
do
	if [ -f ./result/$cancer.gz ];then
		
		awk '{
			FS="\t"
			OFS="\t"
			if(FNR==NR){
				anno[$3]=$9
			}else{
				if(FNR==1){
					for(i=2; i<=NF; i++){
						if(anno[$i] in done){
							
							$i=anno[$i]"-dup-"i
						}else{
							$i=anno[$i]
						}
						done[$i]=$i
					}
					
				}
				print $0
			}
			
		
		
		}'\
		<(cat /database/1_16T/GDC/TCGA_genotype_txt/annotation.txt|sed "1d")\
		<(zcat ./result/$cancer.gz|awk '{OFS="\t";if(FNR==1){$1="snpid"};if($1!="---" && $1!="rs12635398"){$1=$1;print $0}}')|gzip\
		>./result/anno_${cancer}.gz.tmp&&mv ./result/anno_${cancer}.gz.tmp ./result/anno_${cancer}.gz&
	fi
	
done