function select_button(obj){
	var modules_buttons=document.getElementsByClassName("modules_button")
	for (var i=0;i<modules_buttons.length;i++){
		modules_buttons[i].style.background=""
		modules_buttons[i].style.color=""
	}
	obj.style.background="#a9a9a9"
	obj.style.color="white"
	
}
function init_loadJSONs(){
	var getInitParams_xmlhttp=new XMLHttpRequest();
	getInitParams_xmlhttp.onreadystatechange=function(){

		if (getInitParams_xmlhttp.readyState==4 && getInitParams_xmlhttp.status==200){
			initParams_str=getInitParams_xmlhttp.responseText;
			try {
				initParams = JSON.parse(initParams_str);
				document.body.style.display=""
				init_home()
				
			} catch (error) {
				console.log(error)
				if(typeof(initParams)=='undefined'){
					console.log("Parse initParams error, retry")
					setTimeout(function(){
						getInitParams_xmlhttp.open("GET","php/getInitParams.php",true);
						getInitParams_xmlhttp.send();
					},1000)
					return
				}
			}
		}else{
		}
	}
	getInitParams_xmlhttp.onerror=function(e){
		console.log("Parse initParams error, retry"+e)
	}

	getInitParams_xmlhttp.open("GET","php/getInitParams.php",true);
	getInitParams_xmlhttp.send();
	
	
}
function init_home(){
	main=document.getElementById("main")
	main.innerHTML=""
	var modules_block_out=document.createElement("div")
	modules_block_out.className="modules_block_out"
	
	var modules_block=document.createElement("div")
	modules_block.className="modules_block"
	modules_block_out.appendChild(modules_block)
	
	var picUrls=["cis_QTL","trans_QTL","survival_QTL","GWAS_QTL","Drug_QTL","TIL_QTL"]
	for(var i=0;i<picUrls.length;i++){
		var module1=document.createElement("div")
		module1.className="module_block"
		module1.id="module_block"+(i+1)
		module1.innerHTML='<img src="pic/'+picUrls[i]+'.png">'
		module1.setAttribute("onclick",'triggerDivClick("module'+(i+1)+'")')
		module1.setAttribute("onmouseover",'addhover_modules_button("module'+(i+1)+'")')
		module1.setAttribute("onmouseout",'removehover_modules_button("module'+(i+1)+'")')
		
		var module_button=document.getElementById("module"+(i+1))
		module_button.setAttribute("onmouseover",'addhover_modules_block("module_block'+(i+1)+'")')
		module_button.setAttribute("onmouseout",'removehover_modules_block("module_block'+(i+1)+'")')
		
		modules_block.appendChild(module1)
	}
	
	main.appendChild(modules_block_out)
	
	var paragraph1=document.createElement("div")
	paragraph1.className="paragraph"
	main.appendChild(paragraph1)
	
	var paragraph2=document.createElement("div")
	paragraph2.className="paragraph"
	main.appendChild(paragraph2)
	
	updateHomeDiagram()
}

function triggerDivClick(moduleName){
	var div = document.getElementById(moduleName);
	div.click()
}

