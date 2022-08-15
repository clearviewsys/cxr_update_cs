//%attributes = {}
//Method for removing any blank fields from an object.
//Useful for cleaning up objects with many fields, most of which are blank
//Inputs: Object

C_OBJECT:C1216($1; $object)
ARRAY TEXT:C222($paramNames; 0)
C_LONGINT:C283($i)

$object:=$1

OB GET PROPERTY NAMES:C1232($object; $paramNames)

For ($i; 1; Size of array:C274($paramNames))
	If ($object[$paramNames{$i}]="")
		OB REMOVE:C1226($object; $paramNames{$i})
	End if 
End for 