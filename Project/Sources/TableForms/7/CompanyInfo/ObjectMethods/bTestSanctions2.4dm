C_TEXT:C284($sanctionCheckResult)
C_LONGINT:C283($match)

C_TEXT:C284($name)
setErrorTrap("Test Sanction Lists")
$name:="2ND ACADEMY OF NATURAL SCIENCES"
$name:=Request:C163("Check Company name against International Sanction lists:"; $name; "Search "; "Cancel")

If (Ok=1)
	C_POINTER:C301($null)
	var $result : cs:C1710.SanctionListResult
	$result:=sl_screenMainlyNameWithOptions(True:C214; $name; True:C214; Null:C1517)
	If ($result.resultCode#0)
		$result.displayResults()
	End if 
	myAlert($result.resultText; sl_getSanctionListResultMsg($result.resultCode))
	
End if 

endErrorTrap
