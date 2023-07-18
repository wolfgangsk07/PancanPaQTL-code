#更新trans/cis文件


read -p "Update all?(y/*)" all;all=${all,,}




#更新maf信息到/tmp
if [ "$all" != "y" ];then
	read -p "更新maf信息到/tmp?(y/*)" o111;o111=${o111,,}
fi
if [[ "$all" == "y" ]] || [[ "$o111" == "y" ]];then
ls /backup/wdy/Projects/promoterActiv-qtl/totalQTL/aligned_SNPs/*.txt|while read txt
	do
	tag=`echo ${txt}|sed 's/\/backup\/wdy\/Projects\/promoterActiv-qtl\/totalQTL\/aligned_SNPs\///g'|sed 's/.txt//g'`
	cat /backup/wdy/Projects/promoterActiv-qtl/totalQTL/aligned_SNPs/$tag.txt|awk 'BEGIN{FS="\t";OFS="\t"}
	{
			#过滤maf
			if(FNR!=1){
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
					print $1
				}
			}
		
		
		}'|pigz>/tmp/maf_$tag.gz&
		
	done
	while :
	do
		if [ `ps -aux 2>/dev/null|grep -v grep|grep 过滤maf|wc -l` == 0 ];then
			break
		fi
		sleep 1
	done
fi




#更新cis/trans total summary
if [ "$all" != "y" ];then
	read -p "Update cis/trans total summary?(y/*)" o1;o1=${o1,,}
fi
if [[ "$all" == "y" ]] || [[ "$o1" == "y" ]];then
	echo packaging cis/trans summary
	rm data/totaleqtl/*
	rm /ramfs/totaleqtl -rf
	mkdir /ramfs/totaleqtl -p
	mkdir data/totaleqtl -p
	
	doFDR(){
		calcFDR='writeLines(as.character(p.adjust(readLines("stdin"),method="fdr")),stdout())'
		inputgz=$1
		outputgz=$2
		awk 'BEGIN{
				OFS="\t"
				FS="\t"
				OFMT="%.4g"
				print "Cancer","Type","SNP","SNP position","Alleles","PromoterID","Promoter position","Ensembl ID","Gene Symbol","beta","t-stat","P-value","FDR"
			}{
			#cistrans
			if(FILENAME==ARGV[1]){
				fdr[FNR]=$1
				#print $0
			}else{
				$12=$12+0
				if(($12 < 0.0005 && $2 == "cis") || ($12 < 0.00000005 && $2 == "trans")){
					$13=fdr[FNR]+0
					$10=$10+0
					$11=$11+0
					gsub(/id/, "prmtr",$6)
					print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13
				}
				
			}
		}' <(zcat $inputgz|awk '{print $12}'|R --slave -e $calcFDR) <(zcat $inputgz)|pigz>$outputgz
		rm $inputgz
	}
	
	
	
	



	ls /backup/wdy/Projects/promoterActiv-qtl/totalQTL/cis/full_*.gz|while read LINE
	do
		tag=${LINE##*full_}
		tag=${tag%.gz*}

		echo parsing $tag...
		awk -v tag=$tag 'BEGIN{
				OFS="\t"
				FS="\t"
				#OFMT="%.4g"
				#cistrans
			}{
			if(FILENAME==ARGV[1]){
				geneloc[$1]=$2":"$3
			}else if(FILENAME==ARGV[2]){
				#if($12=="single"){
					snploc[$5]=$2":"$4
					snpalle[$5]=$10
				#}
			}else if(FILENAME==ARGV[3]){
				maf[$1]
			}else if(FILENAME==ARGV[4]){
				
				n = split($9, fields, ";");
				for(i=1; i<=n; i++) {
					split(fields[i], a, " ");
					if(a[1]=="gene_id")
						gene_id = gensub(/"/, "", "g", a[2]);
					if(a[1]=="gene_name")
						gene_name = gensub(/"/, "", "g", a[2]);
				}
				
				if(gene_id!="" && gene_name!=""){
					enstosyml[gene_id]=gene_name
					
				}
			}else if(FILENAME==ARGV[5]){
				pridtoens["id_"$1]=$3
			}else{
				if(FNR==1){
					#print "start extracting lines of cis">"/dev/stderr"
					#print "Cancer","Type","SNP","SNP position","Alleles","PromoterID","Promoter position","Ensembl ID","Gene Symbol","beta","t-stat","P-value","FDR"
				}else{
					#print snpalle[$1],length(snpalle[$1])>"/dev/stderr"
					if($5 <=0.001 && length(snpalle[$1])==3 && $1 in maf){
						print tag,"cis",$1,snploc[$1],snpalle[$1],$2,geneloc[$2],pridtoens[$2],enstosyml[pridtoens[$2]],$3,$4,$5,$6
					}
				}
			}
		}' \
		<(pigz -cd /backup/wdy/Projects/promoterActiv-qtl/totalQTL/gene_snp_loc/geneloc.gz) \
		<(pigz -cd /backup/wdy/Projects/promoterActiv-qtl/totalQTL/gene_snp_loc/shrinked_SNP_anno.gz) \
		<(zcat /tmp/maf_${tag}.gz) \
		<(zcat /backup/wdy/processedData/genome_ref/Homo_sapiens.GRCh38.109.gtf.gz) \
		<(zcat /backup/wdy/processedData/proActiv/result/anno.txt.gz) \
		<(pigz -cd /backup/wdy/Projects/promoterActiv-qtl/totalQTL/cis/full_${tag}.gz)|sort -t $'\t' -k12,12g|pigz>data/totaleqtl/${tag}_cis.gz.tmp&& \
		doFDR data/totaleqtl/${tag}_cis.gz.tmp data/totaleqtl/${tag}_cis.gz&
		
		awk -v tag=$tag 'BEGIN{
				OFS="\t"
				FS="\t"
				#OFMT="%.4g"
				#cistrans
			}{
			if(FILENAME==ARGV[1]){
				geneloc[$1]=$2":"$3
			}else if(FILENAME==ARGV[2]){
				#if($12=="single"){
					snploc[$5]=$2":"$4
					snpalle[$5]=$10
				#}
			}else if(FILENAME==ARGV[3]){
				maf[$1]
			}else if(FILENAME==ARGV[4]){
				n = split($9, fields, ";");
				for(i=1; i<=n; i++) {
					split(fields[i], a, " ");
					if(a[1]=="gene_id")
						gene_id = gensub(/"/, "", "g", a[2]);
					if(a[1]=="gene_name")
						gene_name = gensub(/"/, "", "g", a[2]);
				}
				
				if(gene_id!="" && gene_name!=""){
					enstosyml[gene_id]=gene_name
					
				}
			}else if(FILENAME==ARGV[5]){
				pridtoens["id_"$1]=$3
			}else{
				if(FNR==1){
					#tag=substr(FILENAME,index(FILENAME,"/TCGA-")+1)
					#gsub(".txt","",tag)
					#outputpath="/ramfs/totaleqtl/"tag
					#split(tag,tag2,"_")
					#print "start extracting lines of trans">"/dev/stderr"
					#print "Cancer","Type","SNP","SNP position","Alleles","PromoterID","Promoter position","beta","t-stat","P-value","FDR"
				}else{
					if($5 <=0.00001 && length(snpalle[$1])==3 && $1 in maf){
						print tag,"trans",$1,snploc[$1],snpalle[$1],$2,geneloc[$2],pridtoens[$2],enstosyml[pridtoens[$2]],$3,$4,$5,$6
					}
				}
			}
		}' \
		<(pigz -cd /backup/wdy/Projects/promoterActiv-qtl/totalQTL/gene_snp_loc/geneloc.gz) \
		<(pigz -cd /backup/wdy/Projects/promoterActiv-qtl/totalQTL/gene_snp_loc/shrinked_SNP_anno.gz) \
		<(zcat /tmp/maf_${tag}.gz) \
		<(zcat /backup/wdy/processedData/genome_ref/Homo_sapiens.GRCh38.109.gtf.gz) \
		<(zcat /backup/wdy/processedData/proActiv/result/anno.txt.gz) \
		<(pigz -cd /backup/wdy/Projects/promoterActiv-qtl/totalQTL/trans/part_${tag}.gz)|sort -t $'\t' -k12,12g|pigz>data/totaleqtl/${tag}_trans.gz.tmp&& \
		doFDR data/totaleqtl/${tag}_trans.gz.tmp data/totaleqtl/${tag}_trans.gz&
		
		
		while :
		do
			if [ `ps -aux 2>/dev/null|grep -v grep|grep cistrans|wc -l` -lt 16 ];then
				break
			fi
			sleep 1
		done
	done
	
	while :
	do
		if [ `ps -aux 2>/dev/null|grep -v grep|grep cistrans|wc -l` == 0 ];then
			break
		fi
		sleep 1
	done
	
	#开始合并all
	awk 'BEGIN{FS="\t";OFS="\t"}
	{
		if(FNR==1){
			print $0
		}else{
			if($1!="Cancer"){
				print $0
			}
		}
	}' <(zcat data/totaleqtl/*_cis.gz)|sort -t $'\t' -k12,12g|pigz>data/totaleqtl/ALL.gz.tmp&&mv data/totaleqtl/ALL.gz.tmp data/totaleqtl/TCGA-ALL_cis.gz
	awk 'BEGIN{FS="\t";OFS="\t"}
	{
		if(FNR==1){
			print $0
		}else{
			if($1!="Cancer"){
				print $0
			}
		}
	}' <(zcat data/totaleqtl/*_trans.gz)|sort -t $'\t' -k12,12g|pigz>data/totaleqtl/ALL.gz.tmp&&mv data/totaleqtl/ALL.gz.tmp data/totaleqtl/TCGA-ALL_trans.gz
fi




#更新SNP piRNA矩阵
if [ "$all" != "y" ];then
	read -p "Update SNP and promoterActiv matrix?(y/*)" o2;o2=${o2,,}
fi
if [[ "$all" == "y" ]] || [[ "$o2" == "y" ]];then
	echo packaging SNP and piRNA matrix
	rm data/aligned_SNPs -rf
	rm data/aligned_proAc -rf
	mkdir -p data/aligned_SNPs
	mkdir -p data/aligned_proAc
	ls /backup/wdy/processedData/proActiv/result/annoed/absolutePromoterActivity_filtered/*.gz|while read txt
	do
		filename=${txt##*/}
		tag=${filename%.*}
		rm /ramfs/SNP_$tag -rf
		mkdir /ramfs/SNP_$tag -p
		mkdir data/aligned_SNPs/$tag -p
		awk -v tag=$tag '{

			if(FNR==1){
				header=$0
			}else{
				if($1!="."){
					mask=substr($1,1,4)
					if(mask in done){
					}else{
						print header>"/ramfs/SNP_"tag"/"mask
						done[mask]
					}

					print $0>"/ramfs/SNP_"tag"/"mask

				}
			}
		
		}' /backup/wdy/Projects/promoterActiv-qtl/totalQTL/aligned_SNPs/$tag.txt&&\
		for mask_txt in /ramfs/SNP_$tag/*
		do
			cat $mask_txt|pigz>data/aligned_SNPs/$tag/${mask_txt##*/}_.gz.tmp&&mv data/aligned_SNPs/$tag/${mask_txt##*/}_.gz.tmp data/aligned_SNPs/$tag/${mask_txt##*/}_.gz&&rm $mask_txt
		done
		#pigz -c /backup/wdy/Projects/piRNA-qtl/totalQTL/aligned_SNPs/$tag.txt>data/aligned_SNPs/$tag.gz.tmp&&mv data/aligned_SNPs/$tag.gz.tmp data/aligned_SNPs/$tag.gz
		cat /backup/wdy/Projects/promoterActiv-qtl/totalQTL/aligned_proAc/$tag.txt|awk 'BEGIN{FS="\t";OFS="\t"}{if(FNR!=1){gsub(/id/, "prmtr",$1)}print $0}'|pigz>data/aligned_proAc/$tag.gz.tmp&&mv data/aligned_proAc/$tag.gz.tmp data/aligned_proAc/$tag.gz
	done
fi




#更新GWAS-eqtl
if [ "$all" != "y" ];then
	read -p "Update GWAS-eqtl?(y/*)" o3;o3=${o3,,}
	
fi
if [[ "$all" == "y" ]] || [[ "$o3" == "y" ]];then
	echo packaging gwas-eqtl
	rm data/gwas_eqtl -rf
	mkdir data/gwas_eqtl -p
	types=("cis" "trans")
	for type in "${types[@]}"; do
		ls /backup/wdy/processedData/proActiv/result/annoed/absolutePromoterActivity_filtered/*.gz|while read txt;do
			filename=${txt##*/}
			cancer=${filename%.*}
			zcat /backup/lr/promoterQTL/Gwas_catalog_plink_final.txt.gz|awk 'BEGIN{FS="\t";OFS="\t";OFMT="%.4g"}{
				if(FILENAME==ARGV[1]){
					if(FNR==1){
						header=$2"\t"$3"\t"$4

					}else{
						split($3, tmp, ";")
						$3=tmp[1]
						$5=$5+0
						
						full[FNR]=$3"\t"$4"\t"sprintf("%.4g", $5)

						#full[FNR]=$0
						if($2 in ifin){
							ifin[$2]=ifin[$2]","FNR
						}else{
							ifin[$2]=FNR
						}
					}
				}else{
					
					if(FNR==1){
						if(FILENAME==ARGV[2]){
							$3="tagSNP"
							print $1,$2,$3,$4,$5,header,$6,$7,$8,$9,$10,$11,$12
						}
						
					}else{
						if($3 in ifin){
							print $3>"/ramfs/include.tmp"
							split(ifin[$3], ind, ",")
							for(i in ind){
								print $1,$2,$3,$4,$5,full[ind[i]],$6,$7,$8,$9,$10,$11,$12
							}
						}else{
							print $3>"/ramfs/exclude.tmp"
						}
					}
				}
			}' /dev/stdin <(pigz -cd data/totaleqtl/${cancer}_${type}.gz)|gzip>data/gwas_eqtl/${cancer}_${type}.gz.tmp&&mv data/gwas_eqtl/${cancer}_${type}.gz.tmp data/gwas_eqtl/${cancer}_${type}.gz
		done
		
		
		zcat data/gwas_eqtl/*_${type}.gz|head -1>/ramfs/gwas_eqtl_${type}.gz.tmp
		for gz in data/gwas_eqtl/*_${type}.gz;do
			zcat $gz|sed '1d'>>/ramfs/gwas_eqtl_${type}.gz.tmp
		done

		cat /ramfs/gwas_eqtl_${type}.gz.tmp|pigz>data/gwas_eqtl/TCGA-ALL_${type}.gz.tmp&&mv data/gwas_eqtl/TCGA-ALL_${type}.gz.tmp data/gwas_eqtl/TCGA-ALL_${type}.gz
	
	
	done

	
		
fi


#更新GWAS-eqtl
if [ "$all" != "y" ];then
	read -p "Update GWAS-eqtl from lgx?(y/*)" o3;o3=${o3,,}
	
fi
if [[ "$all" == "y" ]] || [[ "$o3" == "y" ]];then
	types=("cis" "trans")
	for type in "${types[@]}"; do
		ls /backup/wdy/processedData/proActiv/result/annoed/absolutePromoterActivity_filtered/*.gz|while read txt;do
			filename=${txt##*/}
			tag=${filename%.*}
			zcat /backup/lgx/promoter/${type}_puQTL_GWAS.gz|awk -v tag=$tag 'BEGIN{FS="\t";OFS="\t";OFMT="%.4g"}{
				if(FNR==1){
					$12="Gene symbol"
					print $0
				}else{
					if($2==tag){
						output=$2
						for(i=3;i<=NF;i++){
							output=output"\t"$i
						}
						print output
					}
				}
			
			}'|sort -t $'\t' -k15,15g|pigz>data/gwas_eqtl/${tag}_${type}.gz.tmp&&mv data/gwas_eqtl/${tag}_${type}.gz.tmp data/gwas_eqtl/${tag}_${type}.gz
		done
		
		#合并
		rm data/gwas_eqtl/TCGA-ALL_${type}.gz
		awk 'BEGIN{FS="\t";OFS="\t"}{
		}{
			if(FNR==1){
				print $0
			}else{
				if($1!="Cancer"){
					print $0
				}
			}
		}' <(zcat data/gwas_eqtl/*_${type}.gz)|pigz>data/gwas_eqtl/TCGA-ALL_${type}.tmp&&mv data/gwas_eqtl/TCGA-ALL_${type}.tmp data/gwas_eqtl/TCGA-ALL_${type}.gz

	done


