<?php
	$time = microtime(true);
	$time_dt = date("Y-m-d H:i:s", round($time));

	$log_str = sprintf("%.3f\t%s\t%s", $time, $time_dt, $_SERVER['REMOTE_ADDR']);

	if (isset($_POST["log"]))
	{
		$log = $_POST["log"];
		$log_str = $log_str . sprintf("\t%s\n", $log); 
		echo ("POST_OK\n");
	}

	$file_name = '/var/www/html/log.txt';
	
	$myFile = '/path/to/myFile.txt';
	
	if (!file_exists($file_name)) {
		print 'File not found';
	}
	else if(!$myfile = fopen($file_name, 'a')) {
		print 'Can\'t open file';
	}
	#$myfile = fopen($file_name, 'a') or die('Cannot open file: '.$file_name); 
	fwrite($myfile, $log_str);
	fclose($myfile);
	print $log_str;	
?>

