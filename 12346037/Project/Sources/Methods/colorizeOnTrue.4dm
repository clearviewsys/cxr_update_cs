//%attributes = {}
// colorizeOnTrue (->field; boolean; foreTrue;backTrue;foreFalse;BackFalse)

C_POINTER:C301($1; $fieldPtr)
C_BOOLEAN:C305($2; $condition)
C_LONGINT:C283($3; $4; $5; $6)
C_LONGINT:C283($forePos; $foreNeg; $backPos; $backNeg)

$fieldPtr:=$1
$condition:=$2

Case of 
	: (Count parameters:C259=2)
		$forePos:=Dark grey:K11:12
		$backPos:=White:K11:1
		$foreNeg:=Red:K11:4
		$backNeg:=White:K11:1
	: (Count parameters:C259=4)
		$backPos:=White:K11:1
		$backNeg:=White:K11:1
	: (Count parameters:C259=6)
		$forePos:=$3
		$backPos:=$4
		$foreNeg:=$5
		$backNeg:=$6
End case 

If ($condition)
	// _O_OBJECT SET COLOR($fieldPtr->;calcColour($forePos;$backPos))
	OBJECT SET RGB COLORS:C628($fieldPtr->; convPalleteColourToRGB($forePos); convPalleteColourToRGB($backPos))
Else 
	// _O_OBJECT SET COLOR($fieldPtr->;calcColour($foreNeg;$backNeg))
	OBJECT SET RGB COLORS:C628($fieldPtr->; convPalleteColourToRGB($foreNeg); convPalleteColourToRGB($backNeg))
End if 