//%attributes = {}
// Checks the existance of MoneyGram required key values
// creates defaults if they doesn't exist

C_TEXT:C284($tValue; $baseKey)

$baseKey:="mg."+getBranchID+"."

$tValue:=keyValue_getValue($baseKey+"isAllowed"; "")
If ($tValue="")
	keyValue_setValue($baseKey+"isAllowed"; "false")
	setCachedKeyValue($baseKey+"isAllowed"; "false")
End if 

$tValue:=keyValue_getValue($baseKey+"username"; "")
If ($tValue="")
	keyValue_setValue($baseKey+"username"; "lotus")
	setCachedKeyValue($baseKey+"username"; "false")
End if 

$tValue:=keyValue_getValue($baseKey+"password"; "")
If ($tValue="")
	keyValue_setValue($baseKey+"password"; "")
	setCachedKeyValue($baseKey+"password"; "")
End if 

$tValue:=keyValue_getValue($baseKey+"agentID"; "")
If ($tValue="")
	keyValue_setValue($baseKey+"agentID"; "")
	setCachedKeyValue($baseKey+"agentID"; "")
End if 

// added 2022-01-26
keyValue_setValue("mg.logSOAPCalls"; "false")
setCachedKeyValue("mg.logSOAPCalls"; "false")
