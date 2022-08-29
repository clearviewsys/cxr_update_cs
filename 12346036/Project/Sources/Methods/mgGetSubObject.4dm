//%attributes = {}
// returns only necessary collection of results from MoneyGram
C_OBJECT:C1216($0; $1; $parentObj)
C_TEXT:C284($2; $propertyName)
C_LONGINT:C283($i; $objType)

$parentObj:=$1
$propertyName:=$2

ARRAY TEXT:C222($properties; 0)

OB GET PROPERTY NAMES:C1232($parentObj; $properties)

For ($i; 1; Size of array:C274($properties))
	
	If ($properties{$i}=$propertyName)
		
		$objType:=OB Get type:C1230($parentObj; $properties{$i})  // we need to check for type here also because MG SOAP API returns empty text if there are no results, not an empty collection
		
		If ($objType=Is object:K8:27)
			$0:=$parentObj[$properties{$i}]
		End if 
		
		$i:=Size of array:C274($properties)+1
		
	Else 
		
		$objType:=OB Get type:C1230($parentObj; $properties{$i})
		
		If ($objType=Is object:K8:27)
			
			$0:=mgGetSubObject($parentObj[$properties{$i}]; $propertyName)
			
		End if 
		
	End if 
	
End for 
