//%attributes = {}
// LaunchProcess (methodName; processName)
// ex: launchProcess("displayListBoxRegisters")

C_LONGINT:C283($Param)
C_LONGINT:C283($id)
C_TEXT:C284($1)

C_TEXT:C284($2)
$Param:=Count parameters:C259
Case of 
	: ($Param=1)
		$id:=New process:C317($1; 0; $1)
		
	: ($Param=2)
		$id:=New process:C317($1; 0; $1; $2)  // increased the process stack from 256*4098 to 
		
End case 

$0:=$id