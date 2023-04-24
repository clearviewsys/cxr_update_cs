//%attributes = {}
// returns first deliveryOption that matches values passed in $queryObject

C_COLLECTION:C1488($1; $quotes; $resultingCollection)
C_OBJECT:C1216($2; $queryObject)  // object holding query definition
C_OBJECT:C1216($0)  // delivery option returned
C_LONGINT:C283($i)
C_TEXT:C284($queryString)

$quotes:=$1
$queryObject:=$2

ARRAY TEXT:C222($propertyNames; 0)

OB GET PROPERTY NAMES:C1232($queryObject; $propertyNames)

$resultingCollection:=$quotes

For ($i; 1; Size of array:C274($propertyNames))
	$queryString:=$propertyNames{$i}+" = :1"
	If ($resultingCollection#Null:C1517)
		$resultingCollection:=$resultingCollection.query($queryString; $queryObject[$propertyNames{$i}])
	End if 
End for 

If ($resultingCollection#Null:C1517)
	If ($resultingCollection.length>0)
		$0:=$resultingCollection[0]
	End if 
End if 
