

cis_trans_eqtl<-function(userParams){
	cancer_type<-as.character(userParams["cancer_type"])
	promoterid<-gsub(" ","",as.character(userParams["promoterid"]))
	cisortrans<-as.character(userParams["cisortrans"])
	SNP_id<-as.character(userParams["SNP_id"])
	pval<-as.character(userParams["Pvalue"])
	FDR<-as.character(userParams["FDR"])
	genes<-as.character(userParams["genes"])

		

	#pval<-as.character(userParams["pval"])

	#padj<-as.character(userParams["padj"])

	
	piRES_low<-as.character(userParams["piRES_low"])
	piRES_high<-as.character(userParams["piRES_high"])
	#size_low<-as.character(userParams["size_low"])
	#size_high<-as.character(userParams["size_high"])
	
	UUID<-userParams["UUID"]
	showTablePic<-TRUE
	tablePicNeeds<-c("Cancer","PromoterID","SNP","FDR")
	tablePicFunc<-"go_cis_trans_fig"
	table1<-list()
	table1$type<-"table"
	
	#pipeline
	filepath<-paste0("../data/totaleqtl/",cancer_type,"_",cisortrans,".gz")
	single_role<-NULL

	#single_role[[1]]<-c(title="Type",value=cisortrans)
	
	
	#range_role<-list()
	
	#range_role[[1]]<-list(title="ImmPI score",value=c(piRES_low,piRES_high))
	#range_role[[2]]<-list(title="Size",value=c(size_low,size_high))
	
	upper_role<-list()
	upper_role[[1]]<-list(title="P-value",value=pval)
	upper_role[[2]]<-list(title="FDR",value=FDR)
	
	
	multi_role<-list()
	multi_role[[1]]<-c(title="PromoterID",value=promoterid)
	multi_role[[2]]<-c(title="SNP",value=SNP_id)
	multi_role[[3]]<-c(title="Gene Symbol",value=genes)
	
	
	totalindex<-table_filter(filepath,single_role,multi_role,showTablePic,tablePicNeeds,tablePicFunc,range_role=NULL,upper_role)
	
	table1$colnames<-colnames(read.delim(filepath,nrows=1,sep="\t",check.names=FALSE))

	outputs<-list()

	
	table1$totalrows=length(totalindex)
	table1$pagenumber=1
	table1$cancer=cancer_type
	table1$showTablePic=showTablePic
	table1$tablePicNeeds<-tablePicNeeds
	table1$tablePicFunc<-tablePicFunc
	table1$resLines<-length(totalindex)
	if(length(totalindex)==0){
		table1$data[[1]]<-NULL
	}else{
		index_to_show<-head(totalindex,100)
		subtab<-getSubTab(filepath,index_to_show)
		#sed_par<-paste(paste0(index_to_show,"p"),collapse=";")
		#subtab<-read.delim(pipe(paste0("pigz -cd ",filepath,"|sed '1d'|sed -n \"",sed_par,"\"")),sep="\t",header=FALSE)
		for(i in 1:nrow(subtab)){
			table1$data[[i]]<-as.character(subtab[i,])
		}
	}
	outputs$table1<-table1
	return(outputs)

}


snpsurvival<-function(userParams){
	cancer_type<-as.character(userParams["cancer_type"])
	cisortrans<-as.character(userParams["cisortrans"])
	SNP_id<-as.character(userParams["SNP_id"])
	pval<-as.character(userParams["Pvalue"])
	FDR<-as.character(userParams["FDR"])
	
		

	#pval<-as.character(userParams["pval"])

	#padj<-as.character(userParams["padj"])

	
	piRES_low<-as.character(userParams["piRES_low"])
	piRES_high<-as.character(userParams["piRES_high"])
	#size_low<-as.character(userParams["size_low"])
	#size_high<-as.character(userParams["size_high"])
	
	UUID<-userParams["UUID"]
	showTablePic<-TRUE
	tablePicNeeds<-c("Cancer","SNP")
	tablePicFunc<-"go_snpsurvival_fig"
	table1<-list()
	table1$type<-"table"
	
	#pipeline
	filepath<-paste0("../data/survival/",cancer_type,"_",cisortrans,".gz")
	single_role<-NULL

	#single_role[[1]]<-c(title="Type",value=cisortrans)
	
	
	#range_role<-list()
	
	#range_role[[1]]<-list(title="ImmPI score",value=c(piRES_low,piRES_high))
	#range_role[[2]]<-list(title="Size",value=c(size_low,size_high))
	
	upper_role<-list()
	upper_role[[1]]<-list(title="KM P-value",value=pval)
	upper_role[[2]]<-list(title="FDR",value=FDR)
	
	
	multi_role<-list()
	#multi_role[[1]]<-c(title="PromoterID",value=promoterid)
	multi_role[[1]]<-c(title="SNP",value=SNP_id)

	
	
	totalindex<-table_filter(filepath,single_role,multi_role,showTablePic,tablePicNeeds,tablePicFunc,range_role=NULL,upper_role)
	
	table1$colnames<-colnames(read.delim(filepath,nrows=1,sep="\t",check.names=FALSE))

	outputs<-list()

	
	table1$totalrows=length(totalindex)
	table1$pagenumber=1
	table1$cancer=cancer_type
	table1$showTablePic=showTablePic
	table1$tablePicNeeds<-tablePicNeeds
	table1$tablePicFunc<-tablePicFunc
	table1$resLines<-length(totalindex)
	if(length(totalindex)==0){
		table1$data[[1]]<-NULL
	}else{
		index_to_show<-head(totalindex,100)
		subtab<-getSubTab(filepath,index_to_show)
		#sed_par<-paste(paste0(index_to_show,"p"),collapse=";")
		#subtab<-read.delim(pipe(paste0("pigz -cd ",filepath,"|sed '1d'|sed -n \"",sed_par,"\"")),sep="\t",header=FALSE)
		for(i in 1:nrow(subtab)){
			table1$data[[i]]<-as.character(subtab[i,])
		}
	}
	outputs$table1<-table1
	return(outputs)

}

