//%attributes = {}
// IdentityMind_updateResponse
// update IdentityMind JSON responses
//
// Paramters: (NONE)
//
// Return: True if no errors

// === PART 1: Setup ===

ASSERT:C1129(Count parameters:C259=0; Current method name:C684+" requires 0 paramters.")
ASSERT:C1129(Not:C34(Undefined:C82(IdentityMindResponse)))
If (Not:C34(OB Is defined:C1231(IdentityMindResponse)))
	IdentityMindResponse:=New object:C1471
End if 

// === PART 2: Send request ===

C_TEXT:C284($postfix)
$postfix:="im/account/"+IdentityMindEndpoint+"/"+IdentityMindID
C_OBJECT:C1216($json)
$json:=IdentityMind_httpRequest(HTTP GET method:K71:1; $postfix)

// === PART 3: update response ===

If ($json#Null:C1517)
	C_TEXT:C284($field)
	For each ($field; $json)
		IdentityMindResponse[$field]:=$json[$field]
	End for each 
	$0:=True:C214
Else 
	$0:=False:C215
End if 