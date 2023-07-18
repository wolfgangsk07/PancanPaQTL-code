apply_drawing<-function(drawing,customPar=FALSE){
	if(!customPar){
		par(mai=c(0,0,0,0),omi=c(0,0,0,0))
	}
	plot(x=-1,y=-1,xlim=c(0,drawing$default$PlotScale[1]),ylim=c(0,drawing$default$PlotScale[2]),axes=FALSE,xaxs="i",yaxs="i",col="transparent")
	for(i in 2:length(drawing)){
		if(!is.null(drawing[[i]]$hideInR)){
			next
		}
		get(drawing[[i]]$elementtype)(drawing[[i]])
	}
}

colorPool<-c("#c87474","#895050","#a86496","#9264a8","#7364a8","#8b78cf","#5e9aa9","#5ea981","#60a95e","#93a95e","#c3bf5a","#8a7851")
#==================添加elements======================
add_bezier<-function(drawing,points_gp,t=seq( 0, 1, length=10 ),col="black",lwd=1,lend=1){
	if(is.null(drawing)){
		print("creating drawing 100*100")
		drawing<-list()
		drawing$default$PlotScale<-c(100,100)
	}
	if(is.null(points_gp)){
		points_gp<-c(0,0, 1,4, 2,2)
		print("add default points_gp c(0,0, 1,4, 2,2)")
	}
	tag<-paste0("bezier_",length(drawing)+1)
	drawing[[tag]]$points_gp<-points_gp
	drawing[[tag]]$t<-t
	drawing[[tag]]$elementtype<-"draw_bezier"
	drawing[[tag]]$col<-col
	drawing[[tag]]$lwd<-lwd
	drawing[[tag]]$lend<-lend
	return(drawing)

}


add_partpie<-function(drawing,central_point,r1,r2,angle1,angle2,border="black",lwd=1,col="white"){
	if(is.null(drawing)){
		print("creating drawing 100*100")
		drawing<-list()
		drawing$default$PlotScale<-c(100,100)
	}
	tag<-paste0("partpie_",length(drawing)+1)
	drawing[[tag]]$elementtype<-"draw_partpie"
	drawing[[tag]]$central_point<-central_point
	drawing[[tag]]$r1<-r1
	drawing[[tag]]$r2<-r2
	drawing[[tag]]$angle1<-angle1
	drawing[[tag]]$angle2<-angle2
	drawing[[tag]]$border<-border
	drawing[[tag]]$lwd<-lwd
	drawing[[tag]]$col<-col
	return(drawing)
}

add_text<-function(drawing,text,x,y,srt=0,col="black",cex=0.5,adj=c(0.5,0),groupid=NULL,hideInR=NULL,bold=FALSE){

	tag<-paste0("text_",length(drawing)+1)
	drawing[[tag]]$elementtype<-"draw_text"
	drawing[[tag]]$x<-x
	drawing[[tag]]$y<-y
	drawing[[tag]]$text<-text
	drawing[[tag]]$cex<-cex
	drawing[[tag]]$col<-col
	drawing[[tag]]$srt<-srt
	drawing[[tag]]$adj<-adj
	drawing[[tag]]$groupid<-groupid
	drawing[[tag]]$hideInR<-hideInR
	drawing[[tag]]$bold<-bold
	return(drawing)
}
add_rect<-function(drawing,x1,y1,x2,y2,lwd=1,col=NA,border=NULL,groupid=NULL,hideInR=NULL){

	tag<-paste0("rect_",length(drawing)+1)
	drawing[[tag]]$elementtype<-"draw_rect"
	drawing[[tag]]$x1<-x1
	drawing[[tag]]$y1<-y1
	drawing[[tag]]$x2<-x2
	drawing[[tag]]$y2<-y2
	drawing[[tag]]$lwd<-lwd
	drawing[[tag]]$col<-col
	drawing[[tag]]$border<-border
	drawing[[tag]]$groupid<-groupid
	drawing[[tag]]$hideInR<-hideInR
	return(drawing)
}
add_lines<-function(drawing,x,y,lwd=1,col="black",lty="solid",groupid=NULL,hideInR=NULL,lend=1,popupTexts=NULL){

	tag<-paste0("lines_",length(drawing)+1)
	drawing[[tag]]$elementtype<-"draw_lines"
	drawing[[tag]]$x<-x
	drawing[[tag]]$y<-y
	drawing[[tag]]$lwd<-lwd
	drawing[[tag]]$col<-col
	drawing[[tag]]$lty<-lty
	drawing[[tag]]$groupid<-groupid
	drawing[[tag]]$hideInR<-hideInR
	drawing[[tag]]$lend<-lend
	drawing[[tag]]$popupTexts<-popupTexts
	return(drawing)
}

add_circle<-function(drawing,x,y,r=1,col="black",border=NA,lwd=1,groupid=NULL,hideInR=NULL,popupTexts=NULL){

	tag<-paste0("circles_",length(drawing)+1)
	drawing[[tag]]$elementtype<-"draw_circle"
	drawing[[tag]]$x<-x
	drawing[[tag]]$y<-y
	drawing[[tag]]$r<-r
	drawing[[tag]]$col<-col
	drawing[[tag]]$border<-border
	drawing[[tag]]$lwd<-lwd
	drawing[[tag]]$groupid<-groupid
	drawing[[tag]]$hideInR<-hideInR
	drawing[[tag]]$popupTexts<-popupTexts
	return(drawing)
}

add_polygon<-function(drawing,x,y,lwd=1,col="black",border=NA,groupid=NULL,hideInR=NULL){

	tag<-paste0("lines_",length(drawing)+1)
	drawing[[tag]]$elementtype<-"draw_polygon"
	drawing[[tag]]$x<-x
	drawing[[tag]]$y<-y
	drawing[[tag]]$lwd<-lwd
	drawing[[tag]]$col<-col
	drawing[[tag]]$border<-border
	drawing[[tag]]$groupid<-groupid
	drawing[[tag]]$hideInR<-hideInR
	return(drawing)
}

#==================绘画elements==================
draw_bezier<-function(element){
	library(bezier)
	p <- matrix( element$points_gp
           , nrow=length(element$points_gp)/2
           , ncol=2
           , byrow=TRUE
           )

	bezier_points <- bezier(t=element$t, p=p)
	points(bezier_points,type="l",col=element$col,lwd=element$lwd,lend=element$lend)
}


draw_partpie<-function(element){
	steps<-abs(element$angle2-element$angle1)*2
	if(steps<2){
		steps<-2
	}
	k = seq(element$angle1,element$angle2,length=steps)

    x=element$central_point[1]+element$r1*sin(k/180*pi)
    y=element$central_point[2]+element$r1*cos(k/180*pi)
	k2 = seq(element$angle2,element$angle1,length=steps)
	x2=element$central_point[1]+element$r2*sin(k2/180*pi)
    y2=element$central_point[2]+element$r2*cos(k2/180*pi)
	polygon(c(x,x2),c(y,y2),col=element$col,border=element$border,lwd=element$lwd)

}


draw_text<-function(element){
	if(element$bold){
		font=2
	}else{
		font=1
	}
	text(element$text,x=element$x,y=element$y,cex=element$cex,col=element$col,adj=element$adj,srt=element$srt,font=font)
}

draw_rect<-function(element){
	rect(element$x1,element$y1,element$x2,element$y2,lwd=element$lwd,col=element$col,border=element$border)
}


draw_lines<-function(element){
	points(element$x,element$y,lwd=element$lwd,col=element$col,lty=element$lty,type="l",lend=element$lend)
}


