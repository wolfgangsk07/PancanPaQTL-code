ls result/imputed_*.txt.gz|while read gz
do
tag=`echo ${gz}|sed 's/result\/imputed_//g'|sed 's/.txt.gz//g'`
zcat result/imputed_$tag.txt.gz|awk 'BEGIN{FS="\t";OFS="\t"}
{
		if(FNR==1){
			#firstcolnames
			print $0
		}else{
			a0=0
			a1=0
			a2=0
			for(i=2;i<=NF;i++){
				if($i==0){
					a0+=1
				}else if($i==1){
					a1+=1
				}else{
					a2+=1
				}
			}
			if(a0>=a1 && a0<=a2){
				secali=a0
			}else if(a1>=a0 && a1<=a2){
				secali=a1
			}else{
				secali=a2
			}
			if(secali/(a0+a1+a2)>0.05){
				print $0
			}
		}
	
	
	}'|pigz>result/maf_imputed_$tag.gz.tmp&&\
	mv result/maf_imputed_$tag.gz.tmp result/maf_imputed_$tag.gz&
	
done