
//用户流程控制
function go_cis_eqtl(){
		var UUID=getUUID()
		var cancer_type=document.getElementById("input_cis_eqtl_0").value
		//var cisortrans=document.getElementById("input_cis_trans_eqtl_1").value
		var promoterid=document.getElementById("input_cis_eqtl_1").value
		var SNP_id=document.getElementById("input_cis_eqtl_2").value
		var Pvalue=document.getElementById("input_cis_eqtl_3").value
		var FDR=document.getElementById("input_cis_eqtl_4").value
		var genes=document.getElementById("input_cis_eqtl_5").value
		var OutPutArea=document.getElementsByClassName("OutPutArea")[0]
		OutPutArea.setAttribute("uuid",UUID)
		OutPutArea.setAttribute("id",UUID)
		OutPutArea.innerHTML="<div>Requesting data, please wait! Larger matrix may take more time!</div>"
		userParams=new Object();
		userParams["func"]="cis_trans_eqtl"
		userParams["cancer_type"]=cancer_type
		userParams["cisortrans"]="cis"
		userParams["promoterid"]=promoterid
		userParams["SNP_id"]=SNP_id
		userParams["Pvalue"]=Pvalue
		userParams["FDR"]=FDR
		userParams["genes"]=genes
		userParams["UUID"]=UUID
		tableCache=new Object()
		doRequest(userParams,UUID)
		
}


function go_trans_eqtl(){
		var UUID=getUUID()
		var cancer_type=document.getElementById("input_trans_eqtl_0").value
		//var cisortrans=document.getElementById("input_cis_trans_eqtl_1").value
		var promoterid=document.getElementById("input_trans_eqtl_1").value
		var SNP_id=document.getElementById("input_trans_eqtl_2").value
		var Pvalue=document.getElementById("input_trans_eqtl_3").value
		var FDR=document.getElementById("input_trans_eqtl_4").value
		var genes=document.getElementById("input_trans_eqtl_5").value
		var OutPutArea=document.getElementsByClassName("OutPutArea")[0]
		OutPutArea.setAttribute("uuid",UUID)
		OutPutArea.setAttribute("id",UUID)
		OutPutArea.innerHTML="<div>Requesting data, please wait! Larger matrix may take more time!</div>"
		userParams=new Object();
		userParams["func"]="cis_trans_eqtl"
		userParams["cancer_type"]=cancer_type
		userParams["cisortrans"]="trans"
		userParams["promoterid"]=promoterid
		userParams["SNP_id"]=SNP_id
		userParams["Pvalue"]=Pvalue
		userParams["FDR"]=FDR
		userParams["genes"]=genes
		userParams["UUID"]=UUID
		tableCache=new Object()
		doRequest(userParams,UUID)
		
}

function toPage_table(cancertype,preUUID,pagenumber,rowsPerPage){
	var UUID=getUUID()
	userParams=new Object();
	userParams["func"]="toPage_table"
	userParams["preUUID"]=preUUID
	userParams["cancertype"]=cancertype
	userParams["pagenumber"]=pagenumber
	userParams["rowsPerPage"]=rowsPerPage
	userParams["UUID"]=UUID
	doRequest(userParams,UUID)
}
function go_snpsurvival(){
		var UUID=getUUID()
		var cancer_type=document.getElementById("input_snpsurvival_0").value
		var cisortrans=document.getElementById("input_snpsurvival_1").value
		var SNP_id=document.getElementById("input_snpsurvival_2").value
		var Pvalue=document.getElementById("input_snpsurvival_3").value
		var FDR=document.getElementById("input_snpsurvival_4").value
		var OutPutArea=document.getElementsByClassName("OutPutArea")[0]
		OutPutArea.setAttribute("uuid",UUID)
		OutPutArea.setAttribute("id",UUID)
		OutPutArea.innerHTML="<div>Requesting data, please wait! Larger matrix may take more time!</div>"
		userParams=new Object();
		userParams["func"]="snpsurvival"
		userParams["cancer_type"]=cancer_type
		userParams["cisortrans"]=cisortrans
		userParams["SNP_id"]=SNP_id
		userParams["Pvalue"]=Pvalue
		userParams["FDR"]=FDR
		userParams["UUID"]=UUID
		tableCache=new Object()
		doRequest(userParams,UUID)
		
}


