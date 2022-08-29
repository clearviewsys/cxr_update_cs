//%attributes = {}
// colourize field (->field;boolean)
C_POINTER:C301($1)
C_BOOLEAN:C305($2; $isMandatory)
C_LONGINT:C283($R; $V; $B; $RVB)

Case of 
	: (Count parameters:C259=1)
		$isMandatory:=True:C214
	: (Count parameters:C259=2)
		$isMandatory:=$2
End case 


If ($isMandatory)
	$R:=255
	$V:=230
	$B:=230
	
	$RVB:=($R*256*256)+($V*256)+$B
	OBJECT SET RGB COLORS:C628($1->; 127; $RVB)
Else 
	uncolourizeField($1)
End if 