gwas_eqtl<-function(userParams){
	cancer_type<-as.character(userParams["cancer_type"])
	cisortrans<-as.character(userParams["cisortrans"])
	SNP_id<-as.character(userParams["SNP_id"])
	tagSNP<-as.character(userParams["tagSNP"])
	traits<-as.character(userParams["traits"])
	LD<-as.character(userParams["LD"])
	genes<-as.character(userParams["genes"])
	promoterid<-as.character(userParams["promoterid"])
	
	UUID<-userParams["UUID"]
	showTablePic<-FALSE
	tablePicNeeds<-c("Cancer","PromoterID","SNP","FDR")
	tablePicFunc<-"go_cis_trans_fig"
	table1<-list()
	table1$type<-"table"
	
	#pipeline
	filepath<-paste0("../data/gwas_eqtl/",cancer_type,"_",cisortrans,".gz")
	single_role<-NULL

	#single_role[[1]]<-c(title="Type",value=cisortrans)
	
	
	#range_role<-list()
	
	#range_role[[1]]<-list(title="ImmPI score",value=c(piRES_low,piRES_high))
	#range_role[[2]]<-list(title="Size",value=c(size_low,size_high))
	
	upper_role<-NULL
	
	range_role<-list()
	range_role[[1]]<-list(title="LD",value=c(LD,1))
	
	contain_role<-list()
	contain_role[[1]]<-c(title="Traits",value=traits)
	
	multi_role<-list()
	multi_role[[1]]<-c(title="tagSNP",value=tagSNP)
	multi_role[[2]]<-c(title="SNP",value=SNP_id)
	multi_role[[3]]<-c(title="Gene symbol",value=genes)
	multi_role[[4]]<-c(title="PromoterID",value=promoterid)
	
	totalindex<-table_filter(filepath,single_role,multi_role,showTablePic,tablePicNeeds,tablePicFunc,range_role,upper_role=upper_role,contain_role=contain_role)
	
	table1$colnames<-colnames(read.delim(filepath,nrows=1,sep="\t",check.names=FALSE))

	outputs<-list()

	
	table1$totalrows=length(totalindex)
	table1$pagenumber=1
	table1$cancer=cancer_type
	table1$showTablePic=showTablePic
	table1$tablePicNeeds<-tablePicNeeds
	table1$tablePicFunc<-tablePicFunc
	table1$resLines<-length(totalindex)
	if(length(totalindex)==0){
		table1$data[[1]]<-NULL
	}else{
		index_to_show<-head(totalindex,100)
		subtab<-getSubTab(filepath,index_to_show)
		#sed_par<-paste(paste0(index_to_show,"p"),collapse=";")
		#subtab<-read.delim(pipe(paste0("pigz -cd ",filepath,"|sed '1d'|sed -n \"",sed_par,"\"")),sep="\t",header=FALSE)
		for(i in 1:nrow(subtab)){
			table1$data[[i]]<-as.character(subtab[i,])
		}
	}
	outputs$table1<-table1
	return(outputs)

}


drugs<-function(userParams){
	cancer_type<-as.character(userParams["cancer_type"])
	promoterid<-gsub(" ","",as.character(userParams["promoterid"]))
	cisortrans<-as.character(userParams["cisortrans"])
	SNP_id<-as.character(userParams["SNP_id"])
	drugnames<-as.character(userParams["drugnames"])
	genes<-as.character(userParams["genes"])
	pathways<-as.character(userParams["pathways"])

	
	UUID<-userParams["UUID"]
	showTablePic<-TRUE
	tablePicNeeds<-c("Cancer","PromoterID","Drug name","RS","Pvalue")
	tablePicFunc<-"go_drug_fig"
	table1<-list()
	table1$type<-"table"
	
	#pipeline
	filepath<-paste0("../data/drugs/",cancer_type,"_",cisortrans,".gz")
	single_role<-list()

	single_role[[1]]<-c(title="Drug name",value=drugnames)
	single_role[[2]]<-c(title="Target pathway",value=pathways)
	
	#range_role<-list()
	
	#range_role[[1]]<-list(title="ImmPI score",value=c(piRES_low,piRES_high))
	#range_role[[2]]<-list(title="Size",value=c(size_low,size_high))
	
	upper_role<-NULL
	
	
	
	multi_role<-list()
	multi_role[[1]]<-c(title="PromoterID",value=promoterid)
	multi_role[[2]]<-c(title="SNP",value=SNP_id)
	multi_role[[3]]<-c(title="Gene Symbol",value=genes)
	
	
	totalindex<-table_filter(filepath,single_role,multi_role,showTablePic,tablePicNeeds,tablePicFunc,range_role=NULL,upper_role)
	
	table1$colnames<-colnames(read.delim(filepath,nrows=1,sep="\t",check.names=FALSE))

	outputs<-list()

	
	table1$totalrows=length(totalindex)
	table1$pagenumber=1
	table1$cancer=cancer_type
	table1$showTablePic=showTablePic
	table1$tablePicNeeds<-tablePicNeeds
	table1$tablePicFunc<-tablePicFunc
	table1$resLines<-length(totalindex)
	if(length(totalindex)==0){
		table1$data[[1]]<-NULL
	}else{
		index_to_show<-head(totalindex,100)
		subtab<-getSubTab(filepath,index_to_show)
		#sed_par<-paste(paste0(index_to_show,"p"),collapse=";")
		#subtab<-read.delim(pipe(paste0("pigz -cd ",filepath,"|sed '1d'|sed -n \"",sed_par,"\"")),sep="\t",header=FALSE)
		for(i in 1:nrow(subtab)){
			table1$data[[i]]<-as.character(subtab[i,])
		}
	}
	outputs$table1<-table1
	return(outputs)

}

