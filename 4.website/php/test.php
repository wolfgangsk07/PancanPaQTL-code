<?php
try
{
	echo "test";

	
	$shell="tasklist /V|findstr tasklist";
	$shell="Rscript D:/闲鱼搜索/scripts/forceChat.r xy-M4(13163275790)binwolverine 677407855221 2983743436";
	$pid=exec($shell,$output);
	for($i=0;$i<count($output);++$i){
		echo current($output);
		next($output);
	}
	echo $shell;
}catch(Exception $e){
    echo 'Message: ' .$e;
}

?>