function init_ciseqtl(){
	var inputComp=new Object()
	inputComp[0]=new Object()
	inputComp[0].type="select"
	inputComp[0].options=initParams.cancerTypes
	var options_tag=[]
	for(var i=0;i<initParams.cancerTypes.length;i++){
		options_tag.push(initParams.cancerTypes_short[i]+" ("+initParams.cancerTypes_full[i]+")")
	}
	inputComp[0].options_tag=options_tag
	inputComp[0].title="Cancer:"
	inputComp[0].tag='e.g. <span style="font-style:italic">ACC (Adrenocortical Carcinoma)</span>'

	
	inputComp[1]=new Object()
	inputComp[1].type="input"
	inputComp[1].title="PromoterID:"
	inputComp[1].tag='One or more PromoterIDs. e.g. <span style="font-style:italic">prmtr_90440,prmtr_38627</span>'
	inputComp[1].placeholder="(empty for all Promoters)"
	inputComp[1].value=""
	

	
	inputComp[2]=new Object()
	inputComp[2].type="input"
	inputComp[2].title="SNP:"
	inputComp[2].tag='One or more SNPs. e.g. <span style="font-style:italic">rs747694,rs10073495,rs4678938</span>'
	inputComp[2].placeholder="(empty for all SNPs)"
	inputComp[2].value=""
	
	inputComp[3]=new Object()
	inputComp[3].type="input"
	inputComp[3].title="P-value<=:"
	inputComp[3].tag='e.g. <span style="font-style:italic">0.005</span>'
	inputComp[3].placeholder="(empty for all)"
	inputComp[3].value=""
	
	inputComp[4]=new Object()
	inputComp[4].type="input"
	inputComp[4].title="FDR<=:"
	inputComp[4].tag='e.g. <span style="font-style:italic">0.05</span>'
	inputComp[4].placeholder="(empty for all)"
	inputComp[4].value=""
	
	inputComp[5]=new Object()
	inputComp[5].type="input"
	inputComp[5].title="Gene symbol:"
	inputComp[5].tag='One or more Genes. e.g. <span style="font-style:italic">NSFL1C,TP53</span>'
	inputComp[5].placeholder="(empty for all Genes)"
	inputComp[5].value=""
	
	init_modules_table(BriefTitle="Brief Introduction",BriefContent='<span style="font-weight:bold">Cis-puQTLs:</span> Cis-puQTLs module collected genetic variants which are significantly (FDR < 0.05) associated with promoter activity within 1 MB across human cancers, which were determined by linear regression using Matrix eQTL.',inputComp=inputComp,func="cis_eqtl",iconURL="pic/cis_QTL.png")
}

function init_transeqtl(){
	var inputComp=new Object()
	inputComp[0]=new Object()
	inputComp[0].type="select"
	inputComp[0].options=initParams.cancerTypes
	var options_tag=[]
	for(var i=0;i<initParams.cancerTypes.length;i++){
		options_tag.push(initParams.cancerTypes_short[i]+" ("+initParams.cancerTypes_full[i]+")")
	}
	inputComp[0].options_tag=options_tag
	inputComp[0].title="Cancer:"
	inputComp[0].tag='e.g. <span style="font-style:italic">ACC (Adrenocortical Carcinoma)</span>'

	
	inputComp[1]=new Object()
	inputComp[1].type="input"
	inputComp[1].title="PromoterID:"
	inputComp[1].tag='One or more PromoterIDs. e.g. <span style="font-style:italic">prmtr_90440,prmtr_38627</span>'
	inputComp[1].placeholder="(empty for all Promoters)"
	inputComp[1].value=""
	
	inputComp[2]=new Object()
	inputComp[2].type="input"
	inputComp[2].title="SNP:"
	inputComp[2].tag='One or more SNPs. e.g. <span style="font-style:italic">rs747694,rs10073495,rs4678938</span>'
	inputComp[2].placeholder="(empty for all SNPs)"
	inputComp[2].value=""
	
	inputComp[3]=new Object()
	inputComp[3].type="input"
	inputComp[3].title="P-value<=:"
	inputComp[3].tag='e.g. <span style="font-style:italic">0.005</span>'
	inputComp[3].placeholder="(empty for all)"
	inputComp[3].value=""
	
	inputComp[4]=new Object()
	inputComp[4].type="input"
	inputComp[4].title="FDR<=:"
	inputComp[4].tag='e.g. <span style="font-style:italic">0.05</span>'
	inputComp[4].placeholder="(empty for all)"
	inputComp[4].value=""
	
	inputComp[5]=new Object()
	inputComp[5].type="input"
	inputComp[5].title="Gene symbol:"
	inputComp[5].tag='One or more Genes. e.g. <span style="font-style:italic">NSFL1C,TP53</span>'
	inputComp[5].placeholder="(empty for all Genes)"
	inputComp[5].value=""
	init_modules_table(BriefTitle="Brief Introduction",BriefContent='<span style="font-weight:bold">Trans-puQTLs:</span> Trans-puQTLs module collected genetic variants which are significantly (FDR < 0.05) associated long distanced (> 1 MB) or inter-chromosomal promoter activity across human cancers, which were determined by linear regression using Matrix eQTL.',inputComp=inputComp,func="trans_eqtl",iconURL="pic/trans_QTL.png")
}



