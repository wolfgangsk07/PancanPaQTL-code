
//表格相关
function draw_init_table(table_json,func,UUID){
	console.log(func)

	//var OutPutArea=document.getElementsByClassName("OutPutArea")[0]
	var OutPutArea=document.getElementById(UUID)
	var tableArea=document.createElement("div")
	tableArea.className="table_frame"
	var tmp='<p class="tableNote">Note: '+table_json.resLines+' results in current criterion.</p><div class="pageIndexes"></div><div class="table_show"></div><div class="pageIndexes"></div>'
	table_json.resLines
	
	tableArea.innerHTML=tmp
	OutPutArea.appendChild(tableArea)
	draw_table_show(table_json,UUID,1)
	
}
/*
function draw_onepage_table(table_json){
	draw_table_show(table_json,table_json.preUUID,table_json.pagenumber)

}

*/
function draw_table_show(table_json,UUID,pagenumber){
	var picicon='<svg height="100%" t="1666533807264" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="27163" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M900.7 908.5H271c-105.9 0-191.7-85.8-191.7-191.7V168.2c0-26.6 21.5-48.1 48.1-48.1s48.1 21.5 48.1 48.1v548.6c0 52.8 42.8 95.6 95.6 95.6h629.7c26.6 0 48.1 21.5 48.1 48.1-0.1 26.5-21.7 48-48.2 48z" fill="#888" p-id="27164"></path><path d="M386.9 369.8H285.5c-20.9 0-37.9 17-37.9 37.9V683c0 20.9 17 37.9 37.9 37.9h101.4c20.9 0 37.9-17 37.9-37.9V407.8c0-21-16.9-38-37.9-38zM631 117.9h-77.8c-27.5 0-49.7 22.3-49.7 49.7v503.6c0 27.4 22.3 49.7 49.7 49.7H631c27.4 0 49.7-22.3 49.7-49.7V167.6c0-27.5-22.2-49.7-49.7-49.7zM894.1 278.6H802c-23.5 0-42.6 19.1-42.6 42.6v357.1c0 23.5 19.1 42.6 42.6 42.6h92.1c23.5 0 42.6-19.1 42.6-42.6V321.2c-0.1-23.6-19.1-42.6-42.6-42.6z" fill="#f88" p-id="27165"></path></svg>'
	var cancertype=table_json.cancer
	var showTablePic=table_json.showTablePic
	var tablePicNeeds=table_json.tablePicNeeds
	var tablePicFunc=table_json.tablePicFunc
	var rowsPerPage=100
	var tableCol=table_json.colnames.length
	if(table_json.data!=undefined){
		var tableRow=table_json.data.length
	}else{
		var tableRow=0
	}
	var table_h5_str='<table><tr><th style="font-style:italic">NO.</th>'
	for(var i=0;i<tableCol;i++){
		table_h5_str=table_h5_str+"<th>"+table_json.colnames[i]+"</th>"
	}
	if(showTablePic){
		var tablePicNeeds_index=[]
		var spanStr=""
		for(var i=0;i<tablePicNeeds.length;i++){

			tablePicNeeds_index.push(table_json.colnames.indexOf(tablePicNeeds[i]))

		}
		table_h5_str=table_h5_str+"<th>Figure</th></tr>"
		var picSpan=[]
		var lasttag=""
		for(var i=0;i<tableRow;i++){
			currtag=""
			for(var j=0;j<tablePicNeeds_index.length;j++){
				currtag+=table_json.data[i][tablePicNeeds_index[j]]
			}
			if(lasttag==currtag){
				picSpan[picSpan.length-1]+=1
			}else{
				picSpan[i]=1
			}
			lasttag=currtag
		}
	}

	for(var i=0;i<tableRow;i++){

		table_h5_str=table_h5_str+'<tr><td style="font-style:italic;color:grey;">'+(rowsPerPage*(pagenumber-1)+(i+1))+"</td>"
		
		for(var j=0;j<tableCol;j++){
			var dat=table_json.data[i][j].replaceAll(";",";<br><br>")
			

			table_h5_str=table_h5_str+"<td>"+dat+"</td>"
			
		}
		if(showTablePic){
			
			picFuncParams=[]
			for(var j=0;j<tablePicNeeds_index.length;j++){
				picFuncParams.push(table_json.data[i][tablePicNeeds_index[j]])
			}
			if(picSpan[i]==undefined){
				spanStr=""
			}else{
				spanStr='<td rowspan="'+picSpan[i]+'"><div class="tablePic" onclick=\''+tablePicFunc+'("'+picFuncParams.join('","')+'",this)\'>'+picicon+'</div></td>'
			}
			table_h5_str=table_h5_str+spanStr+'</tr>'
		}
	}
	table_h5_str=table_h5_str+"</table>"
	var OutPutArea=document.getElementById(UUID)
	var table_show=OutPutArea.getElementsByClassName("table_show")[0]
	table_show.innerHTML=table_h5_str
	//更改indexs
	
	var totalPages=Math.ceil(table_json.totalrows/rowsPerPage)
	toShowPages=[]
	toShowPages=unionArray(toShowPages,createArray(pagenumber-4,pagenumber+4))
	toShowPages=unionArray(toShowPages,[1,2,3,4])
	toShowPages=unionArray(toShowPages,[totalPages-3,totalPages-2,totalPages-1,totalPages])
	if(pagenumber>1){
		var tmp='<div class="pageIndexButton pageIndex"   onclick=toPage_table("'+cancertype+'","'+UUID+'",'+(pagenumber-1)+','+rowsPerPage+')><p><</p></div>'
	}else{
		var tmp='<div style="display:none;"><</div>'
	}
	var adddot=true;
	for(var i=0;i<totalPages;i++){
		if(toShowPages.indexOf(i+1)==-1){
			if(adddot){
				tmp=tmp+'<div style="color:grey;margin:0 4px 0 4px;">...</div>'
			}
			adddot=false;
			continue
		}else{
			adddot=true
		}
		if(i==pagenumber-1){
			var pick=" pickedIndex"
		}else{
			var pick=""
		}
		tmp=tmp+'<div class="pageIndex'+pick+'" onclick=toPage_table("'+cancertype+'","'+UUID+'",'+(i+1)+','+rowsPerPage+')><p>'+(i+1)+'</p></div>'
	}
	if(pagenumber<totalPages){
		tmp=tmp+'<div class="pageIndexButton pageIndex" onclick=toPage_table("'+cancertype+'","'+UUID+'",'+(pagenumber+1)+','+rowsPerPage+')><p>></p></div>'
	}else{
		tmp=tmp+'<div style="display:none;"><p>></p></div>'
	}
	
	table_show.parentElement.getElementsByClassName("pageIndexes")[0].innerHTML=tmp
	table_show.parentElement.getElementsByClassName("pageIndexes")[1].innerHTML=tmp
}



