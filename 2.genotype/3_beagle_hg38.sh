#下载1000G
chrs=({1..22})
chrs[23]=X
for c in ${chrs[@]}
do
		if [ ! -f 1000G_beagle/ALL.chr${c}.shapeit2_integrated_v1a.GRCh38.20181129.phased.vcf.gz ];then
			axel https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000_genomes_project/release/20181203_biallelic_SNV/ALL.chr${c}.shapeit2_integrated_v1a.GRCh38.20181129.phased.vcf.gz \
			-o 1000G_beagle/ALL.chr${c}.shapeit2_integrated_v1a.GRCh38.20181129.phased.vcf.gz.tmp&&\
			mv 1000G_beagle/ALL.chr${c}.shapeit2_integrated_v1a.GRCh38.20181129.phased.vcf.gz.tmp 1000G_beagle/ALL.chr${c}.shapeit2_integrated_v1a.GRCh38.20181129.phased.vcf.gz
		fi
done

if [ ! -f 1000G_beagle/plink.GRCh38.map.zip ];then
	axel https://bochet.gcc.biostat.washington.edu/beagle/genetic_maps/plink.GRCh38.map.zip \
	-o 1000G_beagle/plink.GRCh38.map.zip.tmp&&\
	mv 1000G_beagle/plink.GRCh38.map.zip.tmp 1000G_beagle/plink.GRCh38.map.zip
fi


#将012转换成vcf文件
cancerTypes=`cat /database/1_16T/GDC/TCGA_genotype_txt/annotation.txt|sed "1d"|awk -F '\t' '{print $8}'|sort|uniq`
for cancer in ${cancerTypes[@]}
do
	if [ -f ./result/imputed_${cancer}.txt.gz ];then
		continue
	fi
	awk -v cancer=$cancer '
	{
		if(FNR==NR){
			if(FNR!=1){
				a[$2]=$3"\t"$4"\t"$2"\t"$5"\t"$6
				chr[$2]=$3
			}
		}else{
			
			if(FNR==1){
				print cancer
				patients=$2
				for(i=3;i<=NF;i++){
					patients=patients"\t"$i
				}
				for(i=1;i<=22;i++){
					chrs[i]=i
				}
				chrs[23]="X"
				chrs[24]="Y"
				chrs[25]="MT"
				for(i=1;i<=length(chrs);i++){
					print "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t"patients>"beagle_tmp_hg38/"cancer"_"chrs[i]".vcf"
				}
			}else{
				if($1 in a){
					out=a[$1]"\t.\tPASS\t.\tGT"
					for(i=2;i<=NF;i++){
						if($i==0){
							out=out"\t0/0"
						}else if($i==1){
							out=out"\t0/1"
						}else if($i==2){
							out=out"\t1/1"
						}else{
							out=out"\t./."
						}
					}
					print out>"beagle_tmp_hg38/"cancer"_"chr[$1]".vcf"
				}
			}
		
		}
	}' \
	<(cat GenomeWideSNP_6.na35.annot.csv|sed '/^#/d'|sed 's/"//g'|awk 'BEGIN{FS=",";OFS="\t"}{print $1,$2,$3,$4,$9,$10}') \
	<(zcat result/anno_$cancer.gz)&& \
	
	#start impute
	for c in ${chrs[@]}
	do
		if [ -f ./beagle_tmp_hg38/${cancer}_${c}.gt.vcf.gz ];then
			echo ./beagle_tmp_hg38/${cancer}_${c}.gt.vcf.gz exists, continue
			continue
		fi
		cat ./beagle_tmp_hg38/${cancer}_${c}.vcf|sort -k 2 -n|java \
			-jar beagle/beagle.22Jul22.46e.jar \
			ref=./1000G_beagle/chr${c}.1kg.phase3.v5a.b37.bref3 \
			map=./1000G_beagle/plink.GRCh37.map/plink.chr${c}.GRCh37.map \
			gt=/dev/stdin \
			out=./beagle_tmp_hg38/${cancer}_${c}.gt.tmp&&\
		mv ./beagle_tmp_hg38/${cancer}_${c}.gt.tmp.vcf.gz ./beagle_tmp_hg38/${cancer}_${c}.gt.vcf.gz
	done
	
	
done