function go_gwaseqtl(){
		var UUID=getUUID()
		var cancer_type=document.getElementById("input_gwaseqtl_0").value
		var cisortrans=document.getElementById("input_gwaseqtl_1").value
		var tagSNP=document.getElementById("input_gwaseqtl_2").value
		var SNP_id=document.getElementById("input_gwaseqtl_3").value
		var traits=document.getElementById("input_gwaseqtl_4").value
		var genes=document.getElementById("input_gwaseqtl_6").value
		
		var LD=document.getElementById("input_gwaseqtl_5").value
		var promoterid=document.getElementById("input_gwaseqtl_7").value
		var OutPutArea=document.getElementsByClassName("OutPutArea")[0]
		OutPutArea.setAttribute("uuid",UUID)
		OutPutArea.setAttribute("id",UUID)
		OutPutArea.innerHTML="<div>Requesting data, please wait! Larger matrix may take more time!</div>"
		userParams=new Object();
		userParams["func"]="gwas_eqtl"
		userParams["cancer_type"]=cancer_type
		userParams["cisortrans"]=cisortrans
		userParams["tagSNP"]=tagSNP
		userParams["SNP_id"]=SNP_id
		userParams["traits"]=traits
		userParams["genes"]=genes
		userParams["LD"]=LD
		userParams["promoterid"]=promoterid
		userParams["UUID"]=UUID
		doRequest(userParams,UUID)
		
}

function go_drugs(){
		var UUID=getUUID()
		var cancer_type=document.getElementById("input_drugs_0").value
		var cisortrans=document.getElementById("input_drugs_1").value
		var SNP_id=document.getElementById("input_drugs_2").value
		var promoterid=document.getElementById("input_drugs_3").value
		var drugnames=document.getElementById("input_drugs_4").value
		var genes=document.getElementById("input_drugs_5").value
		var pathways=document.getElementById("input_drugs_6").value
		var OutPutArea=document.getElementsByClassName("OutPutArea")[0]
		OutPutArea.setAttribute("uuid",UUID)
		OutPutArea.setAttribute("id",UUID)
		OutPutArea.innerHTML="<div>Requesting data, please wait! Larger matrix may take more time!</div>"
		userParams=new Object();
		userParams["func"]="drugs"
		userParams["cancer_type"]=cancer_type
		userParams["cisortrans"]=cisortrans
		userParams["promoterid"]=promoterid
		userParams["SNP_id"]=SNP_id
		userParams["drugnames"]=drugnames
		userParams["genes"]=genes
		userParams["pathways"]=pathways
		userParams["UUID"]=UUID
		doRequest(userParams,UUID)
		
}


function go_immune(){
		var UUID=getUUID()
		var cancer_type=document.getElementById("input_immune_0").value
		var cisortrans=document.getElementById("input_immune_1").value
		var SNP_id=document.getElementById("input_immune_2").value
		var promoterid=document.getElementById("input_immune_3").value
		var cellname=document.getElementById("input_immune_4").value
		var source=document.getElementById("input_immune_5").value
		var genes=document.getElementById("input_immune_6").value
		var OutPutArea=document.getElementsByClassName("OutPutArea")[0]
		OutPutArea.setAttribute("uuid",UUID)
		OutPutArea.setAttribute("id",UUID)
		OutPutArea.innerHTML="<div>Requesting data, please wait! Larger matrix may take more time!</div>"
		userParams=new Object();
		userParams["func"]="immune"
		userParams["cancer_type"]=cancer_type
		userParams["cisortrans"]=cisortrans
		userParams["promoterid"]=promoterid
		userParams["cellname"]=cellname
		userParams["source"]=source
		userParams["genes"]=genes
		userParams["SNP_id"]=SNP_id
		userParams["UUID"]=UUID
		doRequest(userParams,UUID)
		
}





function go_cis_trans_fig(cancer_type,promoterid,snp,fdr,obj){
	var top=getOffsetTop(obj)
	var left=getOffsetLeft(obj)
	var UUID=getUUID()
	//var cancer_type=document.getElementById("input_"+func+"_0").value
	//var clinical=document.getElementById("input_"+func+"_1").value
	//var piRNA_id=document.getElementById("input_"+func+"_2").value
	var svgContainer_float=document.getElementById("svgContainer_float")
	svgContainer_float.setAttribute("uuid",UUID)
	var floatPanel=document.getElementById("floatPanel")
	floatPanel.setAttribute("lefttmp",left)
	floatPanel.setAttribute("toptmp",top)
	setWait(floatPanel)
	userParams=new Object();
	userParams["func"]="cis_trans_fig"
	userParams["cancer_type"]=cancer_type
	userParams["snp"]=snp
	userParams["promoterid"]=promoterid
	userParams["fdr"]=fdr
	userParams["UUID"]=UUID
	doRequest(userParams,UUID)
}

