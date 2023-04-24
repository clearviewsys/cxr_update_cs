//%attributes = {}
// returns collection of property names
// there is OB Keys command in v18 R3 and later, this is the implementation of command for older
// versions of 4D and for v18 non-R releases
//
// 20201111 madamov

C_COLLECTION:C1488($0)
C_OBJECT:C1216($1)

ARRAY TEXT:C222($propertyNames; 0)

OB GET PROPERTY NAMES:C1232($1; $propertyNames)

If (Size of array:C274($propertyNames)>0)
	
	$0:=New collection:C1472
	
	ARRAY TO COLLECTION:C1563($0; $propertyNames)
	
End if 