immune<-function(userParams){
	cancer_type<-as.character(userParams["cancer_type"])
	promoterid<-gsub(" ","",as.character(userParams["promoterid"]))
	cisortrans<-as.character(userParams["cisortrans"])
	SNP_id<-as.character(userParams["SNP_id"])
	cellname<-as.character(userParams["cellname"])
	Source<-as.character(userParams["source"])
	genes<-as.character(userParams["genes"])
		

	
	UUID<-userParams["UUID"]
	showTablePic<-TRUE
	tablePicNeeds<-c("Cancer","PromoterID","Immune cell","Source","Coefficient","P_value")
	tablePicFunc<-"go_immune_fig"
	table1<-list()
	table1$type<-"table"
	
	#pipeline
	filepath<-paste0("../data/immune/",cancer_type,"_",cisortrans,".gz")
	single_role<-list()

	single_role[[1]]<-c(title="Immune cell",value=cellname)
	single_role[[2]]<-c(title="Source",value=Source)
	
	#range_role<-list()
	
	#range_role[[1]]<-list(title="ImmPI score",value=c(piRES_low,piRES_high))
	#range_role[[2]]<-list(title="Size",value=c(size_low,size_high))
	
	upper_role<-NULL

	
	
	multi_role<-list()
	multi_role[[1]]<-c(title="PromoterID",value=promoterid)
	multi_role[[2]]<-c(title="SNP",value=SNP_id)
	multi_role[[3]]<-c(title="Gene Symbol",value=genes)
	
	
	totalindex<-table_filter(filepath,single_role,multi_role,showTablePic,tablePicNeeds,tablePicFunc,range_role=NULL,upper_role)
	
	table1$colnames<-colnames(read.delim(filepath,nrows=1,sep="\t",check.names=FALSE))

	outputs<-list()

	
	table1$totalrows=length(totalindex)
	table1$pagenumber=1
	table1$cancer=cancer_type
	table1$showTablePic=showTablePic
	table1$tablePicNeeds<-tablePicNeeds
	table1$tablePicFunc<-tablePicFunc
	table1$resLines<-length(totalindex)
	if(length(totalindex)==0){
		table1$data[[1]]<-NULL
	}else{
		index_to_show<-head(totalindex,100)
		subtab<-getSubTab(filepath,index_to_show)
		#sed_par<-paste(paste0(index_to_show,"p"),collapse=";")
		#subtab<-read.delim(pipe(paste0("pigz -cd ",filepath,"|sed '1d'|sed -n \"",sed_par,"\"")),sep="\t",header=FALSE)
		for(i in 1:nrow(subtab)){
			table1$data[[i]]<-as.character(subtab[i,])
		}
	}
	outputs$table1<-table1
	return(outputs)

}



survivalres<-function(userParams){
	#废弃
	cancer_type<-as.character(userParams["cancer_type"])
	piRNA_id<-gsub(" ","",as.character(userParams["piRNA_id"]))
	HR_low<-as.character(userParams["HR_low"])
	HR_high<-as.character(userParams["HR_high"])
	#z_low<-as.character(userParams["z_low"])
	#z_high<-as.character(userParams["z_high"])
	pval<-as.character(userParams["pval"])

	rstype<-as.character(userParams["rstype"])
	#imtype<-as.character(userParams["imtype"])
	svtype<-as.character(userParams["svtype"])
	


	UUID<-userParams["UUID"]
	showTablePic<-TRUE
	tablePicNeeds<-c("Cancer","piRNA","Survival Type")
	tablePicFunc<-"go_survival_fig"
	table1<-list()
	table1$type<-"table"
	
	#pipeline
	filepath<-paste0("../data/survival/res/",cancer_type,".gz")
	single_role<-list()
	single_role[[1]]<-c(title="Survival Type",value=svtype)
	single_role[[2]]<-c(title="Risk Type",value=rstype)
	#single_role[[3]]<-c(title="Immune Type",value=imtype)
	
	range_role<-list()
	range_role[[1]]<-list(title="HR",value=c(HR_low,HR_high))
	#range_role[[2]]<-list(title="z",value=c(z_low,z_high))


	upper_role<-list()
	upper_role[[1]]<-list(title="P-value",value=pval)
	
	
	multi_role<-list()
	multi_role[[1]]<-c(title="piRNA",value=piRNA_id)
	
	totalindex<-table_filter(filepath,single_role,multi_role,showTablePic,tablePicNeeds,tablePicFunc,range_role=range_role,upper_role=upper_role)
	
	table1$colnames<-colnames(read.delim(filepath,nrows=1,sep="\t",check.names=FALSE))

	outputs<-list()

	
	table1$totalrows=length(totalindex)
	table1$pagenumber=1
	table1$cancer=cancer_type
	table1$showTablePic=showTablePic
	table1$tablePicNeeds<-tablePicNeeds
	table1$tablePicFunc<-tablePicFunc
	table1$resLines<-length(totalindex)
	
	if(length(totalindex)==0){
		table1$data[[1]]<-NULL
	}else{
		index_to_show<-head(totalindex,100)
		subtab<-getSubTab(filepath,index_to_show)
		#sed_par<-paste(paste0(index_to_show,"p"),collapse=";")
		#subtab<-read.delim(pipe(paste0("pigz -cd ",filepath,"|sed '1d'|sed -n \"",sed_par,"\"")),sep="\t",header=FALSE)
		for(i in 1:nrow(subtab)){
			table1$data[[i]]<-as.character(subtab[i,])
		}
	}
	outputs$table1<-table1
	return(outputs)

}

