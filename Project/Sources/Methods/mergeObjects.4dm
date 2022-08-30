//%attributes = {}
// method returns new object as a result of merging two objects

C_OBJECT:C1216($1; $obj1; $2; $obj2)
C_OBJECT:C1216($0)
C_LONGINT:C283($3; $mergeFromWhatObject)  // used to decide value of the property from what object to keep when both objects have the same property
C_COLLECTION:C1488($col1; $col2)
C_LONGINT:C283($foundIdx)
C_TEXT:C284($property)

$obj1:=$1
$obj2:=$2

If (Count parameters:C259>2)
	$mergeFromWhatObject:=$3
Else 
	$mergeFromWhatObject:=1
End if 

ARRAY TEXT:C222($obj1Properties; 0)
ARRAY TEXT:C222($obj2Properties; 0)
ARRAY LONGINT:C221($obj1PropertyTypes; 0)
ARRAY LONGINT:C221($obj2PropertyTypes; 0)

OB GET PROPERTY NAMES:C1232($obj1; $obj1Properties; $obj1PropertyTypes)
OB GET PROPERTY NAMES:C1232($obj2; $obj2Properties; $obj2PropertyTypes)

$col1:=New collection:C1472
$col2:=New collection:C1472

ARRAY TO COLLECTION:C1563($col1; $obj1Properties)
ARRAY TO COLLECTION:C1563($col2; $obj2Properties)

$0:=New object:C1471

For each ($property; $col1)
	
	$foundIdx:=$col2.indexOf($property)
	
	If ($foundIdx=-1)
		$0[$property]:=$obj1[$property]
	Else 
		If ($mergeFromWhatObject=1)
			$0[$property]:=$obj1[$property]
		Else 
			$0[$property]:=$obj2[$property]
		End if 
		$col2.remove($foundIdx)
	End if 
	
End for each 

// go through properties from $obj2 not present in $obj1
For each ($property; $col2)
	$0[$property]:=$obj2[$property]
End for each 
