<?php
try
{


	//set_time_limit(10);
	$userParams=base64_decode($_POST['userParams']);
	$userParams_obj=json_decode($userParams);


	$UUID=$userParams_obj -> UUID;
	$path="../jsonCache/res_".$UUID.".json";
	$userParams_path="../jsonCache/userParams_".$UUID.".json";
	$up = fopen($userParams_path,"w");
		fwrite($up,$userParams);
		fclose($up);
	/*
	$tasklist=array();
	if(file_exists("c:/windows")){
		exec("tasklist",$tasklist);
	}else{
		exec("ps -aux",$tasklist);
	}
	$runningcount=0;
	for($t=0;$t<count($tasklist);$t++){
		if(strpos($tasklist[$t],"Rscript")!==false){
			$runningcount++;
		}
	}
	
	if($runningcount>20){
		$res=array();
		$res['UUID']=$UUID;
		$res['res']['error']=$runningcount." task(s) are running currently, please try again later.";
		exit(json_encode($res));
	};
	*/
	
	$shell="Rscript ../r/centralHub.r ".$UUID;
	//echo $shell;
	$pid=exec($shell,$output);
	for($i=0;$i<count($output);++$i){
		//echo current($output);
		next($output);
	}

	for($i=0;$i<3;$i++){
		if(file_exists($path)){
			sleep(0.1);
			$fp = fopen($path,"r");
				$str = fread($fp,filesize($path));//指定读取大小，这里把整个文件内容读取出来
				echo $str;
				fclose($fp);
				break;
		}
		sleep(1);
	}
}catch(Exception $e){
    echo 'Message: ' .$e;
}

?>