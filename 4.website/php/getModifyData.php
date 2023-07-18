<?php
	$output=[];
	$files=['../index.html'];
	$dirs=['../js/','../php/','../r/','../css/'];
	foreach($dirs as $d){
		
		$dirfiles=scandir($d);
		foreach($dirfiles as $onefile){
			if($onefile!='.'&&$onefile!='..'){
				$files[]=$d.$onefile;
			}
		}
		
	}
	
	//$files=["../js/functions.js","../js/plot.js","../r/L_functions.R","../r/W_functions.R","../css/index.css","../css/home.css","../js/home.js","../help/index.json"];
	
	$lastUpdate=0;
	foreach($files as $v){
		$a=filemtime($v);
		if($a>$lastUpdate){
			$lastFile=$v;
			$lastUpdate=$a;
		}

	}
	echo($lastFile.": ".date("Y-m-d H:i:s",$lastUpdate));
?>