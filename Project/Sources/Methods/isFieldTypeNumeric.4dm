//%attributes = {}
// isFieldTypeNumeric (->table; fieldnumber)

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
		: ($fieldType=Is real:K8:4)
			$result:=True:C214
		: ($fieldType=Is integer:K8:5)
			$result:=True:C214
		: ($fieldType=Is integer 64 bits:K8:25)
			$result:=True:C214
		: ($fieldType=Is longint:K8:6)
			$result:=True:C214
		Else 
			$result:=False:C215
			
	End case 
End if 


$0:=$result