cells<-function(userParams){
	cancer_type<-as.character(userParams["cancer_type"])
	piRNA_id<-gsub(" ","",as.character(userParams["piRNA_id"]))
	Rho_low<-as.character(userParams["Rho_low"])
	Rho_high<-as.character(userParams["Rho_high"])
	pval<-as.character(userParams["pval"])
	imcell<-as.character(userParams["imcell"])
	imsource<-as.character(userParams["imsource"])
	

	
	UUID<-userParams["UUID"]
	showTablePic<-TRUE
	tablePicNeeds<-c("Cancer","piRNA","Immune Cell","Immune Data Resource","Rho","P-value")
	tablePicFunc<-"go_cells_fig"
	table1<-list()
	table1$type<-"table"
	
	#pipeline
	filepath<-paste0("../data/Cell/",cancer_type,".gz")
	single_role<-list()
	single_role[[1]]<-c(title="Immune Cell",value=imcell)
	single_role[[2]]<-c(title="Immune Data Resource",value=imsource)
	
	multi_role<-list()
	multi_role[[1]]<-c(title="piRNA",value=piRNA_id)
	
	
	range_role<-list()
	range_role[[1]]<-list(title="Rho",value=c(Rho_low,Rho_high))

	
	
	upper_role<-list()
	upper_role[[1]]<-list(title="P-value",value=pval)
	
	totalindex<-table_filter(filepath,single_role,multi_role,showTablePic,tablePicNeeds,tablePicFunc,range_role=range_role,upper_role=upper_role)
	
	table1$colnames<-colnames(read.delim(filepath,nrows=1,sep="\t",check.names=FALSE))

	outputs<-list()

	
	table1$totalrows=length(totalindex)
	table1$pagenumber=1
	table1$cancer=cancer_type
	table1$showTablePic=showTablePic
	table1$tablePicNeeds<-tablePicNeeds
	table1$tablePicFunc<-tablePicFunc
	table1$resLines<-length(totalindex)
	
	if(length(totalindex)==0){
		table1$data[[1]]<-NULL
	}else{
		index_to_show<-head(totalindex,100)
		subtab<-getSubTab(filepath,index_to_show)
		#sed_par<-paste(paste0(index_to_show,"p"),collapse=";")
		#subtab<-read.delim(pipe(paste0("pigz -cd ",filepath,"|sed '1d'|sed -n \"",sed_par,"\"")),sep="\t",header=FALSE)
		for(i in 1:nrow(subtab)){
			table1$data[[i]]<-as.character(subtab[i,])
		}
	}
	outputs$table1<-table1
	return(outputs)

}

Cancer<-function(userParams){
	cancer_type<-as.character(userParams["cancer_type"])
	piRNA_id<-gsub(" ","",as.character(userParams["piRNA_id"]))
	#bm_low<-as.character(userParams["bm_low"])
	#bm_high<-as.character(userParams["bm_high"])
	logfc_low<-as.character(userParams["logfc_low"])
	logfc_high<-as.character(userParams["logfc_high"])
	pval<-as.character(userParams["pval"])

	fdr<-as.character(userParams["fdr"])

	dt<-as.character(userParams["dt"])
	

	
	
	
	
	UUID<-userParams["UUID"]
	showTablePic<-TRUE
	tablePicNeeds<-c("Cancer","piRNA")
	tablePicFunc<-"go_Cancer_fig"
	table1<-list()
	table1$type<-"table"
	
	#pipeline
	filepath<-paste0("../data/Cancer/res/",cancer_type,".gz")
	single_role<-list()
	single_role[[1]]<-c(title="Diff-Type",value=dt)
	
	multi_role<-list()
	multi_role[[1]]<-c(title="piRNA",value=piRNA_id)
	
	range_role<-list()
	#range_role[[1]]<-list(title="Base Mean",value=c(bm_low,bm_high))
	range_role[[1]]<-list(title="Fold Change(log2)",value=c(logfc_low,logfc_high))

	
	upper_role<-list()
	upper_role[[1]]<-list(title="P-value",value=pval)
	upper_role[[2]]<-list(title="FDR",value=fdr)
	
	
	totalindex<-table_filter(filepath,single_role,multi_role,showTablePic,tablePicNeeds,tablePicFunc,range_role=range_role,upper_role=upper_role)
	
	table1$colnames<-colnames(read.delim(filepath,nrows=1,sep="\t",check.names=FALSE))

	outputs<-list()

	
	table1$totalrows=length(totalindex)
	table1$pagenumber=1
	table1$cancer=cancer_type
	table1$showTablePic=showTablePic
	table1$tablePicNeeds<-tablePicNeeds
	table1$tablePicFunc<-tablePicFunc
	table1$resLines<-length(totalindex)
	
	if(length(totalindex)==0){
		table1$data[[1]]<-NULL
	}else{
		index_to_show<-head(totalindex,100)
		subtab<-getSubTab(filepath,index_to_show)
		#sed_par<-paste(paste0(index_to_show,"p"),collapse=";")
		#subtab<-read.delim(pipe(paste0("pigz -cd ",filepath,"|sed '1d'|sed -n \"",sed_par,"\"")),sep="\t",header=FALSE)
		for(i in 1:nrow(subtab)){
			table1$data[[i]]<-as.character(subtab[i,])
		}
	}
	outputs$table1<-table1
	return(outputs)

}

