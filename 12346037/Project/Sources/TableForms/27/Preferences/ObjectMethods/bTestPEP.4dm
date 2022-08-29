
C_TEXT:C284($result; $name)
C_LONGINT:C283($match)
C_POINTER:C301($null)

$name:="Hillary Clinton"
$name:=Request:C163("Check name against International PEP:"; $name; "Search PEP"; "Cancel")

If (Ok=1)
	C_OBJECT:C1216($options)
	$options:=New object:C1471
	$options.options:=New object:C1471("list"; "PEP")
	sl_screenMainlyNameWithOptions(True:C214; $name; False:C215; $null; $options)
	//sl_screenPerson(True; $name; $null; $options)
	//setErrorTrap ("Test PEP Sanction List")
	//$result:=checkNameAgainstList ($name;->$match;False;"PEP";True)
	//myAlert ($result;sl_getSanctionListResultMsg ($match))
	
	//endErrorTrap
End if 