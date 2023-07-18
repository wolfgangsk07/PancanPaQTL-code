<?php
	$filename = "../help/index.json";
	
	if(file_exists($filename)){
		//echo "start";
		$fp = fopen($filename,"r");
		$str = fread($fp,filesize($filename));//指定读取大小，这里把整个文件内容读取出来
		echo $str;
		fclose($fp);
	}

?>