fi




if [ "$all" != "y" ];then
	read -p "Update Survival?(y/*)" o5;o5=${o5,,}
fi
if [[ "$all" == "y" ]] || [[ "$o5" == "y" ]];then
	#rm data/survival -rf
	#mkdir data/survival -p
	types=("cis" "trans")

	for type in "${types[@]}"; do
		ls /backup/wdy/Projects/promoterActiv-qtl/totalQTL/cis/full_*|while read LINE
		do
			tag=${LINE##*full_}
			tag=${tag%.gz*}
			if [ ! -f data/survival/${tag}_${type}.gz ];then
				while :
				do
					if [ `ps -aux 2>/dev/null|grep -v grep|grep packagingSurvival.R|wc -l` -lt 18 ];then
						break
					fi
					sleep 1
				done
				
				echo parsing $tag $type...
				Rscript myScripts/r/packagingSurvival.R $tag $type&
			fi
		done
	done

	
	while :
	do
		if [ `ps -aux 2>/dev/null|grep -v grep|grep packagingSurvival.R|wc -l` == 0 ];then
			break
		fi
		sleep 1
	done
	
	#合并
	for type in "${types[@]}"; do
		rm data/survival/TCGA-ALL_${type}.gz
		awk 'BEGIN{FS="\t";OFS="\t"}{
		}{
			if(FNR==1){
				print $0
			}else{
				if($1!="Cancer"){
					print $0
				}
			}
		}' <(zcat data/survival/*_${type}.gz)|pigz>data/survival/TCGA-ALL_${type}.tmp&&mv data/survival/TCGA-ALL_${type}.tmp data/survival/TCGA-ALL_${type}.gz
	done
	
	
