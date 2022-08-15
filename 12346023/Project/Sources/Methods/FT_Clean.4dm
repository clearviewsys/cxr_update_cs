//%attributes = {}
// FT_Clean ($text)
// Get rid invalid charaters from text
// Unit test written @Zoya
C_TEXT:C284($1; $0; $text)
C_BOOLEAN:C305($2; $spaces; $3; $comma)
Case of 
	: (Count parameters:C259=1)
		
		$text:=$1
		$spaces:=False:C215
		$comma:=False:C215
		
	: (Count parameters:C259=2)
		
		$text:=$1
		$spaces:=$2
		$comma:=False:C215
		
	: (Count parameters:C259=3)
		
		$text:=$1
		$spaces:=$2
		$comma:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$text:=Replace string:C233($text; "-"; "")
$text:=Replace string:C233($text; "+"; "")

If ($spaces)
	$text:=Replace string:C233($text; " "; "")
End if 

If ($comma)
	$text:=Replace string:C233($text; ","; "")
End if 

$text:=Replace string:C233($text; "."; "")
$text:=Replace string:C233($text; "("; "")
$text:=Replace string:C233($text; ")"; "")

$0:=$text


