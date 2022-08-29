//%attributes = {}
// getSupportTeamPassword(MAC Address) -> text

// generate a password based on today's date and time


C_TEXT:C284($0; $1)
C_TEXT:C284($randomText; $macAddress)
C_LONGINT:C283($num)
$macAddress:=$1
If ($macAddress="")
	$macAddress:=UTIL_getMacAddress
End if 
$num:=2^Day of:C23(Current date:C33)+convDate2Serial(Current date:C33)*convDate2Serial(30+Current date:C33)
$randomText:=String:C10(Current time:C178\3600)+Substring:C12(String:C10($num); 1; 4)+Substring:C12($macAddress; 8)

$0:="S"+$randomText