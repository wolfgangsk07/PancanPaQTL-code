
function updateHomeDiagram(){
	var colorPool=['#E41A1C', '#A73C52', '#6B5F88', '#3780B3', '#3F918C', '#47A266',
		'#53A651', '#6D8470', '#87638F', '#A5548D', '#C96555', '#ED761C',
		'#FF9508', '#FFC11A', '#FFEE2C', '#EBDA30', '#CC9F2C', '#AD6428',
		'#BB614F', '#D77083', '#F37FB8', '#DA88B3', '#B990A6', '#999999']
	//=================画第0段
	
	
	
	
	
	
	//=================画第一段
	var para0=document.getElementsByClassName("paragraph")[0]
	var homeblock_title0=document.createElement("div")
	homeblock_title0.className="homeblock_title"
	homeblock_title0.innerHTML="Overview"
	para0.append(homeblock_title0)
	var homeblock_content0=document.createElement("div")
	para0.append(homeblock_content0)
	homeblock_content0.className="homeblock_content homeblock_content0"
	
	//左侧介绍
	var briefIntro=document.createElement("div")
	homeblock_content0.append(briefIntro)
	briefIntro.className="para0_briefIntro"
	briefIntro.innerHTML="<p>Most human genes have multiple promoters that control the expression of distinct isoforms. The use of these alternative promoters enables the regulation of isoform expression pre-transcriptionally, which present a significant influence on the cancer transcriptome. Alternative promoters are frequently found in cancer, which could contribute to the cellular transformation of cancer and become highly relevant as sensors and tumor-restricted activators for immunotherapy and the development of novel cancer drugs. Recent studies have revealed the significant roles of genetic variants on promoter usage (puQTLs). Therefore, we systematically investigated the effects of single nucleotide polymorphisms (SNPs) on promoter usage, and identified puQTLs across 33 cancer types from TCGA. In addition, we also identified associations between promoter activity and pharmacogenomic and immune infiltration across human cancers.</p>"+
		'<br><p>In Pancan-puQTL, users can:</p>'+
		'<br><p>1) <span style="font-weight:bold;">Cis/Trans-puQTLs: </span>Browse or search cis-puQTLs and trans-puQTLs across different cancer types; </p>'+
		'<br><p>2) <span style="font-weight:bold;">Survival-puQTLs: </span>Browse or search puQTLs associated with patient overall survival across different cancer types; </p>'+
		'<br><p>3) <span style="font-weight:bold;">GWAS-puQTLs: </span>Browse or search puQTLs in GWAS linkage disequilibrium (LD) regions;</p>'+
		'<br><p>4) <span style="font-weight:bold;">Drug-puQTLs: </span>Browse or search association between promoter activity and drug response across human cancers;</p>'+
		'<br><p>5) <span style="font-weight:bold;">Immune-puQTLs: </span>Browse or search association between promoter activity and different type of immune cell infiltration across human cancers;</p>'+
		'<br><p>6) Download all results and figures.</p>'

	//右侧body
	var bodyBox=document.createElement("div")
	homeblock_content0.append(bodyBox)
	bodyBox.className="bodyBox"
	bodyBox.innerHTML='<img  src="pic/body.png" style="margin:0 100px;width:244px;height:651px;">'
	
	var xs=[100,120,98,122,109,
	82,99,122,134,130,
	93,93,147,103,109,
	96,91,154,147,150,
	127,136,124,122,75,
	160,143,126,125,122,
	111,111,137]
	
	var ys=[233,339,170,326,226,
	294,402,100,19,68,
	251,251,251,443,19,
	209,163,165,279,326,
	223,240,355,328,515,
	438,225,369,89,153,
	338,338,44]
	
	
	var box_xs=[0,-80,-25,-95,-78,
	-30,0,244,215,244,
	-10,-90,244,20,20,
	0,-10,244,244,274,
	244,280,-70,250,20,
	244,230,244,20,-5,
	-30,280,220]
	
	var box_ys=[233,365,170,315,215,
	294,432,110,15,72,
	268,255,251,473,19,
	200,150,150,279,346,
	180,235,400,315,515,
	510,210,420,75,120,
	338,385,44]
	/*
	"ACC",		"BLCA",		"BRCA",		"CESC",		"CHOL",
	"COAD",		"DLBC",		"ESCA",		"GBM",		"HNSC",
	"KICH",		"KIRC",		"KIRP",		"LAML",		"LGG",
	"LIHC",		"LUAD",		"LUSC",		"MESO",		"OV",
	"PAAD",		"PCPG",		"PRAD",		"READ",		"SARC",
	"SKCM",		"STAD",		"TGCT",		"THCA",		"THYM",
	"UCEC",		"UCS",		"UVM"
	
		"Adrenocortical Carcinoma",
		"Bladder Urothelial Carcinoma",
		"Breast Invasive Carcinoma",
		"Cervical Squamous Cell Carcinoma and Endocervical Adenocarcinoma",
		"Cholangiocarcinoma",
		
		"Colon Adenocarcinoma",
		"Lymphoid Neoplasm Diffuse Large B-cell Lymphoma",
		"Esophageal Carcinoma",
		"Glioblastoma Multiforme",
		"Head and Neck Squamous Cell Carcinoma",
		
		"Kidney Chromophobe",
		"Kidney Renal Clear Cell Carcinoma",
		"Kidney Renal Papillary Cell Carcinoma",
		"Acute Myeloid Leukemia",
		"Brain Lower Grade Glioma",
		
		"Liver Hepatocellular Carcinoma",
		"Lung Adenocarcinoma",
		"Lung Squamous Cell Carcinoma",
		"Mesothelioma",
		"Ovarian Serous Cystadenocarcinoma",
		
		"Pancreatic Adenocarcinoma",
		"Pheochromocytoma and Paraganglioma",
		"Prostate Adenocarcinoma",
		"Rectum Adenocarcinoma",
		"Sarcoma",
		
		"Skin Cutaneous Melanoma",
		"Stomach Adenocarcinoma",
		"Testicular Germ Cell Tumors",
		"Thyroid Carcinoma",
		"Thymoma",
		
		"Uterine Corpus Endometrial Carcinoma",
		"Uterine Carcinosarcoma",
		"Uveal Melanoma"
	*/
	
	
	var bigTagBox=document.createElement('div')
	bodyBox.append(bigTagBox)
	bigTagBox.className="bigTagBox"
	
	for(var i=0;i<initParams.cancerTypes_short.length-1;i++){
		var x=xs[i]
		var y=ys[i]
		var box_x=box_xs[i]
		var box_y=box_ys[i]
		var tag=document.createElement("p")
		tag.innerHTML='<span style="font-weight:bold;">'+initParams.cancerTypes_short[i+1]+'</span>(<span style="color:red;">'+initParams.sampleCount[initParams.cancerTypes_short[i+1]]+'</span>)'
		//var tag='<p>'+initParams.cancerTypes_short[i+1]+'(<span style="color:red;">'+initParams.sampleCount["TCGA-"+initParams.cancerTypes_short[i+1]][0]+'</span>+<span style="color:blue;">'+initParams.sampleCount["TCGA-"+initParams.cancerTypes_short[i+1]][1]+'</span>)</p>'
		var tagBox=document.createElement("div")
		
		bigTagBox.append(tagBox)
		tagBox.className="tagBox popupText"
		tagBox.append(tag)
		var tagWidth=tagBox.clientWidth
		var tagHeight=tagBox.clientHeight
		tag.style.zIndex=10
		tag.style.position="absolute"
		tagBox.style.left=box_x-tagWidth/2+"px"
		tagBox.style.top=box_y-tagHeight/2+"px"
		tagBox.setAttribute("popupText",initParams.cancerTypes_full[i+1])

		if(box_x>122){
			var ori=-1
		}else{
			var ori=1
		}
		var bodyTag=SVG(tagBox);
		bodyTag.viewbox(0,0,tagWidth,tagHeight).size(tagWidth,tagHeight)
		//bodyTag.setAttribute("width",)
		
		
		
		
		
		bodyTag.path("M "+(tagWidth/2-tagWidth/2*ori)+" 0"+
		" L "+(tagWidth/2+tagWidth/2*ori)+" 0"+
		" L "+(tagWidth/2+tagWidth/2*ori)+" "+tagHeight/4+
		" L "+(x-box_x+tagWidth/2)+" "+(y-box_y+tagHeight/2)+
		" L "+(tagWidth/2+tagWidth/2*ori)+" "+tagHeight*3/4+
		" L "+(tagWidth/2+tagWidth/2*ori)+" "+tagHeight+
		" L "+(tagWidth/2-tagWidth/2*ori)+" "+tagHeight+" z").attr({
			stroke:"grey",
			"stroke-width":"0.5px",
			fill:"transparent"

		})
		
		//添加bodytag的legend
		if(initParams.cancerTypes_short[i+1]=="SKCM"){
			bodyTag.line(4, tagHeight-5, 40, tagHeight-5).attr({
				"stroke-width": 1
			})
			bodyTag.line(45, tagHeight-5, 62, tagHeight-5).attr({
				"stroke-width": 1,
				stroke:"red"
			})

			
			bodyTag.line(4, tagHeight-5, 4, 50).attr({
				"stroke-width": 1
			})
			bodyTag.line(45, tagHeight-5, 45, 50).attr({
				"stroke-width": 1,
				stroke:"red"
			})
	
			
			
			
			bodyTag.plain("Cancer Type").attr({
				y:60,
				x:3,
				"font-size":12,
				"dominant-baseline":  "central",
				transform:'rotate(45,3 60)'
			})
			bodyTag.plain("Tumor Samples").attr({
				y:60,
				x:45,
				"font-size":12,
				fill:"red",
				"dominant-baseline":  "central",
				transform:'rotate(45,45 60)'
			})
		}
	}
	

	
	
	

	//=================画第二段
	var paragraph1=document.getElementsByClassName("paragraph")[1]
	//话Pie
	var homeblock_title1=document.createElement("div")
	homeblock_title1.className="homeblock_title"
	homeblock_title1.innerHTML="Statistic"
	paragraph1.append(homeblock_title1)
	var homeblock_content1=document.createElement("div")
	homeblock_content1.className="homeblock_content homeblock_content1"

	var piebox=document.createElement("div")
	piebox.className="piebox"
	var drawing_pie=SVG(piebox)

	var pieR=150
	var Vmargin=1*pieR
	var Hmargin=1*pieR

	drawing_pie.attr({"text-rendering":"optimizeLegibility"})
	//pie.width(pieR*2+Hmargin+"px")
	//pie.height(pieR*2+Vmargin+"px")
	
	drawing_pie.width("100%")
	drawing_pie.height("100%")
	
	drawing_pie.viewbox(0,0,pieR*2+Hmargin,pieR*2+Vmargin)
	
	var pieBlankRatio=0.6
	var totalsamples=initParams.totalSampleCount

	var samplekeys=Object.keys(initParams.sampleCount).sort()

	/*
	for(var i=0;i<samplekeys.length;i++){
		totalsamples+=initParams.samplecount[samplekeys[i]]
	}
	*/
	var plottedLength=0

	for(var i=0;i<samplekeys.length;i++){
		var sampleCount_sum=initParams.sampleCount[samplekeys[i]]

		var subpie_g=drawing_pie.group().attr({
				class:"subPie_g"
			})
		var subpie=drawing_pie.path(drawPie(pieR+Hmargin/2,pieR+Vmargin/2,pieR*pieBlankRatio,pieR,sampleCount_sum/totalsamples*2*Math.PI,plottedLength/totalsamples*2*Math.PI)).attr({
			stroke:"white",
			"stroke-width":"0.5px",
			fill:colorPool[i%colorPool.length],
			class:"PieInfo"
		})
		
		var textang=(plottedLength+sampleCount_sum/2)/totalsamples*2*Math.PI
		if(textang>Math.PI){
			var textAnchor="end"
			var angPatch=180
		}else{
			var textAnchor="start"
			var angPatch=0
		}
		var subpie_txt=drawing_pie.plain(samplekeys[i]).attr({
			y:pieR+Vmargin/2+Math.cos(textang)*pieR,
			x:pieR+Hmargin/2+Math.sin(textang)*pieR,
			"text-anchor":textAnchor,
			"dominant-baseline":  "central",
			"font-size":7,
			"font-weight":"bold",
			fill:colorPool[i%colorPool.length],
			stroke:"none",
			transform:"rotate("+(angPatch+90-textang*180/Math.PI)+" "+(pieR+Hmargin/2+Math.sin(textang)*pieR)+","+(pieR+Vmargin/2+Math.cos(textang)*pieR)+")"
		})
		subpie_g.add(subpie)
		subpie_g.add(subpie_txt)
		var g=drawing_pie.group().attr({
				class:"PieInfo_txt"
			})
		
		
		var txt1=drawing_pie.plain(samplekeys[i]).attr({
			y:pieR+Vmargin/2-12,
			x:pieR+Hmargin/2,
			"text-anchor":"middle",
			"dominant-baseline":  "central",
			"font-size":20,
			"font-weight":"bold",
			fill:colorPool[i%colorPool.length],
			stroke:"none"
		})
		var txt2=drawing_pie.plain("has "+initParams.sampleCount[samplekeys[i]]+" tumor").attr({
			y:pieR+Vmargin/2+12,
			x:pieR+Hmargin/2,
			"text-anchor":"middle",
			"dominant-baseline":  "central",
			"font-size":20,
			"font-weight":"bold",
			fill:colorPool[i%colorPool.length],
			stroke:"none"
		})
		g.add(txt1)
		g.add(txt2)
		plottedLength+=sampleCount_sum
	}
	drawing_pie.plain(totalsamples+" tumor").attr({
			y:pieR+Vmargin/2-12,
			x:pieR+Hmargin/2,
			"text-anchor":"middle",
			"dominant-baseline":  "central",
			"font-size":22,
			"font-weight":"bold",
			fill:"#888",
			stroke:"none",
			class:"PieInfo_maintxt"
		})
	drawing_pie.plain("samples in total").attr({
			y:pieR+Vmargin/2+12,
			x:pieR+Hmargin/2,
			"text-anchor":"middle",
			"dominant-baseline":  "central",
			"font-size":22,
			"font-weight":"bold",
			fill:"#888",
			stroke:"none",
			class:"PieInfo_maintxt"
		})
	homeblock_content1.append(piebox)
	paragraph1.append(homeblock_content1)
	//画histplot
	var histbox=document.createElement("div")
	histbox.className="histbox"
	var width=800
	var height=600
	var interval=5
	var drawing_hist=SVG(histbox)

	var Vmargin=0.1*width
	var Hmargin=0.1*width
	var histWidth=10
	drawing_hist.attr({"text-rendering":"optimizeLegibility"})
	drawing_hist.width("100%")
	drawing_hist.height("100%")
	drawing_hist.viewbox(0,0,width+2*Hmargin,height+2*Vmargin)
	
	parts=["cis_QTL_Count","trans_QTL_Count","survival","gwasqtl","drugs","immune"]
	Ylabs=["cis QTL","trans QTL","Survival","GWAS QTL","Drugs","Immune"]
	var ybaseline=height/3
	drawing_hist.plain("Result Count").attr({
		y:height/2+Vmargin,
		x:Hmargin*0.4,
		"text-anchor":"middle",
		"dominant-baseline":  "central",
		"font-size":22,
		"font-weight":"bold",
		fill:"#888",
		stroke:"none",
		transform:"rotate(-90 "+Hmargin*0.4+","+(height/2+Vmargin)+")"
	})
	for(var i=0;i<parts.length;i++){
		
		drawing_hist.line(Hmargin,ybaseline,width+Hmargin,ybaseline).attr({
			'stroke-width':2
		})
		drawing_hist.plain(Ylabs[i]).attr({
			y:ybaseline-(height-Vmargin)/parts.length/2,
			x:Hmargin*0.8,
			"text-anchor":"middle",
			"dominant-baseline":  "central",
			"font-size":16,
			"font-weight":"bold",
			fill:"#888",
			stroke:"none",
			transform:"rotate(-90 "+Hmargin*0.8+","+(ybaseline-(height-Vmargin)/parts.length/2)+")"
		})
		var values=[]
		var keys=Object.keys(initParams[parts[i]]).sort()
		for(var k=0;k<keys.length;k++){
			values.push(initParams[parts[i]][keys[k]])
		}
		var maxvalue=Math.max.apply(null, values)
		var xbaseline=Hmargin+width/keys.length/2
		
		for(var k=0;k<keys.length;k++){
			if(i<2){
				if(initParams[parts[i]][keys[k]]!=0){
					//var heightRatio=Math.log(initParams[parts[i]]["count"][keys[k]])/Math.log(maxvalue)
					var heightRatio=initParams[parts[i]][keys[k]]/maxvalue
				}else{
					var heightRatio=0
				}
			}else{
				var heightRatio=initParams[parts[i]][keys[k]]/maxvalue
			}
			var histg=drawing_hist.group()
			var rect1=drawing_hist.rect(width/keys.length,height/parts.length-Vmargin/parts.length).attr({
				x:xbaseline-width/keys.length/2,
				y:ybaseline-(height/parts.length-Vmargin/parts.length),
				fill:"transparent",
				class:"homehist"
			})
			var rect2=drawing_hist.rect(histWidth,heightRatio*(height/parts.length-Vmargin/parts.length)).attr({
				x:xbaseline-histWidth/2,
				y:ybaseline-heightRatio*(height/parts.length-Vmargin/parts.length),
				fill:colorPool[k%colorPool.length]
			})
			var text1=drawing_hist.plain(initParams[parts[i]][keys[k]]).attr({
				y:ybaseline-heightRatio*(height/parts.length-Vmargin/parts.length),
				x:xbaseline,
				"text-anchor":"middle",
				"dominant-baseline":  "text-after-edge",
				"font-size":5,
				"font-weight":"bold",
				fill:"#888",
				stroke:"none"
			})
			histg.add(rect1)
			histg.add(rect2)
			histg.add(text1)
			if(i==5){
				var text2=drawing_hist.plain(keys[k]).attr({
					y:ybaseline+Vmargin*0.2,
					x:xbaseline,
					"text-anchor":"end",
					"dominant-baseline":  "central",
					"font-size":10,
					"font-weight":"bold",
					fill:"#888",
					stroke:"none",
					transform:"rotate(-45 "+(xbaseline)+","+(ybaseline+Vmargin*0.2)+")"
				})

			}
			xbaseline+=width/keys.length
		}
		ybaseline+=height/parts.length
	}
	homeblock_content1.append(histbox)
	addPopup()
	
	
}