fi


if [ "$all" != "y" ];then
	read -p "Update drugs?(y/*)" o6;o6=${o6,,}
fi
if [[ "$all" == "y" ]] || [[ "$o6" == "y" ]];then
	rm data/drugs -rf
	mkdir data/drugs -p
	types=("cis" "trans")
	ls /backup/wdy/Projects/promoterActiv-qtl/totalQTL/cis/full_*|while read LINE
	do
		tag=${LINE##*full_}
		tag=${tag%.gz*}
		
		#drugs
		

		for type in "${types[@]}"; do
			echo parsing $tag $type
			awk -v tag=$tag 'BEGIN{FS="\t";OFS="\t"}{
				#parsingDrugs
				if(FILENAME==ARGV[1]){
					drugname[$1]=$2
					rs[$1]=$3
					pval[$1]=$4
				}else if(FILENAME==ARGV[2]){
					target[$3]=$5
					pathway[$3]=$6
				}else{
					if(FNR==1){
						print $1,$2,$3,$4,$5,$6,$7,$8,$9,"Drug name","Drug target","Target pathway","RS","Pvalue"
					}else{
						if($6 in drugname){
							print $1,$2,$3,$4,$5,$6,$7,$8,$9,drugname[$6],target[drugname[$6]],pathway[drugname[$6]],rs[$6],pval[$6]
						}
					}
				}
			
			}' <(Rscript myScripts/r/convertingDrugs.R $tag) <(cat data/screened_compunds_rel_8.2.txt) <(zcat data/totaleqtl/${tag}_${type}.gz)|sort -t $'\t' -k14,14g|pigz>data/drugs/${tag}_${type}.tmp&&mv data/drugs/${tag}_${type}.tmp data/drugs/${tag}_${type}.gz&
		done
		
		while :
		do
			if [ `ps -aux 2>/dev/null|grep -v grep|grep parsingDrugs|wc -l` -lt 16 ];then
				break
			fi
			sleep 1
		done
	done
	
	while :
	do
		if [ `ps -aux 2>/dev/null|grep -v grep|grep convertingDrugs|wc -l` == 0 ];then
			break
		fi
		sleep 1
	done
	
	
	
	#合并
	for type in "${types[@]}"; do
		rm data/drugs/TCGA-ALL_${type}.gz
		awk 'BEGIN{FS="\t";OFS="\t"}{
		}{
			if(FNR==1){
				print $0
			}else{
				if($1!="Cancer"){
					print $0
				}
			}
		}' <(zcat data/drugs/*_${type}.gz)|pigz>data/drugs/TCGA-ALL_${type}.tmp&&mv data/drugs/TCGA-ALL_${type}.tmp data/drugs/TCGA-ALL_${type}.gz
	done
	
	
	
