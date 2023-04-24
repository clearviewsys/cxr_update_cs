//%attributes = {}
//setListboxObjectProperties (->FieldPtr; Column Width; Column Title ) -> Object

C_OBJECT:C1216($listboxObject; $0)


If (Count parameters:C259<1)
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
Else 
	C_POINTER:C301($FieldPtr; $1)
	$FieldPtr:=$1
	
	$listboxObject:=New object:C1471
	$listboxObject.field:=$FieldPtr
	
	C_LONGINT:C283($ColumnWidth; $2)
	If (Count parameters:C259>=2)
		$ColumnWidth:=$2
		$listboxObject.width:=$ColumnWidth
	End if 
	
	C_TEXT:C284($ColumnTitle; $3)
	If (Count parameters:C259>=3)
		$ColumnTitle:=$3
		$listboxObject.columntitle:=$ColumnTitle
	End if 
	
	$0:=$listboxObject
End if 