draw_circle<-function(element){
	step<-24
	x<-element$x
	y<-element$y
	r<-element$r
	lwd<-element$lwd
	border<-element$border
	col<-element$col
	nums<-max(c(length(x),length(y),length(r)))
	for(n in 1:nums){
		if(length(x)==nums){
			x_tmp=x[n]
		}else{
			x_tmp=x[1]
		}
		if(length(r)==nums){
			r_tmp=r[n]
		}else{
			r_tmp=r[1]
		}
		if(length(y)==nums){
			y_tmp=y[n]
		}else{
			y_tmp=y[1]
		}
		if(length(col)==nums){
			col_tmp=col[n]
		}else{
			col_tmp=col[1]
		}
		xs<-c()
		ys<-c()
		for(i in 1:step){
			xs<-c(xs,x_tmp+r_tmp*cos(2*pi/step*i))
			ys<-c(ys,y_tmp+r_tmp*sin(2*pi/step*i))
		}
		polygon(xs,ys,col=col_tmp,border=border,lwd=lwd)
	}
}


draw_polygon<-function(element){
	polygon(element$x,element$y,lwd=element$lwd,col=element$col,border=element$border)
}








#==================具体每幅画=============

mycircos<-function(fc=NULL,anno=NULL,pathways=NULL,fc_col=c("#40496f","#566396","#7a8bd3","#e98787","#bc6d6d","#975858"),pathway_col=NULL,legend=NULL,margin=0.12,autoscale=TRUE){
	library(stringr)
	#读取并处理cytoBand
	cytoBand<-read.delim("/backup/WebSite/alpha-piRNA/r/data/cytoBand.txt",header=FALSE)
	colnames(cytoBand)<-c("chr","start","end","loc","type")
	cytoBand<-cytoBand[!str_detect(cytoBand$chr,"_"),]
	cytoBand<-cytoBand[!str_detect(cytoBand$chr,"chrM"),]
	cytoBand<-cytoBand[order(as.numeric(gsub("Y","24",gsub("X","23",gsub("chr","",cytoBand$chr))))),]
	cytoBand$type<-gsub("gneg","#ffffff",cytoBand$type)
	cytoBand$type<-gsub("gpos25","#686868",cytoBand$type)
	cytoBand$type<-gsub("gpos50","#989898",cytoBand$type)
	cytoBand$type<-gsub("gpos75","#b2b2b2",cytoBand$type)
	cytoBand$type<-gsub("gpos100","#c8c8c8",cytoBand$type)
	cytoBand$type<-gsub("acen","#ff0000",cytoBand$type)
	cytoBand$type<-gsub("stalk","#647fa4",cytoBand$type)
	cytoBand$type<-gsub("gvar","#dcdcdc",cytoBand$type)
	cytoBand_other<-cytoBand[cytoBand$chr=="chrY",]
	showOther=FALSE
	if(showOther){
		cytoBand_other$chr<-"Other"
		cytoBand_other$type<-"#ffffff"
		cytoBand<-rbind(cytoBand,cytoBand_other)
	}
	chrs<-unique(cytoBand$chr)
	
	if(is.null(fc)){
		genecounts<-200
		
		fc<-data.frame(sample1=sample(fcvalues,genecounts,replace=TRUE),sample2=sample(fcvalues,genecounts,replace=TRUE),sample3=sample(fcvalues,genecounts,replace=TRUE),sample4=sample(fcvalues,genecounts,replace=TRUE))
		rownames(fc)<-paste0("gene",1:genecounts)
		
		anno<-data.frame(chr=sample(c(paste0("chr",1:22),"chrX","chrY","Other"),genecounts,replace=TRUE),pos=rep(0,genecounts))
		for(i in chrs){
			subcytoBand<-cytoBand[cytoBand$chr==i,]
			start<-subcytoBand$start[1]
			end<-subcytoBand$end[nrow(subcytoBand)]
			anno[anno$chr==i,"pos"]<-sample(start:end,sum(anno$chr==i),replace=TRUE)
			rownames(anno)<-rownames(fc)
		}
		pathways<-sapply(rownames(fc),function(x){paste0("pathway",sample(1:9,sample(1:3,1)))})
		pathway_col<-sample(colorPool,length(pathways),replace=TRUE)
		names(pathway_col)<-pathways
		
	
	}
	if(is.null(legend)){
		legend<-list()
		legend$title<-"Fold Change (log2)"
		legend$cols<-fc_col
		legend$texts1<-c("Down regulated","Up regulated")
		#legend$texts2<-c(">2","1~2","0~1","-1~0","-2~-1","<-2")
	}
	
	fcvalues<-c("d3","d2","d1","u1","u2","u3")
	for(i in 1:length(fcvalues)){
		fc[fc==fcvalues[i]]<-fc_col[i]
	}
	if(autoscale){
		min_len<-3
		anno_freq<-table(anno$chr)
		anno_blank<-setdiff(chrs,names(anno_freq))
		anno_freq[anno_blank]<-nrow(anno)*min_len/(360-min_len*length(anno_blank))
		anno_freq[anno_freq<min_len]<-min_len
		scale_perChr<-c()
		for(c in chrs){
			max_tmp<-max(cytoBand[cytoBand$chr==c,]$end)
			cytoBand[cytoBand$chr==c,]$start<-cytoBand[cytoBand$chr==c,]$start/max_tmp*anno_freq[c]
			cytoBand[cytoBand$chr==c,]$end<-cytoBand[cytoBand$chr==c,]$end/max_tmp*anno_freq[c]
			scale_perChr[c]<-anno_freq[c]/max_tmp
		}
	}else{
		scale_perChr<-c()
		scale_perChr[chrs]<-1
	}
	
	#构建demo data
	
	
	#创建画布基本参数
	drawing<-list()
	drawing$default$PlotScale<-c(1000,1000)
	center_x<-drawing$default$PlotScale[1]/2
	center_y<-drawing$default$PlotScale[2]/2
	
	cytoband_r2<-drawing$default$PlotScale[1]*(0.47-margin)
	cytoband_r1<-drawing$default$PlotScale[1]*(0.45-margin)
	showGeneName<-TRUE
	base_gap<-cytoband_r1/20
	dataHeight<-cytoband_r1*0.3
	
		##角度单位
	patyway_len<-30
	ringGap<-2
	
	
	
	
	#对数据排序
	fc<-fc[rownames(anno),]
	order_index1<-order(anno$pos)
	anno<-anno[order_index1,]
	fc<-fc[order_index1,]
	
	order_index2<-order(anno$chr)
	anno<-anno[order_index2,]
	fc<-fc[order_index2,]
	
	
	
	#画染色体环
	fulllength_org<-sapply(chrs,function(x){
		return(max(cytoBand$end[cytoBand$chr==x]))
	})
	sumgap<-ringGap*(length(chrs)+1)
	scale<-sum(fulllength_org)/(360-sumgap-patyway_len)
	cytoBand$start<-cytoBand$start/scale
	cytoBand$end<-cytoBand$end/scale
	baseangle<-patyway_len+ringGap
	
	chrs_angles1<-c()
	chrs_angles2<-c()
	for(c in chrs){
		subcytoBand<-cytoBand[cytoBand$chr==c,]
		for(i in 1:nrow(subcytoBand)){
			drawing<-add_partpie(drawing,c(center_x,center_y),cytoband_r1,cytoband_r2,baseangle+subcytoBand$start[i],baseangle+subcytoBand$end[i],border=NA,col=subcytoBand$type[i])
		}
		drawing<-add_partpie(drawing,c(center_x,center_y),cytoband_r1,cytoband_r2,baseangle+subcytoBand$start[1],baseangle+subcytoBand$end[nrow(subcytoBand)],border="black",lwd=0.5,col="transparent")
		drawing<-add_text(drawing,c,
			x=center_x+(cytoband_r2+base_gap/2)*sin((baseangle+(subcytoBand$start[1]+subcytoBand$end[nrow(subcytoBand)])/2)/180*pi),
			y=center_y+(cytoband_r2+base_gap/2)*cos((baseangle+(subcytoBand$start[1]+subcytoBand$end[nrow(subcytoBand)])/2)/180*pi),
			srt=-(baseangle+subcytoBand$start[1]+baseangle+subcytoBand$end[nrow(subcytoBand)])/2,
			adj=c(0.5,0.5)
			
		)
		#if(c=="chr1")break
		chrs_angles1<-c(chrs_angles1,baseangle)
		chrs_angles2<-c(chrs_angles2,baseangle+subcytoBand$end[nrow(subcytoBand)])
		baseangle<-baseangle+subcytoBand$end[nrow(subcytoBand)]+ringGap
		
	}
	names(chrs_angles1)<-chrs
	names(chrs_angles2)<-chrs
	#画pathway和文字
	pathway_r<-cytoband_r1-10*base_gap
	drawing<-add_partpie(drawing,c(center_x,center_y),pathway_r,pathway_r+base_gap,0,patyway_len,border="black",lwd=0.5,col="#647fa4")
	pathwaynames<-unique(unlist(sapply(pathways,function(x){
		return(x$pathway)
	})))
	pathways_angles<-seq(0,patyway_len,length=length(pathwaynames)+1)
	pathways_angles<-pathways_angles[-1]-patyway_len/(length(pathways_angles)-1)/2
	names(pathways_angles)<-pathwaynames
	
	for(i in 1:length(pathways_angles)){
		drawing<-add_text(drawing,names(pathways_angles)[i],
			x=center_x+(pathway_r+base_gap*1.5)*sin(pathways_angles[i]/180*pi),
			y=center_y+(pathway_r+base_gap*1.5)*cos(pathways_angles[i]/180*pi),
			srt=90-pathways_angles[i],
			adj=c(0,0.5),
			cex=0.5
		)
		
	}
	
	#画数据主体
	pairedCount=0
	piRNACount=0
	for(c in chrs){
		
		if(! c %in% anno$chr){
			next
		}else{
			subfc<-fc[anno$chr==c,]
		}
		subanno<-anno[anno$chr==c,]
		width<-(chrs_angles2[c]-chrs_angles1[c])/nrow(subfc)
		
		#癌种legend
		if(c=="chr20"){
			legend_Height<-per_height*2
			legend_ang_gap<-5
			for(j in 1:ncol(fc)){
				drawing<-add_text(drawing,colnames(fc)[j],
					x=center_x+(cytoband_r1-base_gap*0.5-legend_Height*(j-0.5))*sin( (chrs_angles2[c]+legend_ang_gap) /180*pi),
					y=center_y+(cytoband_r1-base_gap*0.5-legend_Height*(j-0.5))*cos( (chrs_angles2[c]+legend_ang_gap) /180*pi),
					srt=-chrs_angles2[c]-legend_ang_gap,
					adj=c(0,0.5),
					cex=0.25
				)
				drawing<-add_lines(drawing,
				x=center_x+(cytoband_r1-base_gap*c(2.5,0.5)-c(per_height,legend_Height)*(j-0.5))*sin( (chrs_angles2[c]+legend_ang_gap*c(0.1,0.9)) /180*pi),
				y=center_y+(cytoband_r1-base_gap*c(2.5,0.5)-c(per_height,legend_Height)*(j-0.5))*cos( (chrs_angles2[c]+legend_ang_gap*c(0.1,0.9)) /180*pi),
				lwd=0.5,
				col="#8e8e8e")
			}
		}
		
		for(i in 1:nrow(subfc)){
			gene<-rownames(subanno)[i]
			chr<-subanno$chr[i]
			#pathway<-strsplit(subanno$pathway[i],"wandongyi")[[1]]
			pathway<-pathways[[gene]]$pathway
			pathway_lwd<-pathways[[gene]]$pathway_lwd
			pos<-subanno$pos[i]/scale*scale_perChr[c]
			box_pos<-chrs_angles1[c]+width*(i-0.5)
			if(c!="Other"){
				x1<-center_x+(cytoband_r1-base_gap*2)*sin( box_pos /180*pi)
				y1<-center_y+(cytoband_r1-base_gap*2)*cos( box_pos /180*pi)
				x2<-center_x+(cytoband_r1-base_gap*1.25)*sin( box_pos /180*pi)
				y2<-center_y+(cytoband_r1-base_gap*1.25)*cos( box_pos /180*pi)
				xys<-c()
				if(abs(chrs_angles1[c]+pos-box_pos)>15){
					breaks<-floor(abs(chrs_angles1[c]+pos-box_pos) / 5)
					angle_tmp<-chrs_angles1[c]+pos-box_pos
					for(i in 1:breaks){
						xys<-c(xys,center_x+(cytoband_r1-base_gap*1.25)*sin( (box_pos+i*angle_tmp/(breaks+1)) /180*pi))
						xys<-c(xys,center_x+(cytoband_r1-base_gap*1.25)*cos( (box_pos+i*angle_tmp/(breaks+1)) /180*pi))
					}
				}
				x3<-center_x+(cytoband_r1-base_gap*1.25)*sin( (chrs_angles1[c]+pos) /180*pi)
				y3<-center_y+(cytoband_r1-base_gap*1.25)*cos( (chrs_angles1[c]+pos) /180*pi)
				x4<-center_x+(cytoband_r1-base_gap*0.5)*sin( (chrs_angles1[c]+pos) /180*pi)
				y4<-center_y+(cytoband_r1-base_gap*0.5)*cos( (chrs_angles1[c]+pos) /180*pi)
				drawing<-add_bezier(drawing,c(x1,y1,x2,y2,xys,x3,y3,x4,y4),lwd=0.5,col="#8e8e8e",t=seq( 0, 1, length=50 ))
			}
			
			for(p in 1:length(pathway)){
				pathways_angle_rnd<-pathways_angles[pathway[p]]+sample(1:100-50,1)/150*(pathways_angles[2]-pathways_angles[1])
				x5<-center_x+(cytoband_r1-dataHeight-base_gap*2.5)*sin( box_pos /180*pi)
				y5<-center_x+(cytoband_r1-dataHeight-base_gap*2.5)*cos( box_pos /180*pi)
				x6<-center_x+(pathway_r-base_gap/2)*sin( pathways_angle_rnd /180*pi)
				y6<-center_y+(pathway_r-base_gap/2)*cos( pathways_angle_rnd /180*pi)
				#paste0("#",as.hexmode(ceiling(pathway_lwd[p]*128+126)),gsub("#","",pathway_col[pathway[p]]))
				drawing<-add_bezier(drawing,c(x5,y5,center_x,center_y,x6,y6),col=pathway_col[pathway[p]],t=seq( 0, 1, length=50 ),lwd=pathway_lwd[p]*3+0.5,lend=3)
				pairedCount<-pairedCount+1

			}
			
			if(showGeneName){
				if(c!="Other"){
					x7<-center_x+(cytoband_r2+base_gap*2)*sin( box_pos /180*pi)
					y7<-center_y+(cytoband_r2+base_gap*2)*cos( box_pos /180*pi)
					x8<-center_x+(cytoband_r2+base_gap*1.5)*sin( box_pos /180*pi)
					y8<-center_y+(cytoband_r2+base_gap*1.5)*cos( box_pos /180*pi)
					xys<-c()
					if(abs(chrs_angles1[c]+pos-box_pos)>15){
						breaks<-floor(abs(chrs_angles1[c]+pos-box_pos) / 5)
						angle_tmp<-chrs_angles1[c]+pos-box_pos
						for(i in 1:breaks){
							xys<-c(xys,center_x+(cytoband_r2+base_gap*1.5)*sin( (box_pos+i*angle_tmp/(breaks+1)) /180*pi))
							xys<-c(xys,center_x+(cytoband_r2+base_gap*1.5)*cos( (box_pos+i*angle_tmp/(breaks+1)) /180*pi))
						}
					}
					x9<-center_x+(cytoband_r2+base_gap*1.5)*sin( (chrs_angles1[c]+pos) /180*pi)
					y9<-center_y+(cytoband_r2+base_gap*1.5)*cos( (chrs_angles1[c]+pos) /180*pi)
					x10<-center_x+(cytoband_r2+base_gap*1)*sin( (chrs_angles1[c]+pos) /180*pi)
					y10<-center_y+(cytoband_r2+base_gap*1)*cos( (chrs_angles1[c]+pos) /180*pi)
					drawing<-add_bezier(drawing,c(x7,y7,x8,y8,xys,x9,y9,x10,y10),col="#8e8e8e",lwd=0.5,t=seq( 0, 1, length=50 ))
					piRNACount<-piRNACount+1
				}
				drawing<-add_text(drawing,gene,
					x=center_x+(cytoband_r2+base_gap*2.2)*sin( box_pos /180*pi),
					y=center_y+(cytoband_r2+base_gap*2.2)*cos( box_pos /180*pi),
					srt=90-box_pos,
					adj=c(0,0.5),
					cex=0.15
				)
			}
		
		
			per_height<-dataHeight/ncol(subfc)
			for(j in 1:ncol(subfc)){

				
				drawing<-add_partpie(drawing,c(center_x,center_y),cytoband_r1-base_gap*2.5-per_height*j,cytoband_r1-base_gap*2.5-per_height*(j-1),box_pos-width/2,box_pos+width/2,border=NA,lwd=0.5,col=subfc[i,j])
			}
			
			
		}
	}
	print(paste0(pairedCount," piRNA-pathway pairs.",piRNACount," piRNAs in total."))
	#画legend
	x1<-drawing$default$PlotScale[1]-base_gap*7
	y1<-base_gap*5
	x2<-drawing$default$PlotScale[1]-base_gap*6
	y2<-base_gap*10
	#drawing<-add_rect(drawing,x1,y1,x2,y2,lwd=0.5)
	drawing<-add_text(drawing,legend$title,
					x=(x1+x2)/2,
					y=y2+base_gap/3,
					adj=c(0.5,0),
					cex=0.5
				)
	for(i in 1:length(legend$cols)){
		#drawing<-add_rect(drawing, x1+(i-0.5)*(x2-x1)/(length(legend$cols)+1) ,y1-(y1-y2)/5, x1+(i+0.5)*(x2-x1)/(length(legend$cols)+1) ,y1-(y1-y2)/2 ,col=legend$cols[i],border=NA,lwd=0.5)
		drawing<-add_rect(drawing, x1,y1+(i-1)*(y2-y1)/length(legend$cols), x2 ,y1+i*(y2-y1)/length(legend$cols) ,col=legend$cols[i],border=NA,lwd=0.5)
	}
	if(!is.null(legend$texts2)){
		
		for(i in 1:length(legend$texts2)){
			
			drawing<-add_text(drawing,legend$texts2[i], x2+base_gap/2,y1+(i-0.5)*(y2-y1)/length(legend$texts2),adj=c(0,0.5))
		}
	}
	drawing<-add_text(drawing,legend$texts1[1],
		x=x1-base_gap/3,
		y=y1+base_gap/3,
		adj=c(1,0),
		cex=0.5
	)
	drawing<-add_text(drawing,legend$texts1[2],
		x=x1-base_gap/3,
		y=y2-base_gap/3,
		adj=c(1,1),
		cex=0.5
	)
	return(drawing)
}