//SVG相关
function draw_fig(drawing_json,svgContainer){
	var SVGWidth=drawing_json.default.PlotScale[0]
	var SVGHeight=drawing_json.default.PlotScale[1]
	var dpi=drawing_json.default.dpi
	var vdpi=document.getElementById("meter").offsetWidth*1.5
	var svgContainer_width=SVGWidth*vdpi/dpi
	if(svgContainer_width>800){
		svgContainer_width=800
	}
	svgContainer.style.width=svgContainer_width+"px"
	svgContainer.style.height=svgContainer_width*SVGHeight/SVGWidth+"px"
	floatPanel.style.left=Number(floatPanel.getAttribute("lefttmp"))-floatPanel.clientWidth+"px"
	floatPanel.style.top=Math.max(0,Number(floatPanel.getAttribute("toptmp"))-floatPanel.clientHeight)+"px"
	if (SVG.supported) {
	  var drawing=SVG(svgContainer);
	  drawing.viewbox(0,0,SVGWidth,SVGHeight)

	} else {
	  alert('svg.js not supported');
	  return;
	}
	var g={}
	var keys=Object.keys(drawing_json)
	for(var i=0;i<keys.length;i++){
		if(keys[i]=="default"){
			continue
		}else if(drawing_json[keys[i]].elementtype=="draw_lines"){
			var ele=draw_lines(drawing,drawing_json,keys[i],SVGHeight)
		}else if(drawing_json[keys[i]].elementtype=="draw_text"){
			var ele=draw_text(drawing,drawing_json,keys[i],SVGHeight)
		}else if(drawing_json[keys[i]].elementtype=="draw_circle"){
			var ele=draw_circle(drawing,drawing_json,keys[i],SVGHeight)
		}else if(drawing_json[keys[i]].elementtype=="draw_rect"){
			var ele=draw_rect(drawing,drawing_json,keys[i],SVGHeight)
		}else if(drawing_json[keys[i]].elementtype=="draw_polygon"){
			var ele=draw_polygon(drawing,drawing_json,keys[i],SVGHeight)
		}
		

		if(drawing_json[keys[i]].groupid!=undefined){
			if(g[drawing_json[keys[i]].groupid]==undefined){
				g[drawing_json[keys[i]].groupid]=drawing.group().attr({
				class:drawing_json[keys[i]].groupid.split("_")[0]
			})
			}
			g[drawing_json[keys[i]].groupid].add(ele)
			//drawing.add(g)
		}

	}
	addPopup()
}

