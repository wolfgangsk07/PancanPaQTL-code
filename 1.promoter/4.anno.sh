types=("absolutePromoterActivity_filtered")
for typename in ${types[@]}
do
mkdir result/annoed/${typename} -p
	cat /database/1_16T/GDC/Splice_Junction_Quantification/annotation.txt|sed '1d'|awk '{print $5}'|sort|uniq|while read cancertype
	do
		awk -v cancertype=$cancertype '{
			#anno_proActiv
			if(FNR==NR){
				gsub(/-/,".",$2)
				$2="ln_"$2
				if($5==cancertype){
					anno[$2]=$4
					#print $2>"/dev/stderr"
				}
			}else{
				if(FNR==1){
					count=0
					str="promoter_id\t"
					for(i=2;i<=NF;i++){
						if($i in anno){
							output[i]
							$i=anno[$i]
							#print $i>"/dev/stderr"
							str=str""$i"\t"
							count++
						}
					
					}
					print count>"/dev/stderr"
					print str
				}else{
					count=0
					str="id_"$1"\t"
					for(i=2;i<=NF;i++){
						if(i in output){
							str=str""$i"\t"
							count++
						}
					}
					print count>"/dev/stderr"
					print str
				}
			}
		}' /database/1_16T/GDC/Splice_Junction_Quantification/annotation.txt <(zcat result/$typename.txt.gz)|gzip>result/annoed/${typename}/$cancertype.gz.tmp&&mv result/annoed/${typename}/$cancertype.gz.tmp result/annoed/${typename}/$cancertype.gz&
		while :
		do
			if [ `ps -aux|grep -v grep|grep anno_proActiv|wc -l` -lt 15 ];then
				break
			fi
			sleep 1
		done
	done
done
