//%attributes = {}
// ColorizeIssueDate (»field;forePos;backpos;foreNeg;BackNeg)

// Colorize the field according to the sign of value

// Usually this procedure should be called for listing pct change


C_POINTER:C301($1; $datePtr)
C_LONGINT:C283($2; $3; $4; $5)
C_LONGINT:C283($forePos; $foreNeg; $backPos; $backNeg)
$datePtr:=$1

Case of 
	: (Count parameters:C259=1)
		$datePtr:=$1
		
		$forePos:=Dark grey:K11:12
		$backPos:=White:K11:1
		$foreNeg:=Red:K11:4
		$backNeg:=White:K11:1
	: (Count parameters:C259=3)
		$datePtr:=$1
		
		$backPos:=White:K11:1
		$backNeg:=White:K11:1
	: (Count parameters:C259=5)
		
		$datePtr:=$1
		$forePos:=$2
		$backPos:=$3
		$foreNeg:=$4
		$backNeg:=$5
End case 


// Modified by: Milan (12/3/2020)
If (($datePtr->>Current date:C33) & ($datePtr->#!00-00-00!))  // if the date is filled but the issue date is in a future date
	//_O_OBJECT SET COLOR($datePtr->;calcColour($foreNeg;$backNeg))
	OBJECT SET RGB COLORS:C628($datePtr->; convPalleteColourToRGB($foreNeg); convPalleteColourToRGB($backNeg))
Else 
	// _O_OBJECT SET COLOR($datePtr->;calcColour($forePos;$backPos))
	OBJECT SET RGB COLORS:C628($datePtr->; convPalleteColourToRGB($forePos); convPalleteColourToRGB($backPos))
End if 

