//%attributes = {}
// isCheckBoxSwitchedON (->fieldPtr)

C_POINTER:C301($fieldPtr; $1)
C_BOOLEAN:C305($0)

Case of 
	: (Count parameters:C259=1)
		$fieldPtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ((Old:C35($fieldPtr->)=False:C215) & ($fieldPtr->=True:C214))
	$0:=True:C214
Else 
	$0:=False:C215
End if 