function init_gwaseqtl(){
	var inputComp=new Object()
	inputComp[0]=new Object()
	inputComp[0].type="select"
	inputComp[0].options=initParams.cancerTypes
	var options_tag=[]
	for(var i=0;i<initParams.cancerTypes.length;i++){
		options_tag.push(initParams.cancerTypes_short[i]+" ("+initParams.cancerTypes_full[i]+")")
	}
	inputComp[0].options_tag=options_tag
	inputComp[0].title="Cancer:"
	inputComp[0].tag='e.g. <span style="font-style:italic">ACC (Adrenocortical Carcinoma)</span>'
	
	inputComp[1]=new Object()
	inputComp[1].type="select"
	inputComp[1].options=["cis","trans"]
	inputComp[1].options_tag=["Cis","Trans"]
	inputComp[1].title="Cis/Trans:"
	inputComp[1].tag='e.g. <span style="font-style:italic">Cis</span>'
	
	
	inputComp[2]=new Object()
	inputComp[2].type="input"
	inputComp[2].title="tagSNP:"
	inputComp[2].tag='One or more SNPs. e.g. <span style="font-style:italic">rs747694,rs10073495,rs4678938</span>'
	inputComp[2].placeholder="(empty for all tagSNPs)"
	inputComp[2].value=""
	
	inputComp[3]=new Object()
	inputComp[3].type="input"
	inputComp[3].title="SNP:"
	inputComp[3].tag='One or more SNPs. e.g. <span style="font-style:italic">rs747694,rs10073495,rs4678938</span>'
	inputComp[3].placeholder="(empty for all SNPs)"
	inputComp[3].value=""
	
	inputComp[4]=new Object()
	inputComp[4].type="input"
	inputComp[4].title="Traits:"
	inputComp[4].tag='One or more substring(could be "eight" for "Height") of traits. e.g. <span style="font-style:italic">ight,Liver,hemoglobin</span>'
	inputComp[4].placeholder="(empty for all traits)"
	inputComp[4].value=""
	
	inputComp[5]=new Object()
	inputComp[5].type="input"
	inputComp[5].title="LD>=:"
	inputComp[5].tag='e.g. <span style="font-style:italic">0.8</span>'
	inputComp[5].placeholder="(empty for all)"
	inputComp[5].value=""
	
	inputComp[6]=new Object()
	inputComp[6].type="input"
	inputComp[6].title="Gene symbol:"
	inputComp[6].tag='One or more Genes. e.g. <span style="font-style:italic">NSFL1C,TP53</span>'
	inputComp[6].placeholder="(empty for all Genes)"
	inputComp[6].value=""
	
	inputComp[7]=new Object()
	inputComp[7].type="input"
	inputComp[7].title="PromoterID:"
	inputComp[7].tag='One or more PromoterIDs. e.g. <span style="font-style:italic">prmtr_90440,prmtr_38627</span>'
	inputComp[7].placeholder="(empty for all Promoters)"
	inputComp[7].value=""
	
	init_modules_table(BriefTitle="Brief Introduction",BriefContent='<span style="font-weight:bold">GWAS-puQTLs:</span> GWAS-puQTLs module identification: tagSNPs were derived from GWAS catalog website (http://www.ebi.ac.uk/gwas/) and the linkage disequilibrium were calculated with 1000 Genomes Phase 1 European population. Cis- or trans-puQTLs that in LD relation (r2 > 0.5) with tagSNPs were defined as GWAS- puQTLs.',inputComp=inputComp,func="gwaseqtl",iconURL="pic/GWAS_QTL.png")
}