myplot<-function(x=NULL,y=NULL,r=0.015,col=NULL,showlm=TRUE,xlab="testx",ylab="testy",main="testmain",tag="",exOut=TRUE,sampleNames=NULL,delLen=0,violin=TRUE,violin_col="#fab975"){
	#js+R双图
	if(is.null(x)){
		x=c(0:20,0:20,rnorm(20,10,3) %% 18)
		y=c(20:0,0:20,rnorm(20,10,3) %% 18)
		col=rainbow(62)
		r=abs(rnorm(62,0.02,0.01))
		xlab="testx"
		ylab="testy"
		main="testmain"
	}
	if(violin){
		violinWidth=0.2
	}else{
		violinWidth=0
	}
	org_x<-x
	org_y<-y
	x<-as.numeric(x)
	y<-as.numeric(y)
	#debugstr<-cor.test(x,y,method="spearman")$estimate
	#tag<-paste(tag,",my_cor:",debugstr)
	height_in<-4+violinWidth
	width_in<-4+violinWidth
	dpi<-300
	vioBoxWidth<-violinWidth*dpi*0.15
	width<-width_in*dpi
	height<-height_in*dpi
	drawing<-list()
	drawing$default$PlotScale<-c(width_in*dpi,height_in*dpi)
	drawing$default$dpi<-dpi
	drawing$default$height_in<-height_in
	drawing$default$width_in<-width_in
	left<-0.5*dpi+violinWidth*dpi
	right<-0.1*dpi
	top<-0.2*dpi
	bottom<-0.4*dpi+violinWidth*dpi
	tick<-0.05*dpi
	#画坐标轴
	arrow_len<-0.03*dpi
	drawing<-add_lines(drawing,x=c(left,drawing$default$PlotScale[1]-right),y=rep(bottom,2)-violinWidth*dpi,lwd=1)
	drawing<-add_lines(drawing,x=c(left,left)-violinWidth*dpi,y=c(bottom,drawing$default$PlotScale[2]-top),lwd=1)
	drawing<-add_lines(drawing,x=c(left-arrow_len,left,left+arrow_len)-violinWidth*dpi,y=c(drawing$default$PlotScale[2]-top-arrow_len,drawing$default$PlotScale[2]-top,drawing$default$PlotScale[2]-top-arrow_len),lwd=1)
	drawing<-add_lines(drawing,x=c(drawing$default$PlotScale[1]-right-arrow_len,drawing$default$PlotScale[1]-right,drawing$default$PlotScale[1]-right-arrow_len),y=c(bottom-arrow_len,bottom,bottom+arrow_len)-violinWidth*dpi,lwd=1)
	offsety<-(max(y)-min(y))/20
	offsetx<-(max(x)-min(x))/20
	ys<-autoFitAxis(min(y)-offsety,max(y)+offsety,narrow=TRUE)
	xs<-autoFitAxis(min(x)-offsetx,max(x)+offsetx,narrow=TRUE)
	if(showlm){
		linear<-lm(y~x)
		y0<-as.numeric(linear$coefficients[1])
		k<-as.numeric(linear$coefficients[2])
		x1<-min(x)
		y1<-y0+x1*k
		x2<-max(x)
		y2<-y0+x2*k
		if(y2>max(y)){
			y2<-max(y)
			x2<-(y2-y0)/k
		}else if(y2<min(y)){
			y2<-min(y)
			x2<-(y2-y0)/k
		}
		x1<-(x1-min(xs))/(max(xs)-min(xs))*(drawing$default$PlotScale[1]-left-right)
		x2<-(x2-min(xs))/(max(xs)-min(xs))*(drawing$default$PlotScale[1]-left-right)
		y1<-(y1-min(ys))/(max(ys)-min(ys))*(drawing$default$PlotScale[2]-top-bottom)
		y2<-(y2-min(ys))/(max(ys)-min(ys))*(drawing$default$PlotScale[2]-top-bottom)
		
	}
	
	x<-(x-min(xs))/(max(xs)-min(xs))*(drawing$default$PlotScale[1]-left-right)
	y<-(y-min(ys))/(max(ys)-min(ys))*(drawing$default$PlotScale[2]-top-bottom)
	
	for(i in ys[2:(length(ys)-1)]){

		y_tmp<-(i-min(ys))/(max(ys)-min(ys))*(drawing$default$PlotScale[2]-top-bottom)
		drawing<-add_lines(drawing,x=c(left,left-tick)-violinWidth*dpi,y=c(bottom+y_tmp,bottom+y_tmp),lwd=0.5)
		drawing<-add_text(drawing,i,x=left-tick*1.5-violinWidth*dpi,y=bottom+y_tmp,cex=0.5,adj=c(1,0.5))
	}
	for(i in xs[2:(length(xs)-1)]){
		x_tmp<-(i-min(xs))/(max(xs)-min(xs))*(drawing$default$PlotScale[1]-left-right)
		drawing<-add_lines(drawing,x=c(left+x_tmp,left+x_tmp),y=c(bottom,bottom-tick)-violinWidth*dpi,lwd=0.5)
		drawing<-add_text(drawing,i,x=left+x_tmp,y=bottom-tick*1.5-violinWidth*dpi,cex=0.5,adj=c(0.5,1))
	}
	if(violin){
		x_steps<-round((width-left-right)/2,0)
		d<-density(x,n=x_steps)
		ats<-d$x+left
		rangex<-ats>=left&ats<=width-right
		ats<-ats[rangex]
		
		xd<-d$y[rangex]
		xd<-(xd-min(xd))/(max(xd)-min(xd))*0.35*violinWidth*dpi+violinWidth*dpi*0.02
		
		drawing<-add_polygon(drawing,x=c(ats,rev(ats)),
			y=c(xd,-rev(xd))+bottom-violinWidth*dpi/2,
			col=violin_col
		)
		
		boxX<-boxplot(x,plot=FALSE)$stats+left
		drawing<-add_lines(drawing,x=c(boxX[1],boxX[5]),y=rep(bottom-violinWidth*dpi/2,2),col="black")
		drawing<-add_rect(drawing,boxX[2],bottom-violinWidth*dpi/2-vioBoxWidth/2,boxX[4],bottom-violinWidth*dpi/2+vioBoxWidth/2,col="black",border=NA)
		drawing<-add_circle(drawing,boxX[3],bottom-violinWidth*dpi/2,r=vioBoxWidth*0.3,col=violin_col,border=NA)
		#save(x,file="../jsonCache/debug.rda")
		#drawing$debug<-c(boxX,ats[xd==max(xd)])
		
		y_steps<-round((height-bottom-top)/2,0)
		d<-density(y,n=y_steps)
		ats<-d$x+bottom
		rangey<-ats>=bottom&ats<=height-top
		ats<-ats[rangey]
		yd<-d$y[rangey]
		yd<-(yd-min(yd))/(max(yd)-min(yd))*0.35*violinWidth*dpi+violinWidth*dpi*0.02
		
		drawing<-add_polygon(drawing,y=c(ats,rev(ats)),
			x=c(yd,-rev(yd))+left-violinWidth*dpi/2,
			col=violin_col
		)
		boxY<-boxplot(y,plot=FALSE)$stats+bottom
		drawing<-add_lines(drawing,y=c(boxY[1],boxY[5]),x=rep(left-violinWidth*dpi/2,2),col="black")
		drawing<-add_rect(drawing,left-violinWidth*dpi/2-vioBoxWidth/2,boxY[2],left-violinWidth*dpi/2+vioBoxWidth/2,boxY[4],col="black",border=NA)
		drawing<-add_circle(drawing,left-violinWidth*dpi/2,boxY[3],r=vioBoxWidth*0.3,col=violin_col,border=NA)
	}
	#画outLine
	if(exOut){
		resi_order<-order(abs(linear$residuals),decreasing=TRUE)

		
		if(abs(linear$residuals[resi_order[1]]) / abs(linear$residuals[resi_order[2]])>2){
			outIndex<-resi_order[1]
			drawing<-add_circle(drawing,left+x[outIndex],bottom+y[outIndex],r=r*dpi,col="#bbbbbb",border=NA,lwd=0.5,popupTexts=sampleNames[outIndex])
			x<-x[-outIndex]
			y<-y[-outIndex]
			sampleNames<-sampleNames[-outIndex]
		}
	}
	sampleNames<-paste0(sampleNames,"(",sprintf("%.4g",org_x),",",sprintf("%.4g",org_y),")")
	drawing<-add_circle(drawing,left+x,bottom+y,r=r*dpi,col=col,lwd=0.5,popupTexts=sampleNames)
	if(showlm){
		drawing<-add_lines(drawing,x=left+c(x1,x2),y=bottom+c(y1,y2),col=colorPool[1],lwd=2)
		
	}
	drawing<-add_text(drawing,tag,x=left+(drawing$default$PlotScale[1]-left-right)*0.7,y=bottom+(drawing$default$PlotScale[2]-top-bottom)*0.9,cex=0.5,adj=c(0.5,0.5))
	drawing<-add_text(drawing,main,x=left+(drawing$default$PlotScale[1]-left-right)/2,y=drawing$default$PlotScale[2]-top/2,cex=0.5,adj=c(0.5,0.5),bold=TRUE)
	drawing<-add_text(drawing,ylab,x=left-tick*6-violinWidth*dpi,y=(drawing$default$PlotScale[2]-top-bottom)/2+bottom,cex=0.75,adj=c(0.5,0),srt=90,bold=TRUE)
	drawing<-add_text(drawing,xlab,x=left+(drawing$default$PlotScale[1]-left-right)/2,y=bottom-tick*4-violinWidth*dpi,cex=0.75,adj=c(0.5,1),bold=TRUE)
	if(delLen!=0){
		drawing<-add_text(drawing,paste0("(",delLen," samples removed for non-expression)"),x=left+(drawing$default$PlotScale[1]-left-right)/2,y=bottom-tick*6-violinWidth*dpi,cex=0.5,adj=c(0.5,1))
	}
	return(drawing)
}