function draw_lines(drawing,drawing_json,key,SVGHeight){
	var plotElement=drawing_json[key]
	var dpi=drawing_json.default.dpi
	var pos=[]
	for(var a=0;a<plotElement.x.length;a++){
		pos.push(plotElement.x[a])
		pos.push(SVGHeight-plotElement.y[a])
	}
	if(plotElement.lty!=undefined){
		if(plotElement.lty=="dashed"){
			var lty='10'
		}else{
			var lty=''
		}
	}else{
		var lty=''
	}
	

	var res=drawing.group()
	var ln=drawing.polyline(pos).attr({
		stroke:plotElement.col,
		'stroke-width':plotElement.lwd*dpi/100,
		fill:"none",
		'stroke-dasharray':lty
	})
	res.add(ln)
	if(plotElement.popupTexts!=undefined){
		ln.attr({
			class:"popupSVG_target"
		})
		res.add(drawing.plain(plotElement.popupTexts).attr({
				x:plotElement.x[0]+10,
				y:SVGHeight-plotElement.y[0]-10,
				"font-size":36,
				class:"popupSVG_text",
				fill:"#d52527"
			})
		)
	}
		
		
	return(res)
}


function draw_rect(drawing,drawing_json,key,SVGHeight){
	var plotElement=drawing_json[key]
	var dpi=drawing_json.default.dpi

	if(plotElement.lty!=undefined){
		if(plotElement.lty=="dashed"){
			var lty='10'
		}else{
			var lty=''
		}
	}else{
		var lty=''
	}

	if(plotElement.border==undefined){
		plotElement.border="black"
	}
	if(plotElement.col==undefined){
		plotElement.col="transparent"
	}
	var res=drawing.rect(plotElement.x2-plotElement.x1,plotElement.y2-plotElement.y1).attr({
		x:plotElement.x1,
		y:SVGHeight-plotElement.y2,
		fill:plotElement.col,
		'stroke-width':plotElement.lwd*dpi/100,
		stroke:plotElement.border,
		'stroke-dasharray':lty
	})
	return(res)
}