function init_snpsurvival(){
	var inputComp=new Object()
	inputComp[0]=new Object()
	inputComp[0].type="select"
	inputComp[0].options=initParams.cancerTypes
	var options_tag=[]
	for(var i=0;i<initParams.cancerTypes.length;i++){
		options_tag.push(initParams.cancerTypes_short[i]+" ("+initParams.cancerTypes_full[i]+")")
	}
	inputComp[0].options_tag=options_tag
	inputComp[0].title="Cancer:"
	inputComp[0].tag='e.g. <span style="font-style:italic">ACC (Adrenocortical Carcinoma)</span>'
	
	inputComp[1]=new Object()
	inputComp[1].type="select"
	inputComp[1].options=["cis","trans"]
	inputComp[1].options_tag=["Cis","Trans"]
	inputComp[1].title="Cis/Trans:"
	inputComp[1].tag='e.g. <span style="font-style:italic">Cis</span>'
	
	

	
	inputComp[2]=new Object()
	inputComp[2].type="input"
	inputComp[2].title="SNP:"
	inputComp[2].tag='One or more SNPs. e.g. <span style="font-style:italic">rs747694,rs10073495,rs4678938</span>'
	inputComp[2].placeholder="(empty for all SNPs)"
	inputComp[2].value=""
	
	inputComp[3]=new Object()
	inputComp[3].type="input"
	inputComp[3].title="P-value<=:"
	inputComp[3].tag='e.g. <span style="font-style:italic">0.005</span>'
	inputComp[3].placeholder="(empty for all)"
	inputComp[3].value=""
	
	inputComp[4]=new Object()
	inputComp[4].type="input"
	inputComp[4].title="FDR<=:"
	inputComp[4].tag='e.g. <span style="font-style:italic">0.05</span>'
	inputComp[4].placeholder="(empty for all)"
	inputComp[4].value=""
	
	init_modules_table(BriefTitle="Brief Introduction",BriefContent='<span style="font-weight:bold">Survival-puQTLs:</span> Survival-puQTLs module collected cis- and trans-puQTLs which are significantly associated with patient overall survival across human cancers. For each puQTL, samples were classified into three groups: homozygous genotype AA, heterozygous genotype Aa and homozygous genotype aa (A and a represent two alleles of one SNP). The log-rank test was used to examine the differences in survival time, and Kaplan–Meier (KM) curves were plotted to represent the survival time for each group. puQTLs with FDR < 0.05 were defined as survival associated puQTLs.',inputComp=inputComp,func="snpsurvival",iconURL="pic/survival_QTL.png")
}