table_filter<-function(filepath,single_role,multi_role,showTablePic,tablePicNeeds,tablePicFunc,range_role=NULL,upper_role=NULL,maxLines=100,contain_role=NULL){

	colnames<-colnames(read.delim(filepath,nrows=1,sep="\t",check.names=FALSE))
	pipeline=paste0("pigz -cd ",filepath,"|sed '1d'|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\"}{print NR,$0}'")
	count<-0
	if(!is.null(single_role)){
		for(i in 1:length(single_role)){
			role<-single_role[[i]]
			if(role["value"]!=""){
				count<-count+1
				col_index=which(colnames==role["title"])+1
				pipeline=paste0(pipeline,"|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\"}{if(\"",role["value"],"\"==$",col_index,"){print $0}}'")
			}
		}
	}
	if(!is.null(multi_role)){
		for(i in 1:length(multi_role)){
			role<-multi_role[[i]]
			if(role["value"]!=""){
				count<-count+1
				col_index=which(colnames==role["title"])+1
				pipeline=paste0(pipeline,"|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\";split(\"",role["value"],"\",a,\",\")}{for(i in a){if(a[i]==$",col_index,"){print $0;break;}}}'")
			}
		}
	}
	
	if(!is.null(contain_role)){
		for(i in 1:length(contain_role)){
			role<-contain_role[[i]]
			if(role["value"]!=""){
				count<-count+1
				col_index=which(colnames==role["title"])+1
				pipeline=paste0(pipeline,"|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\";split(tolower(\"",role["value"],"\"),a,\",\")}{for(i in a){if(index(tolower($",col_index,"),a[i])>0){print $0;break;}}}'")
			}
		}
	}
	
	
	if(!is.null(range_role)){
		for(i in 1:length(range_role)){
			role<-range_role[[i]]
			col_index=which(colnames==role$title)+1
			if(role$value[1]!=""){
				count<-count+1
				pipeline=paste0(pipeline,"|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\"}{if(",role$value[1],"<=$",col_index,"){print $0}}'")
			}
			if(role$value[2]!=""){
				count<-count+1
				pipeline=paste0(pipeline,"|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\"}{if(",role$value[2],">=$",col_index,"){print $0}}'")

			}
		}
	}
	
	if(!is.null(upper_role)){
		for(i in 1:length(upper_role)){
			role<-upper_role[[i]]
			col_index=which(colnames==role$title)+1
			if(role$value!=""){
				count<-count+1
				pipeline=paste0(pipeline,"|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\"}{if(",role$value,">=$",col_index,"){print $0}}'")
			}
		}
	}

	pipeline=paste0(pipeline,"|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\";print 0}{print $1}'")
	totalindex<-as.numeric(read.delim(pipe(pipeline),sep="\t")[,1])

	tableIndex<-list()
	tableIndex$totalindex<-totalindex
	tableIndex$filepath<-filepath
	tableIndex$showTablePic<-showTablePic
	tableIndex$tablePicNeeds<-tablePicNeeds
	tableIndex$tablePicFunc<-tablePicFunc
	save(tableIndex,file=paste0("../jsonCache/tableIndex_",UUID,".rda"))
	return(totalindex)
}


