//%attributes = {}
var $1; $item : Object
var $2; $id : Text

Case of 
	: (Count parameters:C259=2)
		$item:=$1
		$id:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($item.value.id=$id)
	$item.result:=True:C214
End if 