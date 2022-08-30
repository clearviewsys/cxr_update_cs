//%attributes = {}
// ColorizeExpiredDate (»field;forePos;backpos;foreNeg;BackNeg)

// Colorize the field according to the sign of value

// Usually this procedure should be called for listing pct change


C_POINTER:C301($1)
C_LONGINT:C283($2; $3; $4; $5)
C_LONGINT:C283($forePos; $foreNeg; $backPos; $backNeg)

Case of 
	: (Count parameters:C259=1)
		$forePos:=Dark grey:K11:12
		$backPos:=White:K11:1
		$foreNeg:=Red:K11:4
		$backNeg:=White:K11:1
	: (Count parameters:C259=3)
		$backPos:=White:K11:1
		$backNeg:=White:K11:1
	: (Count parameters:C259=5)
		$forePos:=$2
		$backPos:=$3
		$foreNeg:=$4
		$backNeg:=$5
End case 


// Modified by: Milan (12/3/2020)
If (($1->>Current date:C33) | ($1->=!00-00-00!))
	// _O_OBJECT SET COLOR($1->;calcColour($forePos;$backPos))
	OBJECT SET RGB COLORS:C628($1->; convPalleteColourToRGB($forePos); convPalleteColourToRGB($backPos))
Else 
	//_O_OBJECT SET COLOR($1->;calcColour($foreNeg;$backNeg))
	OBJECT SET RGB COLORS:C628($1->; convPalleteColourToRGB($foreNeg); convPalleteColourToRGB($backNeg))
End if 