toPage_table<-function(userParams){

	preUUID=as.character(userParams["preUUID"])
	pagenumber=as.numeric(userParams["pagenumber"])
	rowsPerPage=as.numeric(userParams["rowsPerPage"])
	cancertype=as.character(userParams["cancertype"])
	UUID=userParams["UUID"]
	load(file=paste0("../jsonCache/tableIndex_",preUUID,".rda"))
	totalindex=tableIndex$totalindex
	filepath=tableIndex$filepath
	showTablePic<-tableIndex$showTablePic
	tablePicNeeds<-tableIndex$tablePicNeeds
	tablePicFunc<-tableIndex$tablePicFunc
	firstLine=(pagenumber-1)*rowsPerPage+1
	lastLine=pagenumber*rowsPerPage
	if(lastLine>length(totalindex)){
		lastLine=length(totalindex)
	}
	index_to_show=totalindex[firstLine:lastLine]
	
	#sed_par<-paste(paste0(index_to_show+1,"p"),collapse=";")
	#subtab<-read.delim(pipe(paste0("pigz -cd ",filepath,"|sed -n \"",sed_par,"\"")),sep="\t",header=FALSE)
	subtab<-getSubTab(filepath,index_to_show)
	outputs<-list()
	table1<-list()
	table1$type<-"toPage"
	

	
	table1$totalrows=length(totalindex)
	table1$pagenumber=pagenumber
	table1$preUUID<-preUUID
	table1$cancer<-cancertype
	table1$showTablePic<-showTablePic
	table1$tablePicNeeds<-tablePicNeeds
	table1$tablePicFunc<-tablePicFunc
	table1$colnames<-colnames(read.delim(filepath,nrows=1,sep="\t",check.names=FALSE))
	for(i in 1:nrow(subtab)){
		table1$data[[i]]<-as.character(subtab[i,])
	}
	outputs$table1<-table1
	return(outputs)

}
getSubTab<-function(filepath,index_to_show,header=TRUE){
	if(header){
		offset<-1
	}else{
		offset<-0
	}
	
	sed_par<-paste(paste0(index_to_show+offset),collapse=",")
	pipeline<-paste0("pigz -cd ",filepath,"|awk -v lines=\"",sed_par,"\" 'BEGIN{split(lines,a,\",\"); for (i in a) arr[a[i]]} {if (FNR in arr) {print; delete arr[FNR]; if (length(arr)==0) exit}}'")
	return(read.delim(pipe(pipeline),sep="\t",header=FALSE,colClasses = "character"))
}

go_downResult<-function(userParams){

	preUUID=as.character(userParams["preUUID"])
	type=as.character(userParams["type"])
	if(type=="table"){
		load(file=paste0("../jsonCache/tableIndex_",preUUID,".rda"))
		totalindex=c(1,tableIndex$totalindex+1)
		index<-paste0("../jsonCache/tableIndex_",preUUID,".txt")
		write.table(totalindex,file=index,quote=FALSE,row.names=FALSE,col.names=FALSE)
		filepath=tableIndex$filepath
		

		
		#sed_par<-paste(paste0(totalindex,"p"),collapse=";")
		filename=paste0("download_",preUUID,".txt")
		system(paste0("pigz -cd ",filepath,"|awk '{if(FNR==NR){a[$0]}else{if(FNR in a){print $0}}}' ",index," /dev/stdin>../jsonCache/",filename))
		
		#shell(paste0("cat ",filepath,"|sed -n \"",sed_par,"\">",filename))
	}else if(type=="fig"){
		preUUID<-userParams["preUUID"]
		jsonfile<-fromJSON(file=paste0("../jsonCache/res_",preUUID,".json"))
		drawing<-jsonfile$res$outputs[[1]]$drawing
		dpi<-drawing$default$dpi
		width_in<-drawing$default$width_in
		height_in<-drawing$default$height_in
		filename<-paste0("fig_",preUUID,".pdf")
		pdf(paste0("../jsonCache/",filename),width=width_in,height=height_in)
		apply_drawing(drawing)
		dev.off()
	}
	outputs<-list()
	outputs$filename<-filename
	return(outputs)

}
snpsurvival_fig<-function(userParams){
	cancer_type<-userParams["cancer_type"]
	snp<-userParams["snp"]
	masked_snp<-substr(snp,1,4)
	pipeline<-paste0("zcat ../data/aligned_SNPs/",cancer_type,"/",masked_snp,"_.gz|awk 'BEGIN{FS=\"\t\";OFS=\"\t\"}{if(FNR==1){print};if($1==\"",snp,"\"){print}}'")
	genotypes<-t(read.table(pipe(pipeline),header=FALSE)[,-1])
	genotypes[,1]<-substr(genotypes[,1],1,12)
	genotypes<-genotypes[!duplicated(genotypes[,1]),]
	rownames(genotypes)<-genotypes[,1]
	
	anno<-read.table("../data/genotype_annotion.txt",sep="\t")
	anno<-anno[!duplicated(anno$case_id),]
	rownames(anno)<-anno$case_id
	
	commonSamples<-intersect(anno$case_id,genotypes[,1])
	anno<-anno[commonSamples,]
	genotypes<-genotypes[commonSamples,]
	
	anno$days_to_end<-as.numeric(anno$days)-as.numeric(anno$age_at_diagnosis)
	remainIndex<-which(!is.na(anno$days_to_end))
	anno<-anno[remainIndex,]
	genotypes<-genotypes[remainIndex,]
	
	subdat<-data.frame(surv=anno$vital_status  ,surv.time=anno$days_to_end/365,group=genotypes[,2])
	subdat$group[subdat$group==0]<-"aa"
	subdat$group[subdat$group==1]<-"Aa"
	subdat$group[subdat$group==2]<-"AA"
	rownames(subdat)<-genotypes[,1]
	
	outputs<-list()
	survivalpackage<-list()
	survivalpackage$data<-subdat

	survivalpackage$cancer_type=cancer_type
	survivalpackage$gene=snp
	fig<-list()
	fig$type<-"fig"
	fig$drawing<-mykmplot(survivalpackage)
	outputs$fig1<-fig

	return(outputs)
}

