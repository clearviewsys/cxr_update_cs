C_TEXT:C284($name; $sanctionCheckResult)
C_LONGINT:C283($match)

setErrorTrap("Test Sanction Lists")
$name:="Jan Zada"
$name:="Ahmed Ahmed"
$name:=Request:C163("Check name against International Sanction lists:"; $name; "Search "; "Cancel")
If (Ok=1)
	C_POINTER:C301($null)
	sl_screenMainlyNameWithOptions(True:C214; $name; False:C215; $null)
	
	//sl_screenPerson(True; $name; $null)
	//$sanctionCheckResult:=checkNameAgainstAllLists ($name;->$match;False;0;"";True)
	//myAlert ($sanctionCheckResult;sl_getSanctionListResultMsg ($match))
	
	
End if 




endErrorTrap
