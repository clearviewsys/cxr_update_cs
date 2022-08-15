//%attributes = {}
// colourizeLineBG (objectName;lineNumber;mod;flag)
// use this method to colorize the background colour of a line (different for odd and even)
// call this method inside a 'on display detail

C_LONGINT:C283($offset; $n; $mod; $2; $3; $R; $V; $B; $RVB)
C_TEXT:C284($objectName; $1)
C_BOOLEAN:C305($flagged; $4)

$offset:=0
$flagged:=False:C215
Case of 
		
	: (Count parameters:C259=0)
		$n:=Displayed line number:C897%2
		$objectName:="backstripe"
	: (Count parameters:C259=1)
		$objectName:=$1
		$n:=Displayed line number:C897%2
	: (Count parameters:C259=2)
		$objectName:=$1
		$mod:=2
		$n:=$2%$mod
	: (Count parameters:C259=3)
		$objectName:=$1
		$mod:=$3
		$n:=Displayed line number:C897%$mod
	: (Count parameters:C259=4)
		$objectName:=$1
		$mod:=$3
		$n:=Displayed line number:C897%$mod
		$flagged:=$4
		
End case 

If ($flagged)
	$offset:=25
End if 

Case of 
	: ($n=0)
		$R:=255
		$V:=255-$offset
		$B:=255
	: ($n=1)
		$R:=230
		$V:=240-$offset
		$B:=240
End case 

//If ($2>1)
//C_LONGINT($c)
//$c:=200+($2*10%50)
//$R:=$c
//$V:=$c
//$B:=$c
//End if 

$RVB:=($R*256*256)+($V*256)+$B
OBJECT SET RGB COLORS:C628(*; $objectName; 127; $RVB)
