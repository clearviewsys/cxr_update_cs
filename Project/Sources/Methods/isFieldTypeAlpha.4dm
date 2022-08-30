//%attributes = {}
// isFieldTypeAlpha (->table; fieldnumber)
C_POINTER:C301($tablePtr; $1)
C_LONGINT:C283($fieldNum; $fieldType; $2)
C_BOOLEAN:C305($result; $0)

Case of 
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$fieldNum:=$2
	Else 
		$tablePtr:=->[Currencies:6]
		$fieldNum:=1
End case 

If ($fieldNum>0)
	GET FIELD PROPERTIES:C258(Table:C252($tablePtr); $fieldNum; $fieldType)
	Case of 
		: ($fieldType=Is alpha field:K8:1)
			$result:=True:C214
		: ($fieldType=Is text:K8:3)
			$result:=True:C214
		Else 
			$result:=False:C215
	End case 
End if 

$0:=$result