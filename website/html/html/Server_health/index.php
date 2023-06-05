<!DOCTYPE html>
<html>
<body style="background-color:#FFF599;text-align:left">

	<head>
        <p>
		<h1 style="clear: both;"><img style="vertical-align:middle" src="../system.png" alt="Main" width="100" />Server health</h1>
        <br>
        </p>
</head>


<head>
<style>
.myDiv {
  border: 5px outset green;
  background-color: white;    
width: 600px;
  text-align: left;
}
</style>
</head>
<div class="myDiv">
	<head>
		<p>
		<h2><FONT COLOR=green>Live server status:</h2>
		<body>
			<FONT COLOR=black>
			<p style="font-family: "Lucida Grande", Verdana, Geneva; font-size: 18px;"><strong>
			<?php
				$output = shell_exec("uptime -s");
				echo ('Launch date : '.$output);
			?>
			</strong>
			</p>
			<p style="font-family: "Lucida Grande", Verdana, Geneva; font-size: 18px;"><strong>
			<?php
				$output = shell_exec("uptime -p");
				echo ('Uptime : '.$output);
			?>
			</strong>
			</p>
		</body>

		<body>
			<FONT COLOR=black>
			<p style="font-family: "Lucida Grande", Verdana, Geneva; font-size: 18px;"><strong>
			<?php
				$output = exec("/home/pi/shell_scripts/cpu_temp.sh");
				echo ('CPU temp : '.$output);
			?>
			</strong>
			</p>
		</body>

		<body>
			<FONT COLOR=black>
			<p style="font-family: "Lucida Grande", Verdana, Geneva; font-size: 18px;"><strong>
			<?php
				$output = exec("/home/pi/shell_scripts/memory_usage.sh");
				echo ('Memory usage : '.$output);
			?>
			</strong>
			</p>
		</body>
		</p>

</div>
</head>
<div class="myDiv">
<h2><FONT COLOR=green>Live Network status:</h2>
<FONT COLOR=black>
 <table>
  <tr>
    <th>Network </th>
    <th>Receive [MB]</th>
    <th>Transmit [MB]</th>
  </tr>
  <tr>
    <td>Eth0</td>
    <td>
			<?php
				$output = exec("/home/pi/shell_scripts/eth0_receive.sh");
				echo (''.$output);
			?>

</td>
    <td>
			<?php
				$output = exec("/home/pi/shell_scripts/eth0_transmit.sh");
				echo (''.$output);
			?>
</td>
  </tr>
  <tr>
    <td>wlan0</td>
    <td> 
			<?php
				$output = exec("/home/pi/shell_scripts/wlan0_receive.sh");
				echo (''.$output);
			?>
</td>
    <td>
			<?php
				$output = exec("/home/pi/shell_scripts/wlan0_transmit.sh");
				echo (''.$output);
			?>
</td>
  </tr>
</table>
</div>

<hr>
<body>
<FONT COLOR=black>
<h3>Data from the past hour</h3>
<img src="current_data.png" />

<img src="memory_data.png" />
</body>
<head>
        <p>
	<a title="" href="data/"><h2>Data base</h2>
        </p>
</head>



<a href="../index.php">Go Back</a>

</body>

<?php
	$exec("/home/pi/shell_scripts/cpu/plotplot.sh");
?>

</html>

