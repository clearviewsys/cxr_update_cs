//%attributes = {}
// applyFocusRect (focusRectObjectName; {width{; colour}})
// 
C_LONGINT:C283($left; $top; $bottom; $right; $w; $2; $3; $width; $colour)
C_TEXT:C284($objectName; $1)
Case of 
	: (Count parameters:C259=0)
		$objectName:="focusRect"
		$w:=4
		
	: (Count parameters:C259=1)
		$objectName:=$1
		$w:=4
		$width:=4
	: (Count parameters:C259=2)
		$objectName:=$1
		$w:=$2
		$width:=$2
	: (Count parameters:C259=3)
		$objectName:=$1
		$w:=$2
		$colour:=$3
		
		// 
		// Modified by: Milan (12/3/2020)
		// _O_OBJECT SET COLOR(*;$objectName;$colour)
		OBJECT SET RGB COLORS:C628(*; $objectName; convPalleteColourToRGB($colour))
		
	Else 
		
End case 

If (Form event code:C388=On Getting Focus:K2:7)
	OBJECT SET VISIBLE:C603(*; $objectName; True:C214)
	
	If (Is nil pointer:C315(Focus object:C278))
		
	Else 
		OBJECT GET COORDINATES:C663(Focus object:C278->; $left; $top; $right; $bottom)
		OBJECT SET COORDINATES:C1248(*; $objectName; $left-$w; $top-$w; $right+$w; $bottom+$w)
	End if 
End if 

If (Form event code:C388=On Losing Focus:K2:8)
	OBJECT SET VISIBLE:C603(*; $objectName; False:C215)
	
End if 