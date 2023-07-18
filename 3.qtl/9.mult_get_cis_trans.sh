ls aligned_proAc/*.txt|while read txt
do
	
	tag=`echo $txt|sed 's/.txt//g'|sed 's/aligned_proAc\///g'`
	while :
	do
		if [ `ps -aux|grep -v grep|grep get_cis_trans.R|wc -l` -lt 18 ];then
			break
		fi
		sleep 1
	done
	echo $tag
	if [ ! -f trans/part_$tag.gz ];then
		Rscript get_cis_trans.R $tag&
	fi
done