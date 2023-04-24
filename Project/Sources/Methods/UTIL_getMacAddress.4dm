//%attributes = {}
C_TEXT:C284($0)
C_TEXT:C284($macAddress; $cmd; $input; $output; $error)

If (Is Windows:C1573)
	
	$cmd:="wmic bios get SerialNumber"
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
	LAUNCH EXTERNAL PROCESS:C811($cmd; $input; $output; $error)
	$macAddress:=Substring:C12($output; Position:C15("SerialNumber"; $output)+12; Length:C16($output))
	$macAddress:=Replace string:C233($macAddress; Char:C90(Carriage return:K15:38); "")
	$macAddress:=Replace string:C233($macAddress; Char:C90(Line feed:K15:40); "")
	$macAddress:=strRemoveSpaces($macAddress)
	
	If ($macAddress="")  //now try mac address
		$cmd:="ipconfig /all"
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
		LAUNCH EXTERNAL PROCESS:C811($cmd; $input; $output; $error)
		$macAddress:=Substring:C12($output; Position:C15("Physical Address"; $output)+36; 17)
	End if 
Else 
	$cmd:="system_profiler SPHardwareDataType"
	LAUNCH EXTERNAL PROCESS:C811($cmd; $input; $output; $error)
	$macAddress:=Substring:C12($output; Position:C15("Serial Number:"; $output)+14; 12)
End if 

$macAddress:=Replace string:C233($macAddress; ":"; "")
$macAddress:=Replace string:C233($macAddress; "-"; "")
$macAddress:=Substring:C12($macAddress; 1; 20)  //macAddress field is only 20 chars

$0:=$macAddress