cis_trans_fig<-function(userParams){
	cancer_type<-as.character(userParams["cancer_type"])
	snp=as.character(userParams["snp"])
	promoterid=as.character(userParams["promoterid"])
	fdr=as.character(userParams["fdr"])
	SNPexpr<-as.numeric(read.table(pipe(paste0("pigz -cd ../data/aligned_SNPs/",cancer_type,"/",substr(snp,1,4),"_.gz|awk '{if(FNR!=1){if($1==\"",snp,"\"){print $0;exit}}}'")))[1,-1])
	piRNAexpr<-as.numeric(read.table(pipe(paste0("pigz -cd ../data/aligned_proAc/",cancer_type,".gz|awk '{if(FNR!=1){if($1==\"",promoterid,"\"){print $0;exit}}}'")))[1,-1])
	boxdata<-list()
	boxdata$ylab=paste0(promoterid," expression level")
	boxdata$xlab=paste0(snp," genotype")
	boxdata$main=paste0(cancer_type," FDR=",fdr)
	boxdata$data<-list()
	Alle<-c("AA","Aa","aa")
	cols<-c("#269534","#4c4dbc","#ff3f2e")
	for(i in 1:3){
	
		dat<-piRNAexpr[SNPexpr==i-1]
		boxdata$data[[Alle[i]]]$data<-dat
		boxdata$data[[Alle[i]]]$col<-cols[i]
		boxdata$data[[Alle[i]]]$name<-Alle[i]
	}
	outputs<-list()
	fig<-list()
	fig$type<-"fig"
	fig$drawing<-myboxplot(boxdata)
	outputs$fig1<-fig
	return(outputs)

}
gsea_fig<-function(userParams){
	cancer_type<-as.character(userParams["cancer_type"])
	pirna=as.character(userParams["pirna"])
	pirna_mask<-substr(pirna,1,9)
	#pipeline<-paste0("zcat ../data/gsea/matrix/",cancer_type,"/",pirna_mask,"_.gz|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\"}{if(FNR==1){print $0}else{if($1==\"",pirna,"\"){print $0}}}'")
	pipeline<-paste0("zcat ../data/gsea/matrix/",cancer_type,"/",pirna_mask,"_.gz|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\"}{if(FNR==1){for(i=1;i<=NF;i++){colname[i]=$i}}else{if($1==\"",pirna,"\"){for(i=2;i<=NF;i++){print colname[i-1],$i}}}}'")
	geneList_tab<-read.delim(pipe(pipeline),sep="\t",header=FALSE)
	time2<-Sys.time()
	#geneList<-as.numeric(geneList_tab)
	geneList<-as.numeric(geneList_tab[,2])
	#names(geneList)<-colnames(geneList_tab)
	names(geneList)<-geneList_tab[,1]
	geneList<-geneList[order(geneList,decreasing=TRUE)]
	pipeline2<-paste0("zcat ../data/gsea/res/",cancer_type,".gz|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\"}{if(FNR==1){print $0}else{if($1==\"",pirna,"\"){print $0}}}'")
	res<-read.delim(pipe(pipeline2))
	geneSets<-list()
	pathways=fromJSON(file="../data/gsea/pathway.json")
	time3<-Sys.time()
	for(i in 1:nrow(res)){
		tag<-paste0(res$Pathway[i]," (FDR= ",round(res$FDR[i],3),", ES= ",round(res$ES[i],3),", ImmPI score =",round(res$"ImmPI.score"[i],3),")")
		geneSets[[tag]]<-pathways[[res$Pathway[i]]]
	
	}
	outputs<-list()
	fig<-list()
	fig$type<-"fig"
	time4<-Sys.time()
	fig$drawing<-mygsea(geneList,geneSets,"Correlation coefficient","Rank of Genes",paste(pirna,"in",cancer_type))
	outputs$fig1<-fig
	time5<-Sys.time()
	return(outputs)

}

drugs_fig<-function(userParams){
	#library(psych)
	cancer_type<-userParams["cancer_type"]
	promoterid<-as.character(userParams["promoterid"])
	drugname<-as.character(userParams["drugname"])
	Rho<-round(as.numeric(userParams["RS"]),3)
	P<-as.numeric(userParams["pval"])
	#dat1
	filepath<-paste0("../data/drugs_matrix/",cancer_type,".gz")
	pipeline<-paste0("zcat ",filepath,"|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\"}{if(FNR==1){print $0}else{if($1==\"",drugname,"\"){print $0}}}'")
	dat1<-read.delim(pipe(pipeline),sep="\t",header=TRUE,check.name=FALSE)

	filepath<-paste0("../data/aligned_proAc/",cancer_type,".gz")
	pipeline<-paste0("zcat ",filepath,"|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\"}{if(FNR==1){print $0}else{if($1==\"",promoterid,"\"){print $0}}}'")
	dat2<-read.delim(pipe(pipeline),sep="\t",header=TRUE,check.name=FALSE)[,-1]
	colnames(dat2)<-substr(colnames(dat2),1,15)
	
	
	commonSamples<-intersect(colnames(dat1),colnames(dat2))
	sampleNames<-commonSamples
	
	dat1<-as.numeric(dat1[,commonSamples])
	dat2<-as.numeric(dat2[,commonSamples])
	
	
	
	index<-!(is.na(dat1)|is.na(dat2))
	dat1<-dat1[index]
	dat2<-dat2[index]
	sampleNames<-sampleNames[index]
	#FIXED<-signif(corr.test(dat1,dat2,method="spearman")$p,3)
	#dat2<--log(dat2,2)
	#dat1<--log(dat1+1,2)
	fig<-list()
	fig$type<-"fig"
	fig$drawing<-myplot(x=dat2,y=dat1,r=0.03,col="#1676b4",xlab=paste0(promoterid),ylab=drugname,main=paste(drugname,"vs",promoterid,"in",cancer_type),tag=paste0("Rho = ",Rho,", P = ",P),sampleNames=sampleNames,delLen=length(commonSamples)-sum(index))
	outputs<-list()
	outputs$fig1<-fig
	#outputs$debug<-c(orgLen,sum(index))
	return(outputs)
}