fi
	


if [ "$all" != "y" ];then
	read -p "Update drugs-matrix?(y/*)" o7;o7=${o7,,}
fi
if [[ "$all" == "y" ]] || [[ "$o7" == "y" ]];then

	rm data/drugs_matrix -rf
	mkdir data/drugs_matrix -p
	ls /backup/wdy/Projects/promoterActiv-qtl/totalQTL/cis/full_*|while read LINE
	do
		tag=${LINE##*full_}
		tag=${tag%.gz*}
		shorttag=${tag##*-}
		zcat /backup/lr/promoterQTL/${shorttag}/DrugPredictions_sub.gz|awk 'BEGIN{FS="\t";OFS="\t"}{
			split($1,tmp,"_")
			$1=tmp[1]
			print $0

		}'|pigz>data/drugs_matrix/${tag}.gz
	done
fi



if [ "$all" != "y" ];then
	read -p "Update immune?(y/*)" o4;o4=${o4,,}
fi
if [[ "$all" == "y" ]] || [[ "$o4" == "y" ]];then
	#rm data/immune
	mkdir data/immune -p
	types=("cis" "trans")
	for type in "${types[@]}"; do
		ls /backup/wdy/Projects/promoterActiv-qtl/totalQTL/cis/full_*|while read LINE
		do
			tag=${LINE##*full_}
			tag=${tag%.gz*}
			zcat /backup/lgx/promoter/${type}_puQTL_immune.gz|awk -v tag=$tag 'BEGIN{FS="\t";OFS="\t";OFMT="%.4g"}{
			}{
				if(FNR==1){
					output = $1
					
					for (i = 2; i < NF; i++) {
						if($i=="source"){
							$i="Source"
						}else if($i=="coefficient"){
							$i="Coefficient"
						}else if($i=="Immune_cell"){
							$i="Immune cell"
						}
						output = output"\t"$i
					}
					print output
				}else{
					if($2==tag){
						$13=sprintf("%.4g", $13)
						$14=sprintf("%.4g", $14)
						output = $2
						for (i = 3; i < NF; i++) {
							
							if (i < NF) {
								output = output"\t"$i
							}
						}
						
						print output
					}
				}
			}'|pigz>data/immune/${tag}_${type}.gz.tmp&&mv data/immune/${tag}_${type}.gz.tmp data/immune/${tag}_${type}.gz
		done
		
		rm data/immune/TCGA-ALL_${type}.gz
		awk 'BEGIN{FS="\t";OFS="\t";OFMT="%.4g"}{
		}{
			if(FNR==1){
				print $0
			}else{
				if($1!="Cancer"){
					print $0
				}
			}
		}' <(zcat data/immune/*_${type}.gz)|pigz>data/immune/TCGA-ALL_${type}.tmp&&mv data/immune/TCGA-ALL_${type}.tmp data/immune/TCGA-ALL_${type}.gz
		
	done
	mkdir data/immune_matrix
	Rscript myScripts/r/packagingCellImmune.R
fi




if [ "$all" != "y" ];then
	read -p "Update others?(y/*)" o4;o4=${o4,,}
fi
if [[ "$all" == "y" ]] || [[ "$o4" == "y" ]];then
	#更新annotation
	echo update annotation
	cp /database/1_16T/GDC/TCGA_genotype_txt/annotation.txt data/genotype_annotion.txt
	#更新userparams.json
	echo update userparams.json
	Rscript myScripts/r/updateInitParams.R
fi