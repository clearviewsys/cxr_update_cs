//%attributes = {}
// utils_objectToKeyCollection($object)->$collection
// Author: Wai-Kin
var $input; $1 : Object
var $collect; $0 : Collection
Case of 
	: (Count parameters:C259=1)
		$input:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
var $key : Text
var $collect : Collection
$collect:=New collection:C1472
For each ($key; $input)
	$collect.push(New object:C1471("key"; $key; "value"; $input[$key]))
End for each 
$0:=$collect