ls TCGA*.txt|while read txt
do
	while :
	do
		if [ `ps -aux 2>/dev/null|grep -v grep|grep doPEER|wc -l` -lt 5 ];then
			break
		fi
	sleep 1
	done
	tag=`echo ${txt}|sed 's/.txt//g'`
	echo $tag
	if [ -f peerfactors/$tag.txt ];then
		continue
	fi
	Rscript doPEER.R $tag.txt peerfactors/$tag.txt.tmp&&\
	mv peerfactors/$tag.txt.tmp peerfactors/$tag.txt&
done