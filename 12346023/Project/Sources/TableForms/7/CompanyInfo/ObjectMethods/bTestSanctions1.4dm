
C_TEXT:C284($result; $clientCode; $clientKey; $name)
C_LONGINT:C283($match)

$clientCode:=[CompanyInfo:7]ClientCode2:25
$clientKey:=[CompanyInfo:7]ClientKey2:26

$name:="Hillary Clinton"
$name:=Request:C163("Check name against International PEP:"; $name; "Search PEP"; "Cancel")
C_POINTER:C301($null)

If (Ok=1)
	$match:=sl_screenMainlyNameWithOptions(True:C214; $name; False:C215; $null; New object:C1471(\
		"options"; New object:C1471("list"; "PEP")\
		))
	//sl_screenPerson(True; $name; $null; New object(\
				"options"; New object("list"; "PEP")\
				))
	//handleCustomerNameCompliance(True;$name;$null;$null;"PEP")
	//setErrorTrap ("Test PEP Sanction List")
	
	//$result:=checkNameAgainstList ($name;->$match;False;"PEP";True)
	//myAlert ($result;sl_getSanctionListResultMsg ($match))
	
	//endErrorTrap
End if 