function init_drugs(){
	var inputComp=new Object()
	inputComp[0]=new Object()
	inputComp[0].type="select"
	inputComp[0].options=initParams.cancerTypes
	var options_tag=[]
	for(var i=0;i<initParams.cancerTypes.length;i++){
		options_tag.push(initParams.cancerTypes_short[i]+" ("+initParams.cancerTypes_full[i]+")")
	}
	inputComp[0].options_tag=options_tag
	inputComp[0].title="Cancer:"
	inputComp[0].tag='e.g. <span style="font-style:italic">ACC (Adrenocortical Carcinoma)</span>'
	
	inputComp[1]=new Object()
	inputComp[1].type="select"
	inputComp[1].options=["cis","trans"]
	inputComp[1].options_tag=["Cis","Trans"]
	inputComp[1].title="Cis/Trans:"
	inputComp[1].tag='e.g. <span style="font-style:italic">Cis</span>'
	
	

	
	inputComp[2]=new Object()
	inputComp[2].type="input"
	inputComp[2].title="SNP:"
	inputComp[2].tag='One or more SNPs. e.g. <span style="font-style:italic">rs747694,rs10073495,rs4678938</span>'
	inputComp[2].placeholder="(empty for all SNPs)"
	inputComp[2].value=""
	
	inputComp[3]=new Object()
	inputComp[3].type="input"
	inputComp[3].title="PromoterID:"
	inputComp[3].tag='One or more PromoterIDs. e.g. <span style="font-style:italic">prmtr_90440,prmtr_38627</span>'
	inputComp[3].placeholder="(empty for all Promoters)"
	inputComp[3].value=""
	
	
	inputComp[4]=new Object()
	inputComp[4].type="select"
	var drugNames=initParams.drugNames.slice()
	drugNames.unshift("")
	var drugNames_tag=initParams.drugNames.slice()
	drugNames_tag.unshift("ALL")
	inputComp[4].options=drugNames
	inputComp[4].options_tag=drugNames_tag
	inputComp[4].title="Drug name:"
	inputComp[4].tag='Drug names. e.g. <span style="font-style:italic">PLX.4720</span>'
	
	inputComp[5]=new Object()
	inputComp[5].type="input"
	inputComp[5].title="Gene symbol:"
	inputComp[5].tag='One or more Genes. e.g. <span style="font-style:italic">NSFL1C,TP53</span>'
	inputComp[5].placeholder="(empty for all Genes)"
	inputComp[5].value=""
	
	inputComp[6]=new Object()
	inputComp[6].type="select"
	var pathways=initParams.pathways.slice()
	pathways.unshift("")
	var pathways_tag=initParams.pathways.slice()
	pathways_tag.unshift("ALL")
	inputComp[6].options=pathways
	inputComp[6].options_tag=pathways_tag
	inputComp[6].title="Target pathway:"
	inputComp[6].tag='e.g. <span style="font-style:italic">Cell cycle</span>'
	
	
	init_modules_table(BriefTitle="Brief Introduction",BriefContent='<span style="font-weight:bold">Drug-puQTLs:</span> Drug-puQTLs module collected promoter activity which are significantly associated imputed drug response (FDR < 0.05) estimated by Spearman’s correlation analysis across human cancers.',inputComp=inputComp,func="drugs",iconURL="pic/Drug_QTL.png")
}

function init_immune(){
	var inputComp=new Object()
	inputComp[0]=new Object()
	inputComp[0].type="select"
	inputComp[0].options=initParams.cancerTypes
	var options_tag=[]
	for(var i=0;i<initParams.cancerTypes.length;i++){
		options_tag.push(initParams.cancerTypes_short[i]+" ("+initParams.cancerTypes_full[i]+")")
	}
	inputComp[0].options_tag=options_tag
	inputComp[0].title="Cancer:"
	inputComp[0].tag='e.g. <span style="font-style:italic">ACC (Adrenocortical Carcinoma)</span>'
	
	inputComp[1]=new Object()
	inputComp[1].type="select"
	inputComp[1].options=["cis","trans"]
	inputComp[1].options_tag=["Cis","Trans"]
	inputComp[1].title="Cis/Trans:"
	inputComp[1].tag='e.g. <span style="font-style:italic">Cis</span>'
	
	

	
	inputComp[2]=new Object()
	inputComp[2].type="input"
	inputComp[2].title="SNP:"
	inputComp[2].tag='One or more SNPs. e.g. <span style="font-style:italic">rs747694,rs10073495,rs4678938</span>'
	inputComp[2].placeholder="(empty for all SNPs)"
	inputComp[2].value=""
	
	inputComp[3]=new Object()
	inputComp[3].type="input"
	inputComp[3].title="PromoterID:"
	inputComp[3].tag='One or more PromoterIDs. e.g. <span style="font-style:italic">prmtr_90440,prmtr_38627</span>'
	inputComp[3].placeholder="(empty for all Promoters)"
	inputComp[3].value=""
	
	
	inputComp[4]=new Object()
	inputComp[4].type="select"
	var cellNames=initParams.cellNames.slice()
	cellNames.unshift("")
	var cellNames_tag=initParams.cellNames.slice()
	cellNames_tag.unshift("ALL")
	inputComp[4].options=cellNames
	inputComp[4].options_tag=cellNames_tag
	inputComp[4].title="Cell name:"
	inputComp[4].tag='Cell names. e.g. <span style="font-style:italic">Macrophage</span>'
	

	inputComp[5]=new Object()
	inputComp[5].type="select"
	var Sources=initParams.Sources.slice()
	Sources.unshift("")
	var Sources_tag=initParams.Sources.slice()
	Sources_tag.unshift("ALL")
	inputComp[5].options=Sources
	inputComp[5].options_tag=Sources_tag
	inputComp[5].title="Source:"
	inputComp[5].tag='Source. e.g. <span style="font-style:italic">ImmuCellAI</span>'
	
	inputComp[6]=new Object()
	inputComp[6].type="input"
	inputComp[6].title="Gene symbol:"
	inputComp[6].tag='One or more Genes. e.g. <span style="font-style:italic">NSFL1C,TP53</span>'
	inputComp[6].placeholder="(empty for all Genes)"
	inputComp[6].value=""
	
	init_modules_table(BriefTitle="Brief Introduction",BriefContent='<span style="font-weight:bold">Immune-puQTLs:</span> Immune- puQTLs module collected promoter activity which significantly associated immune cell abundance (FDR < 0.05) estimated by Spearman’s correlation analysis across human cancers.',inputComp=inputComp,func="immune",iconURL="pic/TIL_QTL.png")
}


