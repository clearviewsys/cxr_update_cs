//%attributes = {}
//collect_filterStringHelper($input;$param)
// To use in methods call from collections like collection.filter()

C_OBJECT:C1216($1; $data)
C_TEXT:C284($2; $compare)

Case of 
	: (Count parameters:C259=2)
		$data:=$1
		$compare:=$2
End case 
If (Value type:C1509($data.value)=Is text:K8:3)
	$data.result:=$data.value=$compare
End if 