myboxplot<-function(boxdata=NULL){
	if(is.null(boxdata)){
		boxdata<-list()
		boxdata$ylab="mRNA expression level(-log10)"
		boxdata$main="box PLOT"
		boxdata$data$a$data<-rnorm(100,100,50)
		boxdata$data$a$col<-"red"
		boxdata$data$a$name<-"groutA"
		boxdata$data$b$data<-rnorm(50,20,10)
		boxdata$data$b$col<-"blue"
		boxdata$data$b$name<-"groutB"
		boxdata$data$c$data<-rnorm(70,50,20)
		boxdata$data$c$col<-"yellow"
		boxdata$data$c$name<-"groutC"
		
	}
	height_in<-4
	width_in<-4
	dpi<-300
	drawing<-list()
	drawing$default$PlotScale<-c(width_in*dpi,height_in*dpi)
	drawing$default$dpi<-dpi
	drawing$default$height_in<-height_in
	drawing$default$width_in<-width_in
	left<-0.8*dpi
	right<-0.1*dpi
	top<-0.3*dpi
	bottom<-0.4*dpi
	boxInterval_vs_width<-0.3
	plotRadius=0.05*dpi
	#画坐标轴
	tick<-0.1*dpi
	arrow_len<-0.06*dpi
	drawing<-add_lines(drawing,x=c(left,drawing$default$PlotScale[1]-right),y=rep(bottom,2),lwd=1)
	drawing<-add_lines(drawing,x=c(left,left),y=c(bottom,drawing$default$PlotScale[2]-top),lwd=1)
	drawing<-add_lines(drawing,x=c(left-arrow_len,left,left+arrow_len),y=c(drawing$default$PlotScale[2]-top-arrow_len,drawing$default$PlotScale[2]-top,drawing$default$PlotScale[2]-top-arrow_len),lwd=1)
	drawing<-add_lines(drawing,x=c(drawing$default$PlotScale[1]-right-arrow_len,drawing$default$PlotScale[1]-right,drawing$default$PlotScale[1]-right-arrow_len),y=c(bottom-arrow_len,bottom,bottom+arrow_len),lwd=1)
	
	ytotal<-list()
	for(i in 1:length(boxdata$data)){
		ytotal[[i]]<-boxdata$data[[i]]$data
	}
	ystats<-boxplot(ytotal,plot=FALSE)$stats
	offsety<-(max(ystats)-min(ystats))/20
	ys<-autoFitAxis(min(ystats)-offsety,max(ystats)+offsety)
	
	for(i in ys[-length(ys)]){

		y_tmp<-(i-min(ys))/(max(ys)-min(ys))*(drawing$default$PlotScale[2]-top-bottom)
		drawing<-add_lines(drawing,x=c(left,left-tick),y=c(bottom+y_tmp,bottom+y_tmp),lwd=1)
		drawing<-add_text(drawing,i,x=left-tick*1.5,y=bottom+y_tmp,cex=0.5,adj=c(1,0.5))
	}
	if(!is.null(boxdata$main)){
		drawing<-add_text(drawing,boxdata$main,x=left+(drawing$default$PlotScale[1]-left)/2,y=drawing$default$PlotScale[2]-top/2,cex=0.75,adj=c(0.5,0),bold=TRUE)
	}
	if(!is.null(boxdata$xlab)){
		drawing<-add_text(drawing,boxdata$xlab,x=left+(drawing$default$PlotScale[1]-left)/2,y=bottom-bottom/2,cex=0.75,adj=c(0.5,1),bold=TRUE)
	}
	if(!is.null(boxdata$ylab)){
		drawing<-add_text(drawing,boxdata$ylab,x=left/3,y=(drawing$default$PlotScale[2]-top-bottom)/2+bottom,cex=0.75,adj=c(0.5,0),srt=90,bold=TRUE)
	}
	#转换数据坐标
	y<-list()
	y_box_stats<-list()
	y_box_out<-list()
	for(i in 1:length(boxdata$data)){
		y[[i]]<-(boxdata$data[[i]]$data-min(ys))/(max(ys)-min(ys))*(drawing$default$PlotScale[2]-top-bottom)+bottom
		boxData<-boxplot(y[[i]],plot=FALSE)
		y_box_stats[[i]]<-as.numeric(boxData$stats)
		y_box_out[[i]]<-which(y[[i]] <y_box_stats[[i]][1] | y[[i]] >y_box_stats[[i]][5])
		
	}
	boxWidth<-(drawing$default$PlotScale[1]-left-right)/(length(boxdata$data)*1+(length(boxdata$data)+1)*boxInterval_vs_width)
	boxInterval<-boxWidth*boxInterval_vs_width
	x<-list()
	for(i in 1:length(boxdata$data)){
		x[[i]]<-boxInterval*i+boxWidth*(i-0.5)+left
	}
	
	
	#画box
	for(i in 1:length(boxdata$data)){
		drawing<-add_text(drawing,paste0(boxdata$data[[i]]$name,"(n=",length(boxdata$data[[i]]$data),")"),x[[i]],bottom-tick,cex=0.75,adj=c(0.5,1),bold=TRUE)
		drawing<-add_rect(drawing,x[[i]]-boxWidth/2,y_box_stats[[i]][2],x[[i]]+boxWidth/2,y_box_stats[[i]][4],col=boxdata$data[[i]]$col)
		drawing<-add_lines(drawing,rep(x[[i]],2),c(y_box_stats[[i]][4],y_box_stats[[i]][5]))
		drawing<-add_lines(drawing,rep(x[[i]],2),c(y_box_stats[[i]][1],y_box_stats[[i]][2]))
		for(j in c(1,3,5)){
			drawing<-add_lines(drawing,  c(x[[i]]-boxWidth/2,x[[i]]+boxWidth/2),  rep(y_box_stats[[i]][j],2))
		}
	}
	
	#画plot
	for(i in 1:length(boxdata$data)){
		#if(y[[i]]<0)next
		x_r<-rnorm(length(y[[i]]),1,1)
		x_r<-x_r-min(x_r)
		x_r<-x_r/max(x_r)*boxWidth+x[[i]]-boxWidth/2
		drawing<-add_rect(drawing,x[[i]]-boxWidth/2,bottom,x[[i]]+boxWidth/2,drawing$default$PlotScale[2]-top,col="#ffffff88",border=NA,groupid=paste0("boxplotgroup_",i),hideInR="true")
		normalIndex<-setdiff(1:length(y[[i]]),y_box_out[[i]])
		normalPot_y<-y[[i]][normalIndex]
		normalPot_x<-x_r[normalIndex]
		outPot_y<-y[[i]][y_box_out[[i]]]
		outPot_x<-x_r[y_box_out[[i]]]
		drawing<-add_circle(drawing,normalPot_x,normalPot_y,r=plotRadius,col=boxdata$data[[i]]$col,border="black",lwd=0.5,groupid=paste0("boxplotgroup_",i),hideInR="true")
		drawing<-add_circle(drawing,outPot_x,outPot_y,r=plotRadius*0.75,col="#eee",border=NA,lwd=0.5,groupid=paste0("boxplotgroup_",i),hideInR="true")
	}
	return(drawing)
}
mykmplot<-function(survivalpackage=NULL){
	if(is.null(survivalpackage)){
		survivalpackage<-list()
		survivalpackage$data<-data.frame(surv=sample(0:1,80,replace=TRUE),surv.time=sample(1:100,80)/10,group=sample(c("High","Low"),80,replace=TRUE))
		
		survivalpackage$pvals<-0.1122
		survivalpackage$cancer_type="ACC"
		survivalpackage$surv="OS"
		survivalpackage$gene="pir-hsa-test"
	}
	#获取变量
	survivaldata<-survivalpackage$data
	
	pvals<-survivalpackage$pvals
	cancer_type<-survivalpackage$cancer_type
	surv<-survivalpackage$surv
	gene<-survivalpackage$gene
	#survfit <- survivalpackage$survfit
	survfit <-survival::survfit(survival::Surv(surv.time , surv)~group,data=survivaldata)
	pval<-survminer::surv_pvalue(survfit,data=survivaldata)$pval
	#pval<-0
	surv_prob<-list()
	surv_time<-list()
	surv_event<-list()
	sampleNames<-list()
	sampleCounts<-c()
	startp=0
	for(i in 1:length(survfit$strata)){
		groupname<-names(survfit$strata)[i]
		#groupname<-paste0("group=",strsplit(groupname,"=")[[1]][2])
		surv_prob[[groupname]]<-survfit$surv[(startp+1):(startp+survfit$strata[i])]
		surv_time[[groupname]]<-survfit$time[(startp+1):(startp+survfit$strata[i])]
		surv_event[[groupname]]<-survfit$n.event[(startp+1):(startp+survfit$strata[i])]
		tmp<-survivaldata[survivaldata$group==gsub("group=","",groupname),]
		sampleCounts[groupname]<-nrow(tmp)
		tmp<-tmp[order(tmp$surv.time),]
		tmp<-tmp[!duplicated(tmp$surv.time),]
		sampleNames[[groupname]]<-paste(rownames(tmp),":",round(tmp$surv.time,1),"years")
		startp<-startp+survfit$strata[i]
	}
	
	
	
	
	
	#survivaldata<-survivaldata[order(survivaldata$surv.time),]
	height_in<-4
	width_in<-4
	dpi<-300
	drawing<-list()
	drawing$default$PlotScale<-c(width_in*dpi,height_in*dpi)
	drawing$default$dpi<-dpi
	drawing$default$height_in<-height_in
	drawing$default$width_in<-width_in
	#headMargin<-0.2*dpi
	#outMargin<-0.4*dpi
	#yOutMargin<-0.4*dpi
	#xOutMargin<-0.2*dpi
	tick<-0.05*dpi
	left<-0.5*dpi
	rigth<-0.1*dpi
	top<-0.1*dpi
	#left2<-drawing$default$PlotScale[1]/2+outMargin*3+yOutMargin
	bottom<-0.5*dpi
	innerWidth<-drawing$default$PlotScale[1]-left-rigth
	innerHeight<-drawing$default$PlotScale[2]-bottom-top
	arrow_len<-0.05*dpi
	
	
	#lefts<-c(left1,left2)
	#cutoffs<-c("median_cutoff","optimal_cutoff")
	cols<-c("#269534","#4c4dbc","#ff3f2e")
	
	#for(j in 1:2){
		#画坐标轴
		drawing<-add_lines(drawing,x=c(left,left+innerWidth),y=rep(bottom,2),lwd=1)
		drawing<-add_lines(drawing,x=c(left,left),y=c(bottom,bottom+innerHeight),lwd=1)

		
		drawing<-add_lines(drawing,x=c(left-arrow_len,left,left+arrow_len),y=c(-arrow_len,0,-arrow_len)+bottom+innerHeight,lwd=1)
		drawing<-add_lines(drawing,x=c(-arrow_len,0,-arrow_len)+left+innerWidth,y=c(bottom-arrow_len,bottom,bottom+arrow_len),lwd=1)
		ybase<-0.05
		yticks<-c(-ybase,(0:4)*0.25,1.1)
		yscale<-1.2/innerHeight
		
		xticks<-autoFitAxis(min(survfit$time),max(survfit$time))
		xscale<-(max(xticks)-0)/innerWidth
		xbase<-0
		for(i in yticks[-length(yticks)][-1]){

			
			drawing<-add_lines(drawing,x=c(left,left-tick),y=rep(bottom+(i+ybase)/yscale,2),lwd=1)
			drawing<-add_text(drawing,i,x=left-tick*1.5,y=bottom+(i+ybase)/yscale,cex=0.5,adj=c(1,0.5))
		}
		for(i in xticks[-length(xticks)]){
			
			drawing<-add_lines(drawing,x=rep(left+i/xscale,2),y=c(bottom,bottom-tick),lwd=1)
			drawing<-add_text(drawing,i,x=left+i/xscale,y=bottom-tick*1.5,cex=0.5,adj=c(0.5,1))
		}
		drawing<-add_text(drawing,"Time(years)",x=left+innerWidth/2,y=bottom-tick*5,cex=0.75,adj=c(0.5,1),bold=TRUE)
		drawing<-add_text(drawing,"Survival probability",x=left-tick*7,y=bottom+innerHeight/2,cex=0.75,adj=c(0.5,0),srt=90,bold=TRUE)
		
		#画生存数据
		surv_tick<-0.05*dpi
		groups=names(survfit$strata)
		
		#groups_forjs=c("basesurvline_","boldsurvline_")
		#for(group_forjs in groups_forjs){
			legend_leftbase=left+innerWidth/10
			legend_ybase=bottom+innerHeight*0.95
			for(s in 1:length(groups)){
				#if(group_forjs=="boldsurvline_"){
				#	drawing<-add_rect(drawing,left,bottom,left+innerWidth,bottom+innerHeight,col="#ffffffdd",border=NA,groupid=paste0(group_forjs,s),hideInR="true")
				#}else{
					hideInR=NULL
				#}
				#画legend
				legendTag<-paste0(gsub("group=","",groups[s]),"(n=",sampleCounts[s],")")
				drawing<-add_text(drawing,legendTag,x=legend_leftbase,y=legend_ybase,cex=0.75,adj=c(0,0.5),hideInR=hideInR)
				legend_leftbase=legend_leftbase+getStrLen(legendTag)*dpi*0.75+0.05*dpi
				drawing<-add_lines(drawing,x=legend_leftbase+c(0,surv_tick*4),y=rep(legend_ybase,2),lwd=2.5,col=as.character(cols[s]),,hideInR=hideInR)
				drawing<-add_lines(drawing,x=rep(legend_leftbase+surv_tick*2,2),y=legend_ybase+c(-surv_tick,surv_tick),lwd=1.5,col=as.character(cols[s]),hideInR=hideInR)
				drawing<-add_lines(drawing,x=legend_leftbase+surv_tick*2+c(surv_tick,-surv_tick),y=rep(legend_ybase,2),lwd=1.5,col=as.character(cols[s]),hideInR=hideInR)
				legend_leftbase=legend_leftbase+surv_tick*4+0.1*dpi
				
				xs<-left
				ys<-(1+ybase)/yscale+bottom
				groupid=groups[s]
				for(i in 1:length(surv_event[[groupid]])){
					if(surv_event[[groupid]][i]==1){
						xs<-c(xs,rep(surv_time[[groupid]][i]/xscale+left,2))
						ys<-c(ys,tail(ys,1))
						ys<-c(ys,(surv_prob[[groupid]][i]+ybase)/yscale+bottom)
					}else if(surv_event[[groupid]][i]==0){
						if(is.na(tail(ys,1)))print("na....")
						drawing<-add_lines(drawing,x=rep(surv_time[[groupid]][i]/xscale+left,2),y=c(surv_tick,-surv_tick)+tail(ys,1),lwd=1.5,col=as.character(cols[s]),hideInR=hideInR,popupTexts=sampleNames[[groupid]][i])
						drawing<-add_lines(drawing,x=surv_time[[groupid]][i]/xscale+left+c(surv_tick,-surv_tick),y=rep(tail(ys,1),2),lwd=1.5,col=as.character(cols[s]),hideInR=hideInR,popupTexts=sampleNames[[groupid]][i])
						xs<-c(xs,surv_time[[groupid]][i]/xscale+left)
						ys<-c(ys,tail(ys,1))
					}
				}
				#print(xs)
				#print(ys)
				
				drawing<-add_lines(drawing,x=xs,y=ys,lwd=2.5,col=as.character(cols[s]),hideInR=hideInR)
			}
		#}
		drawing<-add_text(drawing,paste("p =",sprintf("%.4g",pval)),x=left+innerWidth/20,y=bottom+innerHeight/20,cex=0.75,adj=c(0,0.5))
	#}
	return(drawing)

}
mygsea<-function(geneList=NULL,geneSets=NULL,metricLab="metric",xlab="Rank of genes",main="title"){
	time1<-Sys.time()
	library(RColorBrewer)
	colorPool<- brewer.pal(9,name = "Set1")
	if(is.null(geneList)){
		load("/backup/wdy/Projects/piRNA-qtl/可视化图/kk.rdata")
		geneList<-kk@geneList
		geneSets<-kk@geneSets[kk@result$ID[9:11]]
	}
	geneList<-na.omit(geneList)
	#geneList<-geneList[order(geneList,decreasing=FALSE)]
	gseaLines<-list()
	for(i in 1:length(geneSets)){
		sumS<-sum(abs(na.omit(geneList[geneSets[[i]]])))
		x<-c(0)
		y<-c(0)
		curr_y<-0
		for(j in 1:length(geneList)){
			if(names(geneList[j]) %in% geneSets[[i]]){
				#x<-c(x,j,j)
				#y<-c(y,curr_y,curr_y+abs(geneList[j])/sumS)
				x[1:2+length(x)]<-j
				y[1:2+length(y)]<-c(curr_y,curr_y+abs(geneList[j])/sumS)
				curr_y<-curr_y+abs(geneList[j])/sumS
			}else{
				curr_y<-curr_y-1/length(geneList)
			}
		
		}
		gseaLines[[names(geneSets[i])]]$x<-c(x,j)
		gseaLines[[names(geneSets[i])]]$y<-as.numeric(c(y,curr_y))
	}
	maxy<-max(sapply(gseaLines,function(x){max(x$y)}))
	miny<-min(sapply(gseaLines,function(x){min(x$y)}))

	
	dpi<-300
	width_in<-5
	height_in<-4
	
	
	
	width<-width_in*dpi
	height<-height_in*dpi
	
	left<-0.5*dpi
	right<-0.1*dpi
	bottom<-0.4*dpi
	top<-0.3*dpi
	gap<-0.1*dpi
	curvHeight<-(height-bottom-top)*0.5
	rankHeight<-(height-bottom-top)*0.15
	metricHeight<-(height-bottom-top)*0.25
	
	dpi<-300
	drawing<-list()
	drawing$default$PlotScale<-c(width_in*dpi,height_in*dpi)
	drawing$default$dpi<-dpi
	drawing$default$height_in<-height_in
	drawing$default$width_in<-width_in
	drawing<-add_text(drawing,main,x=left+(width-left-right)/2,y=height-top*0.1,adj=c(0.5,1),cex=0.75,bold=TRUE)

	#画EScurv
	curvBase<-bottom+rankHeight+metricHeight+gap*2
	drawing<-add_lines(drawing,rep(left,2),curvBase+c(0,curvHeight))
	
	tick_len<-0.1*dpi
	yticks<-autoFitAxis(miny,maxy)
	
	for(i in 2:length(yticks)){
		y<-curvBase+curvHeight/(length(yticks)-1)*(i-1)
		
		drawing<-add_lines(drawing,left+c(-tick_len,0),rep(y,2),lwd=0.5)
		drawing<-add_text(drawing,yticks[i],left-tick_len*1.2,y,adj=c(1,0.5))
	}
	
	yscale<-(maxy-miny)/(tail(yticks,1)-yticks[1])
	yoffset<-(miny-yticks[1])/(tail(yticks,1)-yticks[1])*curvHeight
	drawing<-add_lines(drawing,c(left,width-right),rep(((0-miny)/(maxy-miny)*curvHeight)*yscale+curvBase+yoffset,2),lty="dashed")
	for (i in 1:length(gseaLines)){
		x<-gseaLines[[i]]$x-min(gseaLines[[i]]$x)
		x<-x/max(x)*(width-left-right)+left
		y<-gseaLines[[i]]$y-miny
		y<-(y/(maxy-miny)*curvHeight)*yscale+curvBase+yoffset
		drawing<-add_lines(drawing,x,y,col=colorPool[i %% length(colorPool)+1],lwd=2)
	}
	drawing<-add_text(drawing,"Enrichment Score",x=left-tick_len*3,y=curvBase+curvHeight/2,srt=90,adj=c(0.5,0),cex=0.75,bold=TRUE)

	#画rank
	for(i in 1:length(geneSets)){
		baseline<-bottom+metricHeight+(i-1)/length(geneSets)*rankHeight+gap
		for(j in 1:length(geneSets[[i]])){
			tmprank<-match(geneSets[[i]][j],names(geneList))
			if(!is.na(tmprank)){
				x<-left+tmprank/length(geneList)*(width-left-right)
				drawing<-add_lines(drawing,x=rep(x,2),y=baseline+c(0,rankHeight/length(geneSets)),col=colorPool[i %% length(colorPool)+1],lwd=0.5)
			}
		}
	}

	#画metric
	yticks<-autoFitAxis(min(geneList),max(geneList),TRUE)
	yscale<-metricHeight/(max(yticks)-min(yticks))
	drawing<-add_lines(drawing,x=c(left,left,width-right),y=c(bottom+metricHeight,bottom,bottom))
	for(i in 2:(length(yticks)-1)){
		y<-bottom+(yticks[i]-min(yticks))*yscale
		drawing<-add_lines(drawing,left+c(-tick_len,0),rep(y,2),lwd=0.5)
		drawing<-add_text(drawing,yticks[i],left-tick_len*1.2,y,adj=c(1,0.5))
	}

	drawing<-add_text(drawing,metricLab,x=left-tick_len*3,y=bottom+metricHeight/2,srt=90,adj=c(0.5,0),cex=0.75,bold=TRUE)
	xticks<-autoFitAxis(1,length(geneList),TRUE)
	for(i in 2:(length(xticks)-1)){
		x<-xticks[i]/length(geneList)*(width-left-right)+left
		drawing<-add_lines(drawing,rep(x,2),bottom+c(-tick_len,0),lwd=0.5)
		drawing<-add_text(drawing,xticks[i],x,bottom-tick_len*1.2,adj=c(0.5,1))
	
	}
	ys<-c(0)
	xs<-c(1)

	for(i in 1:length(geneList)){
		#ys<-c(ys,geneList[i],geneList[i])
		#xs<-c(xs,i,i+1)
		ys[(1:2)+2*i-1]<-geneList[i]
		xs[(1:2)+2*i-1]<-c(i,i+1)
	}

	ys<-as.numeric((c(ys,0)-min(yticks))*yscale+bottom)
	xs<-c(xs,length(geneList))/length(geneList)*(width-left-right)+left
	drawing<-add_polygon(drawing,xs,ys,border=NA,col="#888888")
	drawing<-add_text(drawing,xlab,x=left+(width-left-right)/2,y=bottom-tick_len*2,adj=c(0.5,1),cex=0.75)

	#画legend
	#legendHeight<-height*0.07*length(length(geneSets))
	legendLineHeight<-height*0.025*length(length(geneSets))
	legendTop<-height-top-gap
	#legendBase<-height-top-legendHeight
	lineLen<-0.2*dpi
	legendLeft<-width-left-lineLen-max(sapply(names(geneSets),getStrLen))*dpi/2
	for(i in 1:length(geneSets)){
		y<-legendTop-(i-0.5)*legendLineHeight
		drawing<-add_lines(drawing,x=legendLeft+c(0,lineLen),y=rep(y,2),col=colorPool[i %% length(colorPool)+1],lwd=2)
		drawing<-add_text(drawing,names(geneSets)[i],x=legendLeft+lineLen+gap,y=y,adj=c(0,0.5),col=colorPool[i %% length(colorPool)+1])
	}

	#drawing$debug<-round(c(time2-time1,time3-time2,time5-time4,time6-time5,time7-time6,time8-time7,time9-time8),2)
	return(drawing)
	
}
#===================功能函数=========================
autoFitAxis<-function(bottom,top,narrow=FALSE,offset=FALSE){

	range<-top-bottom
	scale<-10^floor(log(range,10))
	rangeAdj<-range/scale
	if(rangeAdj<1.5){
		seg<-0.25
	}else if(rangeAdj<4){
		seg<-0.5
	}else if(rangeAdj<7){
		seg<-1
	}else{
		seg<-2
	}
	res<-seq(floor(bottom/(seg*scale))*(seg*scale),ceiling(top/(seg*scale))*(seg*scale),seg*scale)
	if(narrow){
		if(offset){
			step<-res[res>bottom&res<top][2]-res[res>bottom&res<top][1]
			res<-c(bottom-step*0.2,res[res>bottom&res<top],top+step*0.2)
		}else{
			res<-c(bottom,res[res>bottom&res<top],top)
		}
	}
	return(res)
}