function init_modules_table(BriefTitle,BriefContent,inputComp,func,iconURL=""){
	floatPanel.style.opacity="0"
	floatPanel.style.pointerEvents="none"
	main=document.getElementById("main")
	main.innerHTML=""
	//定义简介
	var briefArea=document.createElement("div")
	briefArea.className="briefArea"
	var BriefStr=document.createElement("div")
	BriefStr.className="BriefStr"
	BriefStr.innerHTML='<p class="BriefTitle">'+BriefTitle+'</p><p>'+BriefContent+'</p>'
	
	var BriefIcon=document.createElement("div")
	BriefIcon.className="BriefIcon"
	BriefIcon.innerHTML='<img src="'+iconURL+'" style="height:200px">'
	briefArea.appendChild(BriefIcon)
	briefArea.appendChild(BriefStr)
	
	main.appendChild(briefArea)
	//定义输入区
	var input_panel=document.createElement("div")
	input_panel.className="InputPanel"
	var InputItems=document.createElement("div")
	InputItems.className="InputItems"
	var keys=Object.keys(inputComp)
	for(var i=0;i<keys.length;i++){
		if(inputComp[i].type=="select"){
			var input=document.createElement("div")
			input.className="InputItem"
			var tmp='<p class="inputTitle">'+inputComp[i].title+'</p><select id="input_'+func+'_'+i+'">'

				for(var c=0;c<inputComp[i].options.length;c++){
					tmp=tmp+'<option value="'+inputComp[i].options[c]+'">'+inputComp[i].options_tag[c]+'</option>'
				}
			input.innerHTML=tmp+'</select><p class="InputTag">'+inputComp[i].tag+'</p>'
		}else if(inputComp[i].type=="input"){
			var input=document.createElement("div")
			input.className="InputItem"
			input.innerHTML='<p class="inputTitle">'+inputComp[i].title+'</p><input id="input_'+func+'_'+i+'" placeholder="'+inputComp[i].placeholder+'" value="'+inputComp[i].value+'"></input><p class="InputTag">'+inputComp[i].tag+'</p>'
			
		}
		InputItems.appendChild(input)
	}
	input_panel.appendChild(InputItems)
	var go=document.createElement("div")
		go.setAttribute("onclick",'go_'+func+'()')
		go.className="GoButton"
		go.innerHTML="<p>GO</p>"
	input_panel.appendChild(go)
	
	//定义结果展示区
	var output=document.createElement("div")
		output.className="OutPutPanel"
		output.innerHTML='<div class="downResult">'+downsvg_w+'<p>Download table</p></div><div class="OutPutArea"></div>'
		
		
	main.appendChild(input_panel)
	main.appendChild(output)
}


