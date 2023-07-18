rm junctions -rf
mkdir junctions -p
cat /database/1_16T/GDC/Splice_Junction_Quantification/gdc_manifest.2023-03-19.txt|sed '1d'|while read line;do
	id=`echo $line|awk '{print $1}'`
	filename=`echo $line|awk '{print $2}'`
	if [ ! -f junctions/$id.tab.gz ];then
		ln -s /database/1_16T/GDC/Splice_Junction_Quantification/$id/$filename junctions/ln_$id.tab.gz

	fi
done