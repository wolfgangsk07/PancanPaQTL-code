rm PCAs/*
mkdir PCAs
ls aligned_SNPs/TCGA-*.txt|while read txt
do
	tag=`echo ${txt}|sed 's/aligned_SNPs\///g'|sed 's/.txt//g'`
	while :
	do
		if [ `cat /proc/meminfo |grep Committed_AS|awk '{print $2}'` -gt 110000000 ];then
			continue
		fi
		if [ `ps -aux 2>/dev/null|grep -v grep|grep doPCA.R|wc -l` -lt 2 ];then
			break
		fi
		sleep 1
	done
	echo $tag
	if [ -f PCAs/$tag.txt ];then
		continue
	fi
	Rscript doPCA.R aligned_SNPs/$tag.txt PCAs/$tag.txt.tmp&&\
	mv PCAs/$tag.txt.tmp PCAs/$tag.txt&
done


while :
do
	if [ `ps -aux 2>/dev/null|grep -v grep|grep doPCA.R|wc -l` == 0 ];then
		break
	fi
	sleep 1
done