transToReal<-function(yTicks,realBound,x){
	res<-(x-min(yTicks))/(max(yTicks)-min(yTicks))*(realBound[2]-realBound[1])+realBound[1]
	return(res)
}
getStrLen<-function(str,cex=1){
  
  lettersSize<-c(11.1,11.1,12,12,11.1,10.2,13,12,4.6,8.4,
                 11.1,9.3,13.9,12,13,11.1,13,12,11.1,10.2,
                 12,11.1,15.7,11.1,11.1,10.2,
                 9.3,9.1,8.4,9.3,9.3,4.6,9.3,9.3,3.7,3.7,8.4,3.7,13.9,9.3,9.3,9.3,9.3,5.5,8.4,4.6,9.3,8.4,12,8.3,8.3,8.3,
                 9.7,9.7,9.3,4.7,4.7,14.9,5.6,5.6,9.3,9.3,9.3,9.3,9.3,9.3,9.3,9.3,9.3,9.3,4.7,9.7)/100
  symbols<-c("-","+","_",",",".","%","(",")",0:9," ","?")
  text<-c(LETTERS,letters,symbols)
  names(lettersSize)<-text
  fullLengh<-0
  for(i in 1:nchar(str)){
    if(substring(str,i,i) %in% names(lettersSize)){
      fullLengh<-lettersSize[substring(str,i,i)]+fullLengh
    }else{
      fullLengh<-mean(lettersSize)+fullLengh
      print(paste(substring(str,i,i)," is unknown, replaced with average length!"))
    }
  }
  return(as.numeric(fullLengh*cex))
  
}
RGBAtoRGB<-function(col){
	a<-as.numeric(paste0("0X",substring(col,8,9)))/255
	r<-as.numeric(paste0("0X",substring(col,2,3)))
	g<-as.numeric(paste0("0X",substring(col,4,5)))
	b<-as.numeric(paste0("0X",substring(col,6,7)))
	r<-r+(255-r)*(1-a)
	g<-g+(255-g)*(1-a)
	b<-b+(255-b)*(1-a)
	return(rgb(r,g,b,maxColorValue = 255))
	
	
}