function go_snpsurvival_fig(cancer_type,snp,obj){
	var top=getOffsetTop(obj)
	var left=getOffsetLeft(obj)
	var UUID=getUUID()
	//var cancer_type=document.getElementById("input_"+func+"_0").value
	//var clinical=document.getElementById("input_"+func+"_1").value
	//var piRNA_id=document.getElementById("input_"+func+"_2").value
	var svgContainer_float=document.getElementById("svgContainer_float")
	svgContainer_float.setAttribute("uuid",UUID)
	var floatPanel=document.getElementById("floatPanel")
	floatPanel.setAttribute("lefttmp",left)
	floatPanel.setAttribute("toptmp",top)
	setWait(floatPanel)
	userParams=new Object();
	userParams["func"]="snpsurvival_fig"
	userParams["cancer_type"]=cancer_type
	userParams["snp"]=snp
	userParams["UUID"]=UUID
	doRequest(userParams,UUID)
}

function go_gsea_fig(cancer_type,pirna,obj){
	var top=getOffsetTop(obj)
	var left=getOffsetLeft(obj)
	var UUID=getUUID()
	//var cancer_type=document.getElementById("input_"+func+"_0").value
	//var clinical=document.getElementById("input_"+func+"_1").value
	//var piRNA_id=document.getElementById("input_"+func+"_2").value
	var svgContainer_float=document.getElementById("svgContainer_float")
	svgContainer_float.setAttribute("uuid",UUID)
	var floatPanel=document.getElementById("floatPanel")
	floatPanel.setAttribute("lefttmp",left)
	floatPanel.setAttribute("toptmp",top)
	setWait(floatPanel)
	userParams=new Object();
	userParams["func"]="gsea_fig"
	userParams["cancer_type"]=cancer_type
	userParams["pirna"]=pirna
	userParams["UUID"]=UUID
	doRequest(userParams,UUID)
}

function go_drug_fig(cancer_type,promoterid,drugname,rs,pval,obj){
	var top=getOffsetTop(obj)
	var left=getOffsetLeft(obj)
	var UUID=getUUID()
	//var cancer_type=document.getElementById("input_"+func+"_0").value
	//var clinical=document.getElementById("input_"+func+"_1").value
	//var piRNA_id=document.getElementById("input_"+func+"_2").value
	var svgContainer_float=document.getElementById("svgContainer_float")
	svgContainer_float.setAttribute("uuid",UUID)
	var floatPanel=document.getElementById("floatPanel")
	floatPanel.setAttribute("lefttmp",left)
	floatPanel.setAttribute("toptmp",top)
	setWait(floatPanel)
	userParams=new Object();
	userParams["func"]="drugs_fig"
	userParams["cancer_type"]=cancer_type
	userParams["promoterid"]=promoterid
	userParams["drugname"]=drugname
	userParams["RS"]=rs
	userParams["pval"]=pval
	userParams["UUID"]=UUID
	doRequest(userParams,UUID)
}

function go_immune_fig(cancer_type,promoterid,cellname,source,rs,pval,obj){
	var top=getOffsetTop(obj)
	var left=getOffsetLeft(obj)
	var UUID=getUUID()
	//var cancer_type=document.getElementById("input_"+func+"_0").value
	//var clinical=document.getElementById("input_"+func+"_1").value
	//var piRNA_id=document.getElementById("input_"+func+"_2").value
	var svgContainer_float=document.getElementById("svgContainer_float")
	svgContainer_float.setAttribute("uuid",UUID)
	var floatPanel=document.getElementById("floatPanel")
	floatPanel.setAttribute("lefttmp",left)
	floatPanel.setAttribute("toptmp",top)
	setWait(floatPanel)
	userParams=new Object();
	userParams["func"]="immune_fig"
	userParams["cancer_type"]=cancer_type
	userParams["promoterid"]=promoterid
	userParams["cellname"]=cellname
	userParams["source"]=source
	userParams["RS"]=rs
	userParams["pval"]=pval
	userParams["UUID"]=UUID
	doRequest(userParams,UUID)
}