function drawPie(x,y,r,r0,por,start){
	//x,y代表圆心位置，r代表扇形圆的半径，r0代表缺损扇形的半径，por代表扇形弧度(pi)，start代表扇形开始的位置（从6点钟方向逆时针）
	var d="M "+(x+Math.sin(start)*r0)+" "+(y+Math.cos(start)*r0)
	d+=" L "+(x+Math.sin(start)*r)+" "+(y+Math.cos(start)*r)
	if(por>Math.PI){
		large=1
	}else{
		large=0
	}
	d+=" A "+r+" "+r+" "+0+" "+large+" "+0+" "+(x+Math.sin(start+por)*r)+" "+(y+Math.cos(start+por)*r)
	d+=" L "+(x+Math.sin(start+por)*r0)+" "+(y+Math.cos(start+por)*r0)
	d+=" A "+r0+" "+r0+" "+0+" "+large+" "+1+" "+(x+Math.sin(start)*r0)+" "+(y+Math.cos(start)*r0)
	d+=" Z"
	return(d)
}



function addPopup(){
	var popupTexts=document.getElementsByClassName("popupText")
	for(i=0;i<popupTexts.length;i++){
		popupTexts[i].addEventListener("mouseenter", showPopup);
		popupTexts[i].addEventListener("mouseout", hidePopup);
		
		
	}
}

function showPopup(evt) {
	mypopup.innerHTML=evt.target.getAttribute("popupText")
	mypopup.style.left = (getOffsetLeft(evt.target)-mypopup.clientWidth-10) + "px";
	mypopup.style.top = getOffsetTop(evt.target)  + "px";
	mypopup.style.visibility = "visible";

}

function hidePopup(evt) {
  mypopup.style.visibility = "hidden";
}

function addhover_modules_button(divID){
	var div=document.getElementById(divID)
    div.classList.add('modules_button_hover');
}

function removehover_modules_button(divID){
	var div=document.getElementById(divID)
    div.classList.remove('modules_button_hover');
}


function addhover_modules_block(divID){
	var div=document.getElementById(divID)
	if(div!=undefined){
		div.classList.add('module_block_hover');
	}
}

function removehover_modules_block(divID){
	var div=document.getElementById(divID)
	if(div!=undefined){
		div.classList.remove('module_block_hover');
	}
}