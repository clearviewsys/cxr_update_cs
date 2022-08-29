//%attributes = {}
// colourizeFieldBGiff (objectName; condition; colourTrue;colourFalse)
// this method colourizes the background of the object if a condition happens

C_TEXT:C284($1; $objectName)
C_BOOLEAN:C305($2; $condition)
C_LONGINT:C283($3; $colourOnTrue)
C_LONGINT:C283($4; $colourOnFalse)

Case of 
	: (Count parameters:C259=1)
		$objectName:=$1
		$condition:=True:C214
		$colourOnTrue:=calcRGB(255; 0; 0)  // red 
		$colourOnFalse:=calcRGB(255; 255; 255)  // white
		
	: (Count parameters:C259=2)
		$objectName:=$1
		$condition:=$2
		$colourOnTrue:=calcRGB(255; 40; 40)  // red 
		$colourOnFalse:=calcRGB(255; 255; 255)  // white 
	: (Count parameters:C259=3)
		$objectName:=$1
		$condition:=$2
		$colourOnTrue:=$3
		$colourOnFalse:=calcRGB(255; 255; 255)  // white 
	: (Count parameters:C259=4)
		$objectName:=$1
		$condition:=$2
		$colourOnTrue:=$3
		$colourOnFalse:=$4
	Else 
		$objectName:="@"
		$condition:=True:C214
		$colourOnTrue:=calcRGB(255; 0; 0)  // red  
		$colourOnFalse:=calcRGB(255; 255; 255)  // white 
		
End case 

If ($condition)
	OBJECT SET RGB COLORS:C628(*; $objectName; 0; $colourOnTrue)
Else 
	OBJECT SET RGB COLORS:C628(*; $objectName; 0; $colourOnFalse)
End if 