function go_download_fig(fig_UUID){
	var UUID=getUUID()
	userParams=new Object();
	userParams["func"]="down_fig"
	userParams["fig_UUID"]=fig_UUID
	userParams["UUID"]=UUID
	doRequest(userParams,UUID)
}


function go_downResult(preUUID,type){
	userParams=new Object();
	userParams["func"]="go_downResult"
	var UUID=getUUID()
	userParams["UUID"]=UUID
	userParams["type"]=type
	userParams["preUUID"]=preUUID
	doRequest(userParams,UUID)
	
}


function download_url(name, url) {
	//console.log(url)
	function fake_click(obj) {
		var ev = document.createEvent("MouseEvents");
		ev.initMouseEvent(
			"click", true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null
		);
		obj.dispatchEvent(ev);
	}
  

    var save_link = document.createElementNS("http://www.w3.org/1999/xhtml", "a")
    save_link.href = url;
    save_link.download = name;
    fake_click(save_link);
	//调用方法
	//download("save.txt","内容");
}

function download_str(name, str) {
	//console.log(url)
	function fake_click(obj) {
		var ev = document.createEvent("MouseEvents");
		ev.initMouseEvent(
			"click", true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null
		);
		obj.dispatchEvent(ev);
	}
  

    var save_link = document.createElementNS("http://www.w3.org/1999/xhtml", "a")
	var blob = new Blob([str]);
    save_link.href = URL.createObjectURL(blob);
    save_link.download = name;
    fake_click(save_link);
	//调用方法
	//download("save.txt","内容");
}


function close_float(){
	var floatPanel=document.getElementById("floatPanel")
	floatPanel.style.opacity="0"
	floatPanel.style.pointerEvents="none"
}


function setWait(floatPanel){

	var svgContainer_float=document.getElementById("svgContainer_float")
	svgContainer_float.innerHTML='<svg class="load" viewBox="25 25 50 50"><circle class="loading" cx="50" cy="50" r="10" fill="none" /></svg>'
	svgContainer_float.style.height=window.innerHeight*0.4+"px"
	svgContainer_float.style.width=window.innerHeight*0.4+"px"
	floatPanel.style.left=Number(floatPanel.getAttribute("lefttmp"))-floatPanel.clientWidth+"px"
	floatPanel.style.top=Math.max(0,Number(floatPanel.getAttribute("toptmp"))-floatPanel.clientHeight)+"px"
	floatPanel.style.opacity="1"
	floatPanel.style.pointerEvents=""
}
//请求与解析
function doRequest(userParams,UUID){
	var xmlhttp=new XMLHttpRequest();
	//var Debug=document.getElementById("NATIVE,HELP");
	xmlhttp.onreadystatechange=function(){
		//document.getElementById("plotarea").innerHTML =genename+"got:"+xmlhttp.responseText;
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
			Params_str=xmlhttp.responseText;
			try {
				Params=JSON.parse(Params_str);
			} catch (error) {
				alert("Might be network error, Please retry!")
				return;
			}
			if(Params.error){
				alert(Params.error)
			}
			if(Params.res.error){
				alert(Params.res.error)
			}
			parseParams(Params,UUID)
		}else{
		}
	}
	xmlhttp.onerror=function(e){

	}

	userParams_uri="userParams="+btoa(JSON.stringify(userParams));
	xmlhttp.open("POST","php/sendToR.php",true);
	xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xmlhttp.send(userParams_uri);
}