function draw_polygon(drawing,drawing_json,key,SVGHeight){
	var plotElement=drawing_json[key]
	var dpi=drawing_json.default.dpi

	if(plotElement.lty!=undefined){
		if(plotElement.lty=="dashed"){
			var lty='10'
		}else{
			var lty=''
		}
	}else{
		var lty=''
	}

	if(plotElement.border==undefined){
		plotElement.border="black"
	}
	if(plotElement.col==undefined){
		plotElement.col="transparent"
	}
	var pos=[]
	for(var a=0;a<plotElement.x.length;a++){
		pos.push(plotElement.x[a]+","+(SVGHeight-plotElement.y[a]))
	}
	var res=drawing.polygon(pos.join(" ")).attr({
		fill:plotElement.col,
		'stroke-width':plotElement.lwd*dpi/100,
		stroke:plotElement.border,
		'stroke-dasharray':lty
	})
	return(res)
}

function draw_text(drawing,drawing_json,key,SVGHeight){
	var plotElement=drawing_json[key]
	var dpi=drawing_json.default.dpi
	if(plotElement.adj[0]==0){
		var xadj="start"
	}else if(plotElement.adj[0]==1){
		var xadj="end"
	}else{
		var xadj="middle"
	}
	
	if(plotElement.adj[1]==1){
		var yadj="text-before-edge"
	}else if(plotElement.adj[1]==0){
		var yadj="text-after-edge"
	}else{
		var yadj="central"
	}
	if(plotElement.bold){
		var font="bold"
	}else{
		var font="normal"
	}
	var res=drawing.plain(plotElement.text).attr({
		x:plotElement.x,
		y:SVGHeight-plotElement.y,
		"font-size":plotElement.cex*dpi/6+"px",
		"dominant-baseline":  yadj,
		"text-anchor":xadj,
		fill:plotElement.col,
		"font-weight":font,
		transform:"rotate("+(-plotElement.srt)+" "+plotElement.x+","+(SVGHeight-plotElement.y)+")"
	})
	return(res)
}


function draw_circle(drawing,drawing_json,key,SVGHeight){
	var plotElement=drawing_json[key]
	var dpi=drawing_json.default.dpi
	if(typeof(plotElement.x)=="object"){
		var x_len=plotElement.x.length
	}else{
		var x_len=1
	}
	if(typeof(plotElement.y)=="object"){
		var y_len=plotElement.y.length
	}else{
		var y_len=1
	}
	if(typeof(plotElement.r)=="object"){
		var r_len=plotElement.r.length
	}else{
		var r_len=1
	}
	if(typeof(plotElement.col)=="object"){
		var col_len=plotElement.col.length
	}else{
		var col_len=1
	}
	
	if(typeof(plotElement.popupTexts)=="object"){
		var popupTexts_len=plotElement.popupTexts.length
	}else{
		var popupTexts_len=1
	}
	
	nums=Math.max(x_len,y_len,r_len)
	console.log(nums)
	var res=drawing.group()
	for(var i=0;i<nums;i++){
		if(x_len==1){
			var x=plotElement.x
		}else{
			var x=plotElement.x[i]
		}
		if(y_len==1){
			var y=plotElement.y
		}else{
			var y=plotElement.y[i]
		}
		if(r_len==1){
			var r=plotElement.r
		}else{
			var r=plotElement.r[i]
		}
		if(col_len==1){
			var col=plotElement.col
		}else{
			var col=plotElement.col[i]
		}
		if(popupTexts_len==1){
			var popupText=plotElement.popupTexts
		}else{
			var popupText=plotElement.popupTexts[i]
		}
		
		var cir=drawing.circle(r*2).attr({
			cx:x,
			cy:SVGHeight-y,
			fill:col,
			"stroke-width":plotElement.lwd*dpi/100,
			stroke:plotElement.border
		})
		
		res.add(cir)
		if(popupText!=undefined){
			cir.attr({
				class:"popupSVG_target"
			})
			res.add(drawing.plain(popupText).attr({
					x:x+10,
					y:SVGHeight-y-r-10,
					"font-size":36,
					class:"popupSVG_text",
					fill:"#d52527"
				})
			)
			
		
		
		}
		
	}
	return(res)
}



