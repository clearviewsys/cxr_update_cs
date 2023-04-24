//%attributes = {}
// removes properties from SendRequest transaction not listed in methodInfo object

C_OBJECT:C1216($1; $transaction)
C_OBJECT:C1216($2; $methodInfo)
C_LONGINT:C283($i)
C_COLLECTION:C1488($col)

$transaction:=$1
$methodInfo:=$2

ARRAY TEXT:C222($properties; 0)

OB GET PROPERTY NAMES:C1232($transaction; $properties)

For ($i; 1; Size of array:C274($properties))
	
	$col:=$methodInfo.result.RequestFields.FieldInfo.query("Name = :1"; $properties{$i})
	
	If ($col#Null:C1517)
		If ($col.length=0)
			OB REMOVE:C1226($transaction; $properties{$i})
		End if 
	Else 
		OB REMOVE:C1226($transaction; $properties{$i})
	End if 
	
End for 

$0:=$transaction
