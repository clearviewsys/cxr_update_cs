
C_TEXT:C284($result; $name)
C_LONGINT:C283($match)
C_POINTER:C301($null)

$name:="Hillary Clinton"
$name:=Request:C163("Check name against International PEP:"; $name; "Search PEP"; "Cancel")

If (Ok=1)
	var $options : cs:C1710.SanctionScreeningOptions
	$options:=cs:C1710.SanctionScreeningOptions.new()
	$options.screenGroup:="PEP"
	var $resultObj : cs:C1710.SanctionListResult
	$resultObj:=sl_screenMainlyNameWithOptions(True:C214; $name; False:C215; $null; $options)
	
	If ($resultObj.resultCode#0)
		$resultObj.displayResults()
	End if 
	myAlert($resultObj.resultText; sl_getSanctionListResultMsg($resultObj.resultCode))
	
	//endErrorTrap
End if 