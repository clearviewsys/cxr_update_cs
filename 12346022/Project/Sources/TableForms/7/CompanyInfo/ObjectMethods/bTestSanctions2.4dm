C_TEXT:C284($sanctionCheckResult)
C_LONGINT:C283($match)

C_TEXT:C284($name)
setErrorTrap("Test Sanction Lists")
$name:="2ND ACADEMY OF NATURAL SCIENCES"
$name:=Request:C163("Check Company name against International Sanction lists:"; $name; "Search "; "Cancel")

If (Ok=1)
	C_POINTER:C301($null)
	$match:=slold_screenCompany(True:C214; $name; $null)
	//$sanctionCheckResult:=checkNameAgainstAllLists ($name;->$match;True;0;"";True)
	//myAlert ($sanctionCheckResult;sl_getSanctionListResultMsg ($match))
	
End if 

endErrorTrap
