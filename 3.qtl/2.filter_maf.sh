ls aligned_SNPs/TCGA*.txt|while read txt
do
	tag=`echo ${txt}|sed 's/aligned_SNPs\///g'|sed 's/.txt//g'`

	echo =================$tag
	#cat aligned_piRNAs/$tag.txt|awk '{
	#	if(FNR==1){
	#		print $0
	#	}else{
	#		zero=0
	#		for(i=2;i<=NF;i++){
	#			if($i==0){
	#				zero+=1
	#			}
	#		}
	#		if(NF-zero>5){
	#			print $0
	#		}
	#	}
	
	
	#}'>aligned_piRNAs/${tag}_nozero.txt&&\
	#mv aligned_piRNAs/${tag}_nozero.txt aligned_piRNAs/${tag}.txt
	#continue
	#根据MAF过滤
	cat aligned_SNPs/$tag.txt|awk '{
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
	
	
	}'>aligned_SNPs/${tag}_maf.txt&&\
	mv aligned_SNPs/${tag}_maf.txt aligned_SNPs/${tag}.txt&
done

while :
do
	if [ `ps -aux 2>/dev/null|grep -v grep|grep firstcolnames|wc -l` == 0 ];then
		break
	fi
	sleep 1
done


