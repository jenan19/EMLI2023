<!DOCTYPE html>
<html>
<body style="background-color:#FFF599;text-align:center">

<h1>Plant watering system</h1>
<body>
	<p><strong> <span style="color:green" id='date-time'></span> </strong></p>
</body>


<script>
var dt = new Date();
document.getElementById('date-time').innerHTML=dt;
</script>
<head>
<style>
.myDiv {
  border: 5px outset blue;
  background-color: white;    
width: 400px;
  text-align: left;
margin:0 auto;
}
</style>
</head>

<h2>System information:</h2>

<div class="myDiv">
<h2>Pump alarm status  : 
<?php
	$output = exec("/home/pi/shell_scripts/water_alarm.sh");
	if ($output == "0") {
	  echo "&#128994";
	} elseif ($output == "1") {
	  echo "&#128308";
	} else {
	  echo "&#128994";
	}
?>
 </h2>

</div>
<div class="myDiv">
<h2>Water alarm status : 
<?php
	$output = exec("/home/pi/shell_scripts/pump/alarm.sh");
	if ($output == "0") {
	  echo "&#128994";
	} elseif ($output == "1") {
	  echo "&#128308";
	} else {
	  echo "&#128994";
	}
?>
 </h2>
</div>

<div class="myDiv">
<h2>Moisture level status : 
<?php
	$output = exec("/home/pi/shell_scripts/soil_alarm.sh");
	if ($output < "50") {
	  echo "&#128994";
	} elseif ($output > "50") {
	  echo "&#128993";
	} else {
	  echo "&#128994";
	}
?>
 </h2>
</div>


<head>
	<p>
	<a title="" href="Server_health/">
		<h3 style="clear: both;"><img style="vertical-align:middle;" src="system.png" alt="Main" width="45" />Server health</h3>
	</a>
	<br>
	</p>
</head>


<head>
	<p>
	<a title="" href="ambient_light/">
		<h3 style="clear: both;"><img style="vertical-align:middle;" src="light.png" alt="light" width="45" />Ambient light status</h3>
	</a>
	<br>
	</p>
</head>

<head>
	<p>
	<a title="" href="pump_activations/">
		<h3 style="clear: both;"><img style="vertical-align:middle;" src="waterpump.png" alt="light" width="45" />Pump activations status</h3>
	</a>
	<br>
	</p>
</head>

<head>
	<p>
	<a title="" href="Soil_moisture/">
		<h3 style="clear: both;"><img style="vertical-align:middle;" src="soil.png" alt="light" width="45" />Soil moisture status</h3>
	</a>
	<br>
	</p>
</head>
<!--
<head>
	<p>
	<a title="" href="water_alarms/">
		<h3 style="clear: both;"><img style="vertical-align:middle;" src="alarm.png" alt="light" width="45" />Water alarm status</h3>
	</a>
	<br>
	</p>
</head>
-->
<head>
	<div style="position: absolute; bottom: 5px;">
	Made by Thomas Kristiansen, Peter Hye Nielsen and Jens Christian Bech Andersen
	</div>
</head>

</body>
</html>