function getDataModify(){
	var xmlhttp=new XMLHttpRequest();
	//var Debug=document.getElementById("NATIVE,HELP");
	xmlhttp.onreadystatechange=function(){
		//document.getElementById("plotarea").innerHTML =genename+"got:"+xmlhttp.responseText;
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
			var modi=xmlhttp.responseText;
			var modi_p=document.getElementById("modi")
			modi_p.innerHTML=modi
		}else{
		}
	}
	xmlhttp.onerror=function(e){

	}

	xmlhttp.open("POST","php/getModifyData.php",true);
	xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xmlhttp.send();
}


function initHelp(){
	main=document.getElementById("main")
	main.innerHTML=""
	
	var HelpContent=document.createElement("div")
	HelpContent.className="HELPBlock";
	HelpContent.innerHTML='<p class="HELPTitle">HELP document of Pancan-puQTL</p>'+
	'<p><br><a href="#help1">1. What is Cancer-puQTL?</a>'+
	'<br><a href="#help2">2. Data sources for database construction.</a>'+
	'<br><a href="#help3">3. The pipeline of database construction.</a>'+
	'<br><a href="#help4">4. Data summary.</a>'+
	'<br><a href="#help5">5. Six modules in Cancer-puQTL.</a></p>'+

	'<p id="help1" class="HELPSubTitle">1.	What is Cancer-puQTL?</p>'+
	'<p style="text-indent: 2em;">Cancer-puQTL is a database to provide a comprehensive resource of promoter usage quantitative trait loci (puQTLs) across 33 human cancer types.</p>'+
	'<p style="text-indent: 2em;">In Cancer-puQTL, users can:'+
	'<p style="text-indent: 2em;">1)  Browse or search cis-puQTLs and trans-puQTLs across different cancer types;'+
	'<p style="text-indent: 2em;">2)  Browse or search puQTLs associated with patient overall survival across different cancer types;'+
	'<p style="text-indent: 2em;">3)  Browse or search puQTLs in GWAS linkage disequilibrium (LD) regions;'+
	'<p style="text-indent: 2em;">4)  Browse or search association between promoter activity and drug response across human cancers;'+
	'<p style="text-indent: 2em;">5)  Browse or search association between promoter activity and different type of immune cell infiltration across human cancers;</p>'+
	'<p id="help2" class="HELPSubTitle">2.	Data sources for database construction.</p>'+
	'<p style="text-indent: 2em;">The prognostic profiles, genotype data (Level 2) and junction files (Level 2) quantified by STAR of 10407 tumor samples were downloaded from the The Cancer Genome Atlas (TCGA) data portal (https://portal.gdc.cancer.gov/). Promoter activity is defined as the total amount of transcription initiated at each promoter, which was estimated for each annotated promoter by proActiv with aligned reads as input (https://github.com/GoekeLab/proActiv). For the detailed reads alignment and normalization methods, please refer to the article by Deniz Demircioğlu et al [1]. The data of immune cell infiltration was calculated by seven different algorithms, including TIMER, MCP-counter, and ImmuCellAI (http://timer.cistrome.org/) [2, 3] . The imputed GDSC (https://www.cancerrxgene.org/) drug response from cancer cell lines to TCGA patient samples was estimated by using R package oncoPredict [4] .</p>'+
	'<p id="help3" class="HELPSubTitle">3.	The pipeline of database construction.</p>'+
	'<img src="pic/flowchart.png" style="width:70%;margin:auto">'+
	'<p id="help4" class="HELPSubTitle">4.	Data summary.</p>'+
	'<img src="pic/helpstats.png" style="width:90%;margin:auto;"></img>'+
	'<p id="help5" class="HELPSubTitle">5.	Six modules in Cancer-puQTL.</p>'+
'<p style="text-indent: 2em;">We provide six modules (Cis-puQTLs, Trans-puQTLs , GWAS-puQTLs, Survival-puQTLs, Drug-puQTLs and Immune-puQTLs) for browse or search in Cancer- puQTL.'+
'<p style="text-indent: 2em;">1) Cis-puQTLs module collected genetic variants which are significantly (FDR < 0.05) associated with promoter activity within 1 MB across human cancers, which were determined by linear regression using Matrix eQTL.'+
'<p style="text-indent: 2em;">2) Trans-puQTLs module collected genetic variants which are significantly (FDR < 0.05) associated long distanced (> 1 MB) or inter-chromosomal promoter activity across human cancers, which were determined by linear regression using Matrix eQTL.'+
'<p style="text-indent: 2em;">3) Survival-puQTLs module collected cis- and trans-puQTLs which are significantly associated with patient overall survival across human cancers. For each puQTL, samples were classified into three groups: homozygous genotype AA, heterozygous genotype Aa and homozygous genotype aa (A and a represent two alleles of one SNP). The log-rank test was used to examine the differences in survival time, and Kaplan–Meier (KM) curves were plotted to represent the survival time for each group. puQTLs with FDR < 0.05 were defined as survival associated puQTLs.'+
'<p style="text-indent: 2em;">4) GWAS-puQTLs module identification: tagSNPs were derived from GWAS catalog website (http://www.ebi.ac.uk/gwas/) and the linkage disequilibrium were calculated with 1000 Genomes Phase 1 European population. Cis- or trans-puQTLs that in LD relation (r2 > 0.5) with tagSNPs were defined as GWAS- puQTLs.'+
'<p style="text-indent: 2em;">5) Drug-puQTLs module collected promoter activity which are significantly associated imputed drug response (FDR < 0.05) estimated by Spearman’s correlation analysis across human cancers.'+
'<p style="text-indent: 2em;">6) Immune-puQTLs module collected promoter activity which significantly associated immune cell abundance (FDR < 0.05) estimated by Spearman’s correlation analysis across human cancers. '+

'<p class="HELPSubTitle">References:</p>'+
"<p>[1].	Demircioglu D, Cukuroglu E, Kindermans M, et al. A Pan-cancer Transcriptome Analysis Reveals Pervasive Regulation through Alternative Promoters. Cell. 2019 178: 1465-1477 e1417."+
"<br>[2].	Li T, Fu J, Zeng Z, et al. TIMER2.0 for analysis of tumor-infiltrating immune cells. Nucleic Acids Res. 2020 48: W509-W514."+
"<br>[3].	Miao YR, Zhang Q, Lei Q, et al. ImmuCellAI: A Unique Method for Comprehensive T-Cell Subsets Abundance Prediction and its Application in Cancer Immunotherapy. Adv Sci (Weinh). 2020 7: 1902880."+
"<br>[4].	Maeser D, Gruener RF, Huang RS. oncoPredict: an R package for predicting in vivo or cancer patient drug response and biomarkers from cell line screening data. Brief Bioinform. 2021 22.</p>"


	
	
	
	main.appendChild(HelpContent)

}


