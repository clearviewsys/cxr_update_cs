//%attributes = {}
// createNoteFromChangedField ($fieldPtr; $reasonFieldPtr
// 
C_POINTER:C301($fieldPtr; $reasonFieldPtr; $1; $2)
C_TEXT:C284($3; $fieldName)

Case of 
	: (Count parameters:C259=3)
		$fieldPtr:=$1
		$reasonFieldPtr:=$2
		$fieldName:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($reason)

If ($fieldPtr->#Old:C35($fieldPtr->))  // somehow value of ON HOLD changes
	$reason:=$fieldName+" set to "+booleanToONorOFF($fieldPtr->)+". Reason: "+$reasonFieldPtr->
End if 

createNoteForCustomer([Customers:3]CustomerID:1; $reason; True:C214)
