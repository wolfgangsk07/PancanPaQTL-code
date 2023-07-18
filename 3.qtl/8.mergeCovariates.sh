mkdir aligned_Covariates
ls aligned_SNPs/TCGA*.txt|while read txt
do
	tag=`echo ${txt}|sed 's/aligned_SNPs\///g'|sed 's/.txt//g'`
	echo =================$tag
	pcafile=PCAs/$tag.txt
	peerfile=PEERs/$tag.txt
	awk '{
			FS="\t"
			OFS="\t"
			if(FNR==NR){
				if($10=="-"){
					age[$9]="NA"
				}else{
					age[$9]=int($10/365)
				}
				
				if($11=="male"){
					sex[$9]=1
				}else if($11=="female"){
					sex[$9]=0
				}else{
					sex[$9]="NA"
				}
				
				stage[$9]=$12
			}else{
				if(FNR!=1){
					print $0,age[$1],sex[$1],stage[$1]
					
				}else{
					print $0,"age","sex","stage"
				}
			}
		}'\
	<(cat /database/1_16T/GDC/TCGA_genotype_txt/annotation.txt|sed "1d")\
	<(awk '{
			OFS="\t"
			if(FNR==NR){
				
				a[$1]=$1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6
				if(FNR==1){
					header=$1"\t"$2"\t"$3"\t"$4"\t"$5
				}
			}
			else{
				if($1 in a){
					print a[$1],$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16
				}
				if(FNR==1){
					print "id",header,$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15
				}
			}
		}' $pcafile $peerfile)\
        |awk '{ #这个大括号里的代码是 对正文的处理
			# NF表示列数，NR表示已读的行数
			# 注意for中的i从1开始，i前没有类型
			for (i=1; i<=NF; i++){#对每一列
				if(NR==1){       #如果是第一行
					#将第i列的值存入res[i],$i表示第i列的值，i为数组的下标，以列序号为下标，
					#数组不用定义可以直接使用
					res[i]=$i;   
				}
				else{
					#不是第一行时，将该行对应i列的值拼接到res[i]
					res[i]=res[i] "\t" $i
				}
			}
		}
		# BEGIN{} 文件进行扫描前要执行的操作；END{} 文件扫描结束后要执行的操作。
		END{
			#输出数组
			for (i=1; i<=NF; i++){
				print res[i]
			}
		}' \
		|awk '{
		#排除一些独立性别的factor
			a[1]="empty"
			count=0
			for(i=2;i<=NF;i++){
				isin=0
				for(j=1;j<=length(a);j++){
					if($i==a[j]){
						isin=1
					}
				}
				if(isin==0){
					count++
				}
				a[i]=$i
			}
			if(count>1){
				print $0
			}
			delete a
		}'>aligned_Covariates/$tag.txt
	
	echo $pcafile has `cat ${pcafile}|wc -l` lines
	echo $peerfile has `cat ${peerfile}|wc -l` lines
	echo aligned_Covariates/$tag.txt has `cat aligned_Covariates/${tag}.txt|awk '{print NF}'|head -1` colnums
done