function parseParams(Params,UUID){
	var OutPutArea=document.getElementsByClassName("OutPutArea")[0]
	var mainUUID=OutPutArea.getAttribute("uuid")
	var svgContainer_float=document.getElementById("svgContainer_float")
	var svgContainer_floatUUID=svgContainer_float.getAttribute("uuid")
	if(mainUUID==UUID){
		var downResult=document.getElementsByClassName("downResult")[0]
		OutPutArea.innerHTML=""
		var outputs=Params.res.outputs
		var keys=Object.keys(outputs)
		for(var i=0;i<keys.length;i++){
			if(outputs[keys[i]].type=="table"){
				draw_init_table(outputs[keys[i]],Params.func,UUID)
			}else if(outputs[keys[i]].type=="fig"){
				draw_fig(outputs[keys[i]]["drawing"],OutPutArea)
			}
			downResult.setAttribute("onclick",'go_downResult("'+UUID+'","'+outputs[keys[i]].type+'")')
			downResult.style.display="flex"
		}
		
		
	}else if(svgContainer_floatUUID==UUID){
		svgContainer_float.innerHTML=""
		var outputs=Params.res.outputs
		var downFig=document.getElementById("downFig")
		var keys=Object.keys(outputs)
		for(var i=0;i<keys.length;i++){
			if(outputs[keys[i]].type=="table"){
				draw_init_table(outputs[keys[i]],Params.func)
			}else if(outputs[keys[i]].type=="fig"){
				draw_fig(outputs[keys[i]]["drawing"],svgContainer_float)
			}else if(outputs[keys[i]].type=="download"){
				
			}
			downFig.setAttribute("onclick",'go_downResult("'+UUID+'","'+outputs[keys[i]].type+'")')
		}
		
		
		
		
	/*
	}else if(Params.func=="down_fig"){
		var outputs=Params.res.outputs
		var keys=Object.keys(outputs)
		for(var i=0;i<keys.length;i++){
			if(outputs[keys[i]].type=="download"){
				var filename=outputs[keys[i]].filename
				download_url(filename,"./jsonCache/"+filename)
			}
			
		}
		
		
	*/
	}else if(Params.func=="toPage_table"){
		var outputs=Params.res.outputs
		var keys=Object.keys(outputs)
		for(var i=0;i<keys.length;i++){
			if(outputs[keys[i]].type=="toPage"){
				
				draw_table_show(Params.res.outputs[keys[i]],Params.res.outputs[keys[i]].preUUID,Params.res.outputs[keys[i]].pagenumber)
			}
			
		}
		
	}else if(Params.func=="go_downResult"){
		var outputs=Params.res.outputs
		download_url(outputs.filename,"./jsonCache/"+outputs.filename)
		
	}
	
}



//其他功能函数
function getUUID() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
    return v.toString(16);
  });
}

function getOffsetTop(el){
 return el.offsetParent
  ? el.offsetTop - el.scrollTop + getOffsetTop(el.offsetParent)
  : el.offsetTop - el.scrollTop - document.getElementsByTagName("html")[0].scrollTop
}

function getOffsetLeft(el){
 return el.offsetParent
  ? el.offsetLeft + getOffsetLeft(el.offsetParent)
  : el.offsetLeft
}

function createArray(start,end){
	var collectArr = [];
	for (var i = start; i <= end; i++) {
	  collectArr.push(i);
}
	return(collectArr)
}

function unionArray(a,b){
       let tempArray = [];
       for(let i = 0;i<arguments.length;i++){
        tempArray.push(...new Set(arguments[i]))
       }
       return [... new Set(tempArray)]
   }
   
function unique(arr) {

    if (!Array.isArray(arr)) {

        console.log('type error!')

        return;

    }

    arr = arr.sort()

    var arrry= [arr[0]];

    for (var i = 1; i < arr.length; i++) {

        if (arr[i] !== arr[i-1]) {

            arrry.push(arr[i]);

        }

    }

    return arrry;

}

function expandHelp(obj){
	var helpInfoTitle=obj.getElementsByClassName("helpInfoTitle")[0]
	var helpTitle_width=helpInfoTitle.getBoundingClientRect().width
	var helpTitle_height=helpInfoTitle.getBoundingClientRect().height
	var helpInfoContent=obj.getElementsByClassName("helpInfoContent")[0]
	var helpContent_width=helpInfoContent.getBoundingClientRect().width
	var helpContent_height=helpInfoContent.getBoundingClientRect().height
	obj.style.width=Math.max(helpTitle_width,helpContent_width)+10+"px";
	obj.style.height=helpTitle_height+helpContent_height+20+"px"
	obj.style.boxShadow="3px 3px 5px grey"
}

function shrinkHelp(obj){
	helpInfoTitle=obj.getElementsByClassName("helpInfoTitle")[0]
	var helpTitle_width=helpInfoTitle.getBoundingClientRect().width
	var helpTitle_height=helpInfoTitle.getBoundingClientRect().height
	var helpInfoContent=obj.getElementsByClassName("helpInfoContent")[0]
	var helpContent_width=helpInfoContent.getBoundingClientRect().width
	var helpContent_height=helpInfoContent.getBoundingClientRect().height
	obj.style.width="";
	obj.style.height=""
	obj.style.boxShadow=""
	
}