//%attributes = {}
// makes deep copy of MoneyGram transaction object converting 4D dates into proper MoneyGram date format

C_OBJECT:C1216($0; $outObj)
C_OBJECT:C1216($1; $inObject)
C_LONGINT:C283($i; $valueType)

$inObject:=$1
$outObj:=New object:C1471

ARRAY TEXT:C222($properties; 0)

OB GET PROPERTY NAMES:C1232($inObject; $properties)

For ($i; 1; Size of array:C274($properties))
	
	$valueType:=Value type:C1509($inObject[$properties{$i}])
	
	If ($valueType=Is object:K8:27)
		$outObj[$properties{$i}]:=mgCopyTransactionObject($inObject[$properties{$i}])
	Else 
		If ($valueType=Is date:K8:7)
			If ($inObject[$properties{$i}]#!00-00-00!)
				$outObj[$properties{$i}]:=mgGetProfixDate($inObject[$properties{$i}])
			End if 
		Else 
			$outObj[$properties{$i}]:=$inObject[$properties{$i}]
		End if 
	End if 
	
End for 

$0:=$outObj
