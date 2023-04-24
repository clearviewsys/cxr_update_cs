C_TEXT:C284($sanctionCheckResult)
C_LONGINT:C283($match)

setErrorTrap("Test Sanction Lists")
C_TEXT:C284($name)
$name:="Jan Zada"
$name:="Ahmed Ally"
$name:="Ahmed Ahmed"
$name:=Request:C163("Check name against International Sanction lists:"; $name; "Search "; "Cancel")

If (Ok=1)
	
	var $options : cs:C1710.SanctionScreeningOptions
	$options:=cs:C1710.SanctionScreeningOptions.new()
	$options.screenGroup:="SL"
	var $result : cs:C1710.SanctionListResult
	$result:=sl_screenMainlyNameWithOptions(True:C214; $name; False:C215; Null:C1517; $options)
	If ($result.resultCode#0)
		$result.displayResults()
	End if 
	myAlert($result.resultText; sl_getSanctionListResultMsg($result.resultCode))
End if 

endErrorTrap
