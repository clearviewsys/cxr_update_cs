//%attributes = {}
// colourizeAlternateRows (flag;object)
C_BOOLEAN:C305($flagged; $1)
C_TEXT:C284($objectName; $2)

C_LONGINT:C283($offset; $n)
C_LONGINT:C283($R; $V; $B)
C_REAL:C285($RVB)
$objectName:="backstripe"
$offset:=0
$flagged:=False:C215
$n:=Displayed line number:C897%2

Case of 
	: (Count parameters:C259=1)
		$flagged:=$1
	: (Count parameters:C259=2)
		$flagged:=$1
		$objectName:=$2
End case 

If ($flagged)
	$offset:=50
End if 

Case of 
	: ($n=0)
		$R:=255
		$V:=255
		$B:=255
		
	: ($n=1)
		$R:=230
		$V:=230
		$B:=240
End case 
//$R:=$R-$offset
//$V:=$V-$offset
$B:=$B-$offset

$RVB:=($R*256*256)+($V*256)+$B
OBJECT SET RGB COLORS:C628(*; $objectName; 127; $RVB)
