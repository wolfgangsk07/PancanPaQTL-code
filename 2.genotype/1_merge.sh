trans(){
	cancer=$1
	firstfile=/database/1_16T/GDC/TCGA_genotype_txt/`cat /database/1_16T/GDC/TCGA_genotype_txt/annotation.txt|sed "/^#/d"|sed -n "2p"|awk '{print $2"/"$3}'`
	echo file `cat annoed.txt|tr "\n" " "`
	
	cat /database/1_16T/GDC/TCGA_genotype_txt/annotation.txt|sed "/^#/d"|sed "1d"|grep ${cancer}|while read LINE;do
		id=`echo $LINE|awk  '{print $2}'`
		filename=`echo $LINE|awk  '{print $3}'`
		echo $filename `cat /database/1_16T/GDC/TCGA_genotype_txt/$id/$filename|sed '1,2d'|awk '{print $2}'|tr "\n" " "`
	done
}




cancerTypes=`cat /database/1_16T/GDC/TCGA_genotype_txt/annotation.txt|sed "/^#/d"|sed "1d"|awk -F '\t' '{print $8}'|sort|uniq`
for cancer in ${cancerTypes[@]}
do
	if [ ! -f $cancer.gz ];then
		while [ `ps -aux|grep awk|grep -v grep|wc -l` -gt 16 ]
		do
			sleep 1
		done
		echo processing $cancer
		trans $cancer|awk '{ #这个大括号里的代码是 对正文的处理
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
					res[i]=res[i] " " $i
				}
			}
		}
		# BEGIN{} 文件进行扫描前要执行的操作；END{} 文件扫描结束后要执行的操作。
		END{
			#输出数组
			for (i=1; i<=NF; i++){
				print res[i]
			}
		}'|gzip>$cancer.gz.tmp&&mv $cancer.gz.tmp ./result/$cancer.gz&
		
		
	fi

done

