//%attributes = {}
// makeSetNameForTable (->table)
C_POINTER:C301($1)
C_TEXT:C284($0)

C_POINTER:C301($tablePtr)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$0:="$"+Table name:C256($tablePtr)+"_LBSet"