init_loadJSONs()
//getDataModify()
downsvg='<svg width="24" height="24" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M40.5178 34.3161C43.8044 32.005 45.2136 27.8302 44.0001 24C42.7866 20.1698 39.0705 18.0714 35.0527 18.0745H32.7317C31.2144 12.1613 26.2082 7.79572 20.1435 7.0972C14.0787 6.39868 8.21121 9.5118 5.38931 14.9253C2.56741 20.3388 3.37545 26.9317 7.42115 31.5035" stroke="#333" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/><path d="M24.0084 41L24 23" stroke="#333" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/><path d="M30.3638 34.6362L23.9998 41.0002L17.6358 34.6362" stroke="#333" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/></svg>'
downsvg_w='<svg width="24" height="24" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M40.5178 34.3161C43.8044 32.005 45.2136 27.8302 44.0001 24C42.7866 20.1698 39.0705 18.0714 35.0527 18.0745H32.7317C31.2144 12.1613 26.2082 7.79572 20.1435 7.0972C14.0787 6.39868 8.21121 9.5118 5.38931 14.9253C2.56741 20.3388 3.37545 26.9317 7.42115 31.5035" stroke="#fff" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/><path d="M24.0084 41L24 23" stroke="#fff" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/><path d="M30.3638 34.6362L23.9998 41.0002L17.6358 34.6362" stroke="#fff" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/></svg>'