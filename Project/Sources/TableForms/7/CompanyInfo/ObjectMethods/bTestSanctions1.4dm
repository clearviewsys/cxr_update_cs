
C_TEXT:C284($clientCode; $clientKey; $name)
C_LONGINT:C283($match)

$clientCode:=[CompanyInfo:7]ClientCode2:25
$clientKey:=[CompanyInfo:7]ClientKey2:26

$name:="Hillary Clinton"
$name:=Request:C163("Check name against International PEP:"; $name; "Search PEP"; "Cancel")
C_POINTER:C301($null)

If (Ok=1)
	var $null : Pointer
	var $result : cs:C1710.SanctionListResult
	var $options : cs:C1710.SanctionScreeningOptions
	$options:=cs:C1710.SanctionScreeningOptions.new()
	$options.screenGroup:="PEP"
	$result:=sl_screenMainlyNameWithOptions(True:C214; $name; False:C215; $null; $options)
	If ($result.resultCode#0)
		$result.displayResults()
	End if 
	myAlert($result.resultText; sl_getSanctionListResultMsg($result.resultCode))
End if 