//%attributes = {}
// getFieldChangeNotes ( ->field ; { fieldName }) -> comment on change

C_POINTER:C301($fieldPtr; $1)
C_TEXT:C284($fieldName; $2; $str; $0)

Case of 
	: (Count parameters:C259=1)
		$fieldPtr:=$1
		$fieldName:=Field name:C257($fieldPtr)
		
	: (Count parameters:C259=2)
		$fieldPtr:=$1
		$fieldName:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Old:C35($fieldPtr->)#$fieldPtr->)
	$str:=$fieldName+" changed from "+String:C10(Old:C35($fieldPtr->))+" to "+String:C10($fieldPtr->)
End if 

$0:=$str