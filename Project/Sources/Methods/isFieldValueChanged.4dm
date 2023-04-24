//%attributes = {}
// isFieldValueChanged ( ->field ) -> boolean

C_POINTER:C301($fieldPtr; $1)
C_BOOLEAN:C305($isChanged; $0)

Case of 
	: (Count parameters:C259=1)
		$fieldPtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Old:C35($fieldPtr->)#$fieldPtr->)
	$isChanged:=True:C214
Else 
	$isChanged:=False:C215
End if 

$0:=$isChanged