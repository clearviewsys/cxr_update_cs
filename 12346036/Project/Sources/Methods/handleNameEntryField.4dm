//%attributes = {}
// handleNameEntryField (->fieldPtr)

C_POINTER:C301($fieldPtr; $1)
C_TEXT:C284($fullName)
$fieldPtr:=$1
$fieldPtr->:=removeEnclosingSpaces(toTitleCase($fieldPtr))

//checkCustomerFullName 

//If (($firstNamePtr->#"") & ($lastNamePtr->#""))
//$fullName:=makeFullName ($firstNamePtr->;$lastNamePtr->)
////handleCustomerNameCompliance (False;$fullName)
//End if 