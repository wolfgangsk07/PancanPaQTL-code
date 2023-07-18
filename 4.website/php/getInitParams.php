<?php

	$filename = "../initParams.json";
	//echo "__FILE__:  ========>  ".__FILE__;
	if(file_exists($filename)){
		$fp = fopen($filename,"r");
		$str = fread($fp,filesize($filename));//指定读取大小，这里把整个文件内容读取出来
		echo $str;
		fclose($fp);
	}

?>