C_TEXT:C284($name; $sanctionCheckResult)
C_LONGINT:C283($match)

setErrorTrap("Test Sanction Lists")
$name:="Jan Zada"
$name:="Ahmed Ahmed"
$name:=Request:C163("Check name against International Sanction lists:"; $name; "Search "; "Cancel")
If (Ok=1)
	
	var $options : cs:C1710.SanctionScreeningOptions
	$options:=cs:C1710.SanctionScreeningOptions.new()
	$options.screenGroup:="SL"
	var $resultObj : cs:C1710.SanctionListResult
	$resultObj:=sl_screenMainlyNameWithOptions(True:C214; $name; False:C215; Null:C1517; $options)
	
	
	If ($resultObj.resultCode#0)
		$resultObj.displayResults()
	End if 
	myAlert($resultObj.resultText; sl_getSanctionListResultMsg($resultObj.resultCode))
	
End if 




endErrorTrap
