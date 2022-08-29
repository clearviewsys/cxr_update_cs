//%attributes = {}
// IdentityMind_sendData
// Send data to IdentityMind to evalutate
//
// Parameters:
// $store (C_TEXT)
//     the json without the images
// $scanData (C_Picture)
//     Image for the field "scanData"
// $backsideImageData (C_Picture)
//     Image for the field "backsideImageData"
//
// Return:
//      success or fail

// === PART 1: Setup Parameters and run asserts ===

C_BOOLEAN:C305($0)  // success/fail
C_OBJECT:C1216($1; $sent)  // data
Case of 
	: (Count parameters:C259=1)
		$sent:=$1
	Else 
		EXECUTE METHOD:C1007("assertInvalidNumberOfParams"; *; Current method name:C684; Count parameters:C259)
End case 
ASSERT:C1129(Not:C34(Undefined:C82(IdentityMindResponse)))
ASSERT:C1129(Not:C34(Undefined:C82(IdentityMindID)))


// === PART 3: Send response ===

C_TEXT:C284($postfix)
C_OBJECT:C1216($response)
IdentityMindResponse:=Null:C1517
$postfix:="im/account/"+IdentityMindEndpoint+"?graphScoreResponse=false"
$response:=IdentityMind_httpRequest(HTTP POST method:K71:2; $postfix; $sent)

// / === PART 4: Fill proccess and return variables ===

$0:=False:C215
If ($response#Null:C1517)
	IdentityMindID:=$response.mtid
	
	IdentityMindResponse:=$response
	IdentityMindInput:=$sent
	
	$0:=True:C214
Else 
	IdentityMindResponse:=Null:C1517
	IdentityMindInput:=$sent
	$0:=False:C215
End if 