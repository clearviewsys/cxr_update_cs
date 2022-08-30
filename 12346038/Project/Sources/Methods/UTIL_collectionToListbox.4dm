//%attributes = {}
// Author: Wai-Kin
#DECLARE($rawCollectionParam : Collection)->$objectCollection : Collection

var $rawCollection : Collection
$objectCollection:=New collection:C1472
Case of 
	: (Count parameters:C259=0)
		$rawCollection:=New collection:C1472("Hello"; "123"; "bed")
	: (Count parameters:C259=1)
		$rawCollection:=$rawCollectionParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

var $value

For each ($value; $rawCollection)
	$objectCollection.push(New object:C1471("value"; $value))
End for each 