immune_fig<-function(userParams){
	#library(psych)
	cancer_type<-userParams["cancer_type"]
	promoterid<-as.character(userParams["promoterid"])
	Immune_cell<-as.character(userParams["cellname"])
	cell_source<-as.character(userParams["source"])
	Rho<-round(as.numeric(userParams["RS"]),3)
	P<-as.numeric(userParams["pval"])
	
	immunetag<-paste0(Immune_cell,"_",cell_source)
	#dat1
	filepath<-paste0("../data/immune_matrix/",cancer_type,".gz")
	pipeline<-paste0("zcat ",filepath,"|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\"}{if(FNR==1){print $0}else{if($1==\"",immunetag,"\"){print $0}}}'")
	dat1<-read.delim(pipe(pipeline),sep="\t",header=TRUE,check.name=FALSE)

	filepath<-paste0("../data/aligned_proAc/",cancer_type,".gz")
	pipeline<-paste0("zcat ",filepath,"|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\"}{if(FNR==1){print $0}else{if($1==\"",promoterid,"\"){print $0}}}'")
	dat2<-read.delim(pipe(pipeline),sep="\t",header=TRUE,check.name=FALSE)[,-1]
	colnames(dat2)<-substr(colnames(dat2),1,15)
	
	
	commonSamples<-intersect(colnames(dat1),colnames(dat2))
	sampleNames<-commonSamples
	
	dat1<-as.numeric(dat1[,commonSamples])
	dat2<-as.numeric(dat2[,commonSamples])
	
	
	
	index<-!(is.na(dat1)|is.na(dat2))
	dat1<-dat1[index]
	dat2<-dat2[index]
	#test_cor<-paste(", testP=",sprintf("%.4g",cor.test(dat1,dat2,method="spearman")$p.value))
	sampleNames<-sampleNames[index]
	#FIXED<-signif(corr.test(dat1,dat2,method="spearman")$p,3)
	#dat1<--log(dat1,2)
	#dat1<--log(dat1+1,2)
	fig<-list()
	fig$type<-"fig"
	fig$drawing<-myplot(x=dat2,y=dat1,r=0.03,col="#1676b4",xlab=paste0(promoterid),ylab=immunetag,main=paste(immunetag,"vs",promoterid,"in",cancer_type),tag=paste0("Rho = ",Rho,", P = ",P),sampleNames=sampleNames,delLen=length(commonSamples)-sum(index))
	outputs<-list()
	outputs$fig1<-fig
	#outputs$debug<-c(orgLen,sum(index))
	return(outputs)
}


Cancer_fig<-function(userParams){
	cancer_type<-userParams["cancer_type"]
	pirna<-as.character(userParams["pirna"])
	pipeline<-paste0("zcat ../data/Cancer/data/",cancer_type,".gz|awk 'BEGIN{FS=\"\\t\";OFS=\"\\t\"}{if(FNR==1){for(i=1;i<=NF;i++){if($i==\"",pirna,"\"){coln=i}}}else{print $2,$coln}}'")
	dat<-read.delim(pipe(pipeline),sep="\t",header=FALSE)
	boxdata<-list()
	boxdata$ylab="Expression level (logged Raw reads)"
	boxdata$main=paste(pirna,"in",cancer_type)
	tumorDat<-as.numeric(dat[dat[,1]=="Tumor",2])
	normalDat<-as.numeric(dat[dat[,1]=="Normal",2])
	boxdata$data$a$data<-log(tumorDat+1,2)
	boxdata$data$a$col<-"#007ccb"
	boxdata$data$a$name<-"Tumor"
	boxdata$data$b$data<-log(normalDat+1,2)
	boxdata$data$b$col<-"#cc7373"
	boxdata$data$b$name<-"Normal"
	fig<-list()
	fig$type<-"fig"
	fig$drawing<-myboxplot(boxdata)
	outputs<-list()
	outputs$fig1<-fig

	return(outputs)
}


down_fig<-function(userParams){
	fig_UUID<-userParams["fig_UUID"]
	jsonfile<-fromJSON(file=paste0("../jsonCache/res_",fig_UUID,".json"))
	drawing<-jsonfile$res$outputs[[1]]$drawing
	dpi<-drawing$default$dpi
	width_in<-drawing$default$width_in
	height_in<-drawing$default$height_in
	filename<-paste0("fig_",fig_UUID,".pdf")
	pdf(paste0("../jsonCache/",filename),width=width_in,height=height_in)
	apply_drawing(drawing)
	dev.off()
	outputs<-list()
	downfig1<-list()
	downfig1$type<-"download"
	downfig1$filename<-filename
	outputs$downfig1<-downfig1